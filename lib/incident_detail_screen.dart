import 'package:flutter/material.dart';
import 'incident_model.dart';

class IncidentDetailScreen extends StatefulWidget {
  final Incident incident;

  const IncidentDetailScreen({super.key, required this.incident});

  @override
  State<IncidentDetailScreen> createState() => _IncidentDetailScreenState();
}

class _IncidentDetailScreenState extends State<IncidentDetailScreen> {
  final IncidentCommentsManager commentsManager = IncidentCommentsManager();
  final IncidentsManager incidentsManager = IncidentsManager();
  List<IncidentComment> comments = [];
  bool isLoading = true;
  late int currentSupportCount;

  @override
  void initState() {
    super.initState();
    currentSupportCount = widget.incident.supportCount;
    loadComments();
  }

  Future<void> loadComments() async {
    if (widget.incident.id == null) return;
    setState(() {
      isLoading = true;
    });
    final fetched = await commentsManager.getComments(widget.incident.id!);
    setState(() {
      comments = fetched;
      isLoading = false;
    });
  }

  Future<void> support() async {
    if (widget.incident.id == null) return;
    await incidentsManager.addSupport(widget.incident.id!, currentSupportCount);
    setState(() {
      currentSupportCount++;
    });
  }

  void openAddCommentSheet() {
    final nameController = TextEditingController();
    final commentController = TextEditingController();
    bool isSubmitting = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Comment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Your comment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isSubmitting
                          ? null
                          : () async {
                              if (nameController.text.isEmpty ||
                                  commentController.text.isEmpty ||
                                  widget.incident.id == null) {
                                return;
                              }
                              setSheetState(() {
                                isSubmitting = true;
                              });
                              await commentsManager.addComment(
                                widget.incident.id!,
                                nameController.text,
                                commentController.text,
                              );
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                              await loadComments();
                            },
                      child: isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Post Comment',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final incident = widget.incident;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
        title: const Text(
          'Incident Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                incident.category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              incident.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: 16, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text(incident.location,
                    style: TextStyle(color: Colors.grey.shade600)),
                const SizedBox(width: 16),
                Icon(Icons.person_outline,
                    size: 16, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text(incident.reporterName,
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              incident.description,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
            if (incident.imageUrl != null) ...[
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  incident.imageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const SizedBox(height: 16),
            GestureDetector(
              onTap: support,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite, size: 18, color: Colors.blue.shade700),
                    const SizedBox(width: 6),
                    Text(
                      'Support ($currentSupportCount)',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments (${comments.length})',
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: openAddCommentSheet,
                  child: const Text('+ Add Comment'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (comments.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'No comments yet. Be the first to respond!',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              )
            else
              ...comments.map((comment) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.commenterName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          comment.commentText,
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 13),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}