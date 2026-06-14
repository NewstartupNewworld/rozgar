class Job {
  final String title;
  final String organization;
  final String location;
  final String lastDate;
  final String category;
  final String applyLink;
  final bool isGovernment;

  Job({
    required this.title,
    required this.organization,
    required this.location,
    required this.lastDate,
    required this.category,
    required this.applyLink,
    this.isGovernment = true,
  });
}