import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'job_model.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({super.key, required this.job});

  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Job Details',
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
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job.organization,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
           infoRow(Icons.location_on, 'Location', job.location),
infoRow(Icons.calendar_today, 'Last Date', job.lastDate),
infoRow(Icons.category, 'Category', job.category),
const SizedBox(height: 20),
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.orange.shade50,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.orange.shade100),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
          const SizedBox(width: 8),
          Text(
            'Exam Centre Info',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.orange.shade700,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(
        job.examInfo,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
          height: 1.4,
        ),
      ),
      const SizedBox(height: 12),
      GestureDetector(
        onTap: () => openLink(
            'https://www.google.com/maps/search/${Uri.encodeComponent(job.location)}'),
        child: Row(
          children: [
            Icon(Icons.map_outlined, color: Colors.blue.shade700, size: 18),
            const SizedBox(width: 6),
            Text(
              'View ${job.location} on Map',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => openLink(job.applyLink),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}