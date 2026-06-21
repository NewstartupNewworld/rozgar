import 'package:supabase_flutter/supabase_flutter.dart';

class Incident {
  final int? id;
  final String title;
  final String description;
  final String location;
  final String category;
  final String reporterName;
  final int supportCount;

  Incident({
    this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.reporterName,
    this.supportCount = 0,
  });

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      category: map['category'] ?? '',
      reporterName: map['reporter_name'] ?? 'Anonymous',
      supportCount: map['support_count'] ?? 0,
    );
  }
}

class IncidentsManager {
  static final IncidentsManager _instance = IncidentsManager._internal();
  factory IncidentsManager() => _instance;
  IncidentsManager._internal();

  final supabase = Supabase.instance.client;

  Future<List<Incident>> getIncidents() async {
    final response = await supabase
        .from('incidents')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((item) => Incident.fromMap(item)).toList();
  }

  Future<void> addIncident(Incident incident) async {
    await supabase.from('incidents').insert({
      'title': incident.title,
      'description': incident.description,
      'location': incident.location,
      'category': incident.category,
      'reporter_name': incident.reporterName,
      'support_count': 0,
    });
  }

  Future<void> addSupport(int incidentId, int currentCount) async {
    await supabase
        .from('incidents')
        .update({'support_count': currentCount + 1}).eq('id', incidentId);
  }
}