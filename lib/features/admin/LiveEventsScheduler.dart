import 'package:flutter/material.dart';
import '../../services/live_admin_services.dart';
import '../services/live_admin_services.dart';

class LiveEventScheduler extends StatefulWidget {
  const LiveEventScheduler({super.key});

  @override
  State<LiveEventScheduler> createState() => _LiveEventSchedulerState();
}

class _LiveEventSchedulerState extends State<LiveEventScheduler> {
  final _titleController = TextEditingController();
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();
  final _venueController = TextEditingController();

  DateTime? _startTime;
  DateTime? _endTime;

  String _sport = 'cricket';
  bool _isVisible = true;
  bool _isSubmitting = false;

  Future<DateTime?> _pickDateTime(String label) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(minutes: 10)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _createEvent() async {
    if (_titleController.text.trim().isEmpty ||
        _teamAController.text.trim().isEmpty ||
        _teamBController.text.trim().isEmpty ||
        _venueController.text.trim().isEmpty ||
        _startTime == null ||
        _endTime == null) {
      _showError('All fields are required');
      return;
    }

    if (!_startTime!.isBefore(_endTime!)) {
      _showError('Start time must be before end time');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await LiveEventAdminService.instance.createLiveEvent(
        adminUid: 'DEV_ADMIN', // replace later
        event: LiveEvent(
          id: '',
          sport: _sport,
          title: _titleController.text.trim(),
          teamA: _teamAController.text.trim(),
          teamB: _teamBController.text.trim(),
          venue: _venueController.text.trim(),
          startTime: _startTime!,
          endTime: _endTime!,
          status: 'upcoming', // ignored by UI
          isVisible: _isVisible,
        ),
      );

      _clearForm();
      _showSuccess('Event created');
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  void _clearForm() {
    _titleController.clear();
    _teamAController.clear();
    _teamBController.clear();
    _venueController.clear();
    _startTime = null;
    _endTime = null;
    _sport = 'cricket';
    _isVisible = true;
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
    _teamAController.dispose();
    _teamBController.dispose();
    _venueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Live Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Event Title'),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _sport,
              decoration: const InputDecoration(labelText: 'Sport'),
              items: allowedSports
                  .map(
                    (s) => DropdownMenuItem(
                  value: s,
                  child: Text(s.toUpperCase()),
                ),
              )
                  .toList(),
              onChanged: (v) => setState(() => _sport = v!),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _teamAController,
              decoration: const InputDecoration(labelText: 'Team A'),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _teamBController,
              decoration: const InputDecoration(labelText: 'Team B'),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _venueController,
              decoration: const InputDecoration(labelText: 'Venue'),
            ),
            const SizedBox(height: 16),

            ListTile(
              title: Text(
                _startTime == null
                    ? 'Pick start time'
                    : 'Start: $_startTime',
              ),
              trailing: const Icon(Icons.schedule),
              onTap: () async {
                final t = await _pickDateTime('Start');
                if (t != null) setState(() => _startTime = t);
              },
            ),

            ListTile(
              title: Text(
                _endTime == null
                    ? 'Pick end time'
                    : 'End: $_endTime',
              ),
              trailing: const Icon(Icons.schedule),
              onTap: () async {
                final t = await _pickDateTime('End');
                if (t != null) setState(() => _endTime = t);
              },
            ),

            SwitchListTile(
              value: _isVisible,
              onChanged: (v) => setState(() => _isVisible = v),
              title: const Text('Visible to users'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _isSubmitting ? null : _createEvent,
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
