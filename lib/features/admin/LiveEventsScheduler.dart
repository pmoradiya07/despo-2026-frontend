import 'package:flutter/material.dart';
import '/services/live_event_scheduler.dart';

class LiveEventScheduler extends StatefulWidget {
  const LiveEventScheduler({super.key});

  @override
  State<LiveEventScheduler> createState() =>
      _LiveEventSchedulerState();
}

class _LiveEventSchedulerState extends State<LiveEventScheduler> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _eventAt;
  bool _isSubmitting = false;

  String _target = 'all'; // reserved for future use

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(minutes: 10)),
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
      _eventAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _createLiveEvent() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      _showError('Title and description are required');
      return;
    }

    if (_eventAt == null) {
      _showError('Please select event date and time');
      return;
    }

    if (_eventAt!.isBefore(DateTime.now())) {
      _showError('Event time must be in the future');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await AdminLiveEventService.createEvent(
        title: title,
        description: description,
        eventAt: _eventAt!,
        // idToken: null (DEV_MODE)
      );

      _titleController.clear();
      _descriptionController.clear();
      _eventAt = null;
      _target = 'all';

      _showSuccess('Live event scheduled successfully');
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.green),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Live Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Event Title',
              ),
            ),

            const SizedBox(height: 12),

            /// Description
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Event Description',
              ),
            ),

            const SizedBox(height: 16),

            /// Target (reserved)
            DropdownButtonFormField<String>(
              value: _target,
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Users')),
                DropdownMenuItem(
                  value: 'test',
                  child: Text('Test Users (future)'),
                ),
              ],
              onChanged: (val) => setState(() => _target = val!),
              decoration: const InputDecoration(
                labelText: 'Target Audience',
              ),
            ),

            const SizedBox(height: 16),

            /// Date time picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _eventAt == null
                    ? 'Pick event date & time'
                    : _eventAt!.toLocal().toString(),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDateTime,
            ),

            const Spacer(),

            /// Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _createLiveEvent,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Schedule Event'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
