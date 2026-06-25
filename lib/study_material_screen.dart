import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'form_guide_screen.dart';

class StudyMaterialScreen extends StatelessWidget {
  const StudyMaterialScreen({super.key});

  final List<Map<String, dynamic>> resources = const [
    {
      'category': 'SSC',
      'description': 'Previous year papers, syllabus, mock tests',
      'link': 'https://ssc.nic.in',
      'icon': Icons.assignment,
      'color': Color(0xFF1E88E5),
    },
    {
      'category': 'Railway',
      'description': 'RRB exam pattern, syllabus, practice sets',
      'link': 'https://indianrailways.gov.in',
      'icon': Icons.train,
      'color': Color(0xFF43A047),
    },
    {
      'category': 'UPSC',
      'description': 'Civil services study material, current affairs',
      'link': 'https://upsc.gov.in',
      'icon': Icons.account_balance,
      'color': Color(0xFF8E24AA),
    },
    {
      'category': 'Banking',
      'description': 'IBPS/SBI exam preparation resources',
      'link': 'https://ibps.in',
      'icon': Icons.account_balance_wallet,
      'color': Color(0xFFE53935),
    },
    {
      'category': 'Defence',
      'description': 'NDA, CDS exam guides and fitness tips',
      'link': 'https://joinindianarmy.nic.in',
      'icon': Icons.shield,
      'color': Color(0xFF00897B),
    },
    {
      'category': 'Teaching',
      'description': 'CTET, TET preparation material',
      'link': 'https://ctet.nic.in',
      'icon': Icons.school,
      'color': Color(0xFFF4511E),
    },
    {
      'category': 'Medical',
      'description': 'Nursing, lab tech, medical exam resources',
      'link': 'https://nta.ac.in',
      'icon': Icons.local_hospital,
      'color': Color(0xFFD81B60),
    },
    {
      'category': 'Sports',
      'description': 'Fitness tests, sports quota guidelines',
      'link': 'https://sportsauthorityofindia.nic.in',
      'icon': Icons.sports_soccer,
      'color': Color(0xFF3949AB),
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
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Study Material',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Free resources to help you prepare',
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final item = resources[index];
              final color = item['color'] as Color;
              return GestureDetector(
                onTap: () {
                  // 'Defence' added — all 8 categories now show the guide sheet
                  final guidedCategories = [
                    'SSC', 'Railway', 'UPSC', 'Banking',
                    'Defence', 'Teaching', 'Medical', 'Sports'
                  ];
                  if (guidedCategories.contains(item['category'])) {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item['category'] as String,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.list_alt,
                                    color: Colors.white),
                                label: const Text(
                                    'How to Fill Application Form',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FormGuideScreen(
                                          category:
                                              item['category'] as String),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.open_in_new),
                                label: const Text('Visit Official Website',
                                    style: TextStyle(fontSize: 15)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  openLink(item['link'] as String);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    openLink(item['link'] as String);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['category'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['description'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Minimal arrow — removed the coloured circle background
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(Icons.arrow_forward,
                            color: color, size: 18),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}