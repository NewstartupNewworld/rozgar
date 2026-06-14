import 'package:flutter/material.dart';
import 'job_card.dart';
import 'saved_jobs_manager.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({super.key});

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  final SavedJobsManager savedManager = SavedJobsManager();

  @override
  Widget build(BuildContext context) {
    final savedJobs = savedManager.savedJobs;

    if (savedJobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_outline, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text(
              'No saved jobs yet!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the bookmark icon on any job to save it',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: savedJobs.length,
      itemBuilder: (context, index) {
        return JobCard(job: savedJobs[index]);
      },
    );
  }
}