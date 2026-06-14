import 'package:flutter/material.dart';
import 'job_card.dart';
import 'jobs_data.dart';
import 'job_model.dart';
import 'saved_jobs_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rozgar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const RozgarApp(),
    );
  }
}

class RozgarApp extends StatefulWidget {
  const RozgarApp({super.key});

  @override
  State<RozgarApp> createState() => _RozgarAppState();
}

class _RozgarAppState extends State<RozgarApp> {
  int currentIndex = 0;

  final List<Widget> screens = [
  const HomeScreen(),
  const SavedJobsScreen(),
  const ProfileScreen(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Rozgar - Find Govt Jobs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';
  List<Job> filteredJobs = sampleJobs;

  final List<String> categories = [
    'All',
    'SSC',
    'Railway',
    'UPSC',
    'Banking',
    'Defence',
  ];

  void filterJobs() {
    setState(() {
      filteredJobs = sampleJobs.where((job) {
        final matchesSearch =
            job.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                job.organization
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase());
        final matchesCategory = selectedCategory == 'All' ||
            job.title.contains(selectedCategory) ||
            job.organization.contains(selectedCategory);
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void onSearchChanged(String query) {
    searchQuery = query;
    filterJobs();
  }

  void onCategorySelected(String category) {
    selectedCategory = category;
    filterJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          color: Colors.blue.shade50,
          child: const Column(
            children: [
              Icon(Icons.work, size: 60, color: Colors.blue),
              SizedBox(height: 10),
              Text(
                'Welcome to Rozgar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Find your dream government job',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search jobs...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) => onCategorySelected(category),
                  selectedColor: Colors.blue.shade100,
                  checkmarkColor: Colors.blue,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${filteredJobs.length} jobs found',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Expanded(
          child: filteredJobs.isEmpty
              ? const Center(
                  child: Text(
                    'No jobs found!',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: filteredJobs.length,
                  itemBuilder: (context, index) {
                    return JobCard(job: filteredJobs[index]);
                  },
                ),
        ),
      ],
    );
  }
}