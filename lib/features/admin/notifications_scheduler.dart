import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationsScheduler extends StatefulWidget {
  const NotificationsScheduler({super.key});

  @override
  State<NotificationsScheduler> createState() =>
      _NotificationsSchedulerState();
}

class _NotificationsSchedulerState extends State<NotificationsScheduler> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  bool _isScheduled = false;
  DateTime? _scheduledAt;
  String _target = 'all'; // all | test

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      _scheduledAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _sendNotification() async {
    if (_titleController.text.trim().isEmpty ||
        _bodyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and body are required')),
      );
      return;
    }

    if (_isScheduled && _scheduledAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick schedule time')),
      );
      return;
    }

    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Admin not authenticated')),
      );
      return;
    }

    await FirebaseFirestore.instance
        .collection('notifications')
        .add({
      'title': _titleController.text.trim(),
      'body': _bodyController.text.trim(),

      'target': _target, // all | test
      'targetMeta': {
        'segmentId': null,
      },

      'type': _isScheduled ? 'scheduled' : 'immediate',
      'scheduledAt':
      _isScheduled ? Timestamp.fromDate(_scheduledAt!) : null,

      'status': 'pending',

      'createdBy': uid,
      'createdAt': FieldValue.serverTimestamp(),

      'sentAt': null,
      'failureReason': null,

      'stats': {
        'success': 0,
        'failure': 0,
      },
    });

    _titleController.clear();
    _bodyController.clear();
    setState(() {
      _isScheduled = false;
      _scheduledAt = null;
      _target = 'all';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification queued')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Notification')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bodyController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Message',
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _target,
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Users')),
                DropdownMenuItem(value: 'test', child: Text('Test Users')),
              ],
              onChanged: (val) => setState(() => _target = val!),
              decoration: const InputDecoration(labelText: 'Target'),
            ),

            const SizedBox(height: 16),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Schedule notification'),
              value: _isScheduled,
              onChanged: (val) => setState(() => _isScheduled = val),
            ),

            if (_isScheduled)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _scheduledAt == null
                      ? 'Pick date & time'
                      : _scheduledAt.toString(),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDateTime,
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendNotification,
                child: const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
