class Review {
  final String reviewerName;
  final int rating;
  final String comment;

  Review({
    required this.reviewerName,
    required this.rating,
    required this.comment,
  });
}

class ReviewsManager {
  static final ReviewsManager _instance = ReviewsManager._internal();
  factory ReviewsManager() => _instance;
  ReviewsManager._internal();

  final Map<String, List<Review>> reviewsByOrg = {};

  List<Review> getReviews(String organization) {
    return reviewsByOrg[organization] ?? [];
  }

  void addReview(String organization, Review review) {
    if (!reviewsByOrg.containsKey(organization)) {
      reviewsByOrg[organization] = [];
    }
    reviewsByOrg[organization]!.add(review);
  }

  double getAverageRating(String organization) {
    final reviews = getReviews(organization);
    if (reviews.isEmpty) return 0;
    final total = reviews.fold(0, (sum, r) => sum + r.rating);
    return total / reviews.length;
  }
}