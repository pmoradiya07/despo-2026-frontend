import 'package:flutter/material.dart';
import '../../services/notification_service.dart';
import '../services/live_admin_services.dart';

class NotificationsScheduler extends StatefulWidget {
  const NotificationsScheduler({super.key});

  @override
  State<NotificationsScheduler> createState() =>
      _NotificationsSchedulerState();
}

class _NotificationsSchedulerState extends State<NotificationsScheduler> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  bool _isSending = false;

  // Kept for UI compatibility (not used yet)
  String _target = 'all'; // all | test

  Future<void> _sendNotification() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and body are required')),
      );
      return;
    }

    setState(() => _isSending = true);

    try {
      await AdminNotificationService.sendNotification(
        title: title,
        body: body,
        // idToken: null (DEV_MODE)
      );

      _titleController.clear();
      _bodyController.clear();
      _target = 'all';

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification sent successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
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

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendNotification,
                child: _isSending
                    ? const CircularProgressIndicator()
                    : const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
