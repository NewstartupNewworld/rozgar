import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class Incident {
  final int? id;
  final String title;
  final String description;
  final String location;
  final String category;
  final String reporterName;
  final int supportCount;
  final String? imageUrl;

  Incident({
    this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.reporterName,
    this.supportCount = 0,
    this.imageUrl,
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
      imageUrl: map['image_url'],
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

  Future<String?> uploadImage(Uint8List imageBytes, String fileName) async {
    try {
      final path = '${DateTime.now().millisecondsSinceEpoch}_$fileName';
      await supabase.storage.from('review-images').uploadBinary(
            path,
            imageBytes,
          );
      final publicUrl =
          supabase.storage.from('review-images').getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> addIncident(Incident incident) async {
    await supabase.from('incidents').insert({
      'title': incident.title,
      'description': incident.description,
      'location': incident.location,
      'category': incident.category,
      'reporter_name': incident.reporterName,
      'support_count': 0,
      'image_url': incident.imageUrl,
    });
  }

  Future<void> addSupport(int incidentId, int currentCount) async {
    await supabase
        .from('incidents')
        .update({'support_count': currentCount + 1}).eq('id', incidentId);
  }
}

class IncidentComment {
  final String commenterName;
  final String commentText;

  IncidentComment({
    required this.commenterName,
    required this.commentText,
  });

  factory IncidentComment.fromMap(Map<String, dynamic> map) {
    return IncidentComment(
      commenterName: map['commenter_name'] ?? 'Anonymous',
      commentText: map['comment_text'] ?? '',
    );
  }
}

class IncidentCommentsManager {
  static final IncidentCommentsManager _instance =
      IncidentCommentsManager._internal();
  factory IncidentCommentsManager() => _instance;
  IncidentCommentsManager._internal();

  final supabase = Supabase.instance.client;

  Future<List<IncidentComment>> getComments(int incidentId) async {
    final response = await supabase
        .from('incident_comments')
        .select()
        .eq('incident_id', incidentId)
        .order('created_at', ascending: true);

    return (response as List)
        .map((item) => IncidentComment.fromMap(item))
        .toList();
  }

  Future<void> addComment(
      int incidentId, String commenterName, String commentText) async {
    await supabase.from('incident_comments').insert({
      'incident_id': incidentId,
      'commenter_name': commenterName,
      'comment_text': commentText,
    });
  }
}