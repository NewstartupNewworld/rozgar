import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudyMaterialScreen extends StatelessWidget {
  const StudyMaterialScreen({super.key});

  final List<Map<String, String>> resources = const [
    {
      'category': 'SSC',
      'description': 'Previous year papers, syllabus, mock tests',
      'link': 'https://ssc.nic.in',
    },
    {
      'category': 'Railway',
      'description': 'RRB exam pattern, syllabus, practice sets',
      'link': 'https://indianrailways.gov.in',
    },
    {
      'category': 'UPSC',
      'description': 'Civil services study material, current affairs',
      'link': 'https://upsc.gov.in',
    },
    {
      'category': 'Banking',
      'description': 'IBPS/SBI exam preparation resources',
      'link': 'https://ibps.in',
    },
    {
      'category': 'Defence',
      'description': 'NDA, CDS exam guides and physical fitness tips',
      'link': 'https://joinindianarmy.nic.in',
    },
    {
      'category': 'Teaching',
      'description': 'CTET, TET preparation material',
      'link': 'https://ctet.nic.in',
    },
    {
      'category': 'Medical',
      'description': 'NEET, medical exam resources',
      'link': 'https://nta.ac.in',
    },
    {
      'category': 'Sports',
      'description': 'Fitness tests, sports quota guidelines',
      'link': 'https://sportsauthorityofindia.nic.in',
    },
  ];

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
    return Container(
      color: Colors.grey.shade50,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        children: [
          const Text(
            'Study Material',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Free resources to help you prepare',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          ...resources.map((item) => GestureDetector(
                onTap: () => openLink(item['link']!),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.menu_book,
                            color: Colors.blue, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['category']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['description']!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.grey.shade400),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}