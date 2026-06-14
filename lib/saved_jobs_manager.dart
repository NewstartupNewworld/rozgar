import 'job_model.dart';

class SavedJobsManager {
  static final SavedJobsManager _instance = SavedJobsManager._internal();
  factory SavedJobsManager() => _instance;
  SavedJobsManager._internal();

  final List<Job> savedJobs = [];

  void toggleSave(Job job) {
    if (savedJobs.contains(job)) {
      savedJobs.remove(job);
    } else {
      savedJobs.add(job);
    }
  }

  bool isSaved(Job job) {
    return savedJobs.contains(job);
  }
}