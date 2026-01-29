const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();


exports.onNotificationUpdated = functions.firestore
    .document("notifications/{id}")
    .onUpdate(async (change) => {
      const before = change.before.data();
      const after = change.after.data();
      const ref = change.after.ref;

      // React only to status changes → pending
      if (before.status === after.status) {
        return null;
      }

      if (after.status !== "pending") {
        return null;
      }

      // Guard: scheduled but not due yet
      if (
        after.type === "scheduled" &&
        after.scheduledAt &&
        after.scheduledAt.toDate() > new Date()
      ) {
        return null;
      }

      // Lock document
      await ref.update({status: "processing"});

      try {
        const tokens = await getTargetTokens(after.target);

        if (tokens.length === 0) {
          throw new Error("No target tokens found");
        }

        const response = await messaging.sendEachForMulticast({
          tokens: tokens,
          notification: {
            title: after.title,
            body: after.body,
          },
        });

        await ref.update({
          status: "sent",
          sentAt: admin.firestore.FieldValue.serverTimestamp(),
          stats: {
            success: response.successCount,
            failure: response.failureCount,
          },
        });
      } catch (err) {
        await ref.update({
          status: "failed",
          failureReason: err.message,
        });
      }

      return null;
    });

/**
 * Resolves FCM tokens for a given target group.
 * @param {string} target Target audience (all | test)
 * @return {Promise<string[]>} Array of FCM tokens
 */
async function getTargetTokens(target) {
  let query = db.collection("users");

  if (target === "test") {
    query = query.where("isTestUser", "==", true);
  }

  const snap = await query.get();
  const tokens = [];

  snap.forEach((doc) => {
    const token = doc.data().fcmToken;
    if (token) {
      tokens.push(token);
    }
  });

  return tokens;
}

/**
 * Cron job that promotes due scheduled notifications.
 */
exports.scheduledNotificationRunner = functions.pubsub
    .schedule("every 1 minutes")
    .onRun(async () => {
      const now = admin.firestore.Timestamp.now();

      const snap = await db
          .collection("notifications")
          .where("type", "==", "scheduled")
          .where("status", "==", "pending")
          .where("scheduledAt", "<=", now)
          .get();

      if (snap.empty) {
        return null;
      }

      const batch = db.batch();

      snap.docs.forEach((doc) => {
        batch.update(doc.ref, {status: "queued"});
      });

      await batch.commit();

      const queuedSnap = await db
          .collection("notifications")
          .where("status", "==", "queued")
          .get();

      const reBatch = db.batch();

      queuedSnap.docs.forEach((doc) => {
        reBatch.update(doc.ref, {status: "pending"});
      });

      await reBatch.commit();

      return null;
    });
