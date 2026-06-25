import 'package:shared_preferences/shared_preferences.dart';
import 'job_model.dart';
import 'jobs_data.dart';

class SavedJobsManager {
  static final SavedJobsManager _instance = SavedJobsManager._internal();
  factory SavedJobsManager() => _instance;
  SavedJobsManager._internal();

  static const String _key = 'saved_job_links';

  // In-memory cache of saved apply links for fast synchronous lookups.
  // Why a Set? Sets have O(1) lookup (instant), Lists have O(n) (slow with many jobs).
  final Set<String> _savedLinks = {};

  // Called once from main() before runApp() so the saved list is
  // loaded from disk before the UI renders. This is why main() is async.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? [];
    _savedLinks.clear();
    _savedLinks.addAll(stored);
  }

  // Rebuild the saved Job objects from sampleJobs using the saved links.
  // Why not store the whole Job? SharedPreferences only stores simple types
  // (strings, ints, bools). So we store just the applyLink (unique per job)
  // and look up the full Job from sampleJobs when needed.
  List<Job> get savedJobs {
    return sampleJobs
        .where((job) => _savedLinks.contains(job.applyLink))
        .toList();
  }

  void toggleSave(Job job) {
    if (_savedLinks.contains(job.applyLink)) {
      _savedLinks.remove(job.applyLink);
    } else {
      _savedLinks.add(job.applyLink);
    }
    _persist(); // fire-and-forget — updates disk in background
  }

  bool isSaved(Job job) {
    return _savedLinks.contains(job.applyLink);
  }

  // Writes the current set of links to SharedPreferences.
  // Called after every toggle so the state is always up to date on disk.
  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _savedLinks.toList());
  }
}