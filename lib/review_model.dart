import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class Review {
  final String reviewerName;
  final int rating;
  final String comment;
  final String? imageUrl;

  Review({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    this.imageUrl,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewerName: map['reviewer_name'] ?? 'Anonymous',
      rating: map['rating'] ?? 0,
      comment: map['comment'] ?? '',
      imageUrl: map['image_url'],
    );
  }
}

class ReviewsManager {
  static final ReviewsManager _instance = ReviewsManager._internal();
  factory ReviewsManager() => _instance;
  ReviewsManager._internal();

  final supabase = Supabase.instance.client;

  Future<List<Review>> getReviews(String organization) async {
    final response = await supabase
        .from('reviews')
        .select()
        .eq('organization', organization)
        .order('created_at', ascending: false);

    return (response as List).map((item) => Review.fromMap(item)).toList();
  }

  Future<String?> uploadImage(Uint8List imageBytes, String fileName) async {
    try {
      final path =
          '${DateTime.now().millisecondsSinceEpoch}_$fileName';
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

  Future<void> addReview(String organization, Review review) async {
    await supabase.from('reviews').insert({
      'organization': organization,
      'reviewer_name': review.reviewerName,
      'rating': review.rating,
      'comment': review.comment,
      'image_url': review.imageUrl,
    });
  }

  Future<double> getAverageRating(String organization) async {
    final reviews = await getReviews(organization);
    if (reviews.isEmpty) return 0;
    final total = reviews.fold(0, (sum, r) => sum + r.rating);
    return total / reviews.length;
  }
}