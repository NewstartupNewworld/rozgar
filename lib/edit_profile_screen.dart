import 'package:flutter/material.dart';

class UserProfile {
  static final UserProfile _instance = UserProfile._internal();
  factory UserProfile() => _instance;
  UserProfile._internal();

  String name = '';
  String education = '';
  String age = '';
  String preferredCategory = '';
  String preferredLocation = '';
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserProfile profile = UserProfile();
  late TextEditingController nameController;
  late TextEditingController educationController;
  late TextEditingController ageController;
  late TextEditingController categoryController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: profile.name);
    educationController = TextEditingController(text: profile.education);
    ageController = TextEditingController(text: profile.age);
    categoryController = TextEditingController(text: profile.preferredCategory);
    locationController = TextEditingController(text: profile.preferredLocation);
  }

  void saveProfile() {
    profile.name = nameController.text;
    profile.education = educationController.text;
    profile.age = ageController.text;
    profile.preferredCategory = categoryController.text;
    profile.preferredLocation = locationController.text;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildField('Full Name', nameController, Icons.person),
          buildField('Education (e.g., B.A, B.Sc, 12th Pass)', educationController, Icons.school),
          buildField('Date of Birth / Age', ageController, Icons.cake),
          buildField('Preferred Category (e.g., SSC, Railway)', categoryController, Icons.category),
          buildField('Preferred Location (e.g., Delhi, All India)', locationController, Icons.location_on),
          const SizedBox(height: 20),
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
              onPressed: saveProfile,
              child: const Text('Save Profile',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}