import 'package:flutter/material.dart';

class FormGuideScreen extends StatelessWidget {
  final String category;
  const FormGuideScreen({super.key, required this.category});

  List<Map<String, String>> getSteps() {
    final guides = {
      'SSC': [
        {
          'step': 'Step 1',
          'title': 'Register on SSC Portal',
          'detail':
              'Go to ssc.gov.in and click "Register Now". Fill in your name, date of birth, email, and mobile number. You will receive a registration ID and password.',
        },
        {
          'step': 'Step 2',
          'title': 'Fill Application Form',
          'detail':
              'Login with your registration ID. Select the exam you want to apply for. Fill in personal details, educational qualifications, and category (General/OBC/SC/ST).',
        },
        {
          'step': 'Step 3',
          'title': 'Upload Documents',
          'detail':
              'Upload a recent passport-size photo (20-50 KB, JPG format) and your signature (10-20 KB, JPG format). Make sure they are clear and within size limits.',
        },
        {
          'step': 'Step 4',
          'title': 'Pay Application Fee',
          'detail':
              'Pay ₹100 online via net banking, debit/credit card, or UPI. Women, SC/ST, and ex-servicemen candidates are exempted from fees.',
        },
        {
          'step': 'Step 5',
          'title': 'Submit and Save',
          'detail':
              'Review all details carefully before final submission. Download and save the confirmation page and application form for future reference.',
        },
      ],
      'Railway': [
        {
          'step': 'Step 1',
          'title': 'Visit RRB Official Website',
          'detail':
              'Go to your regional RRB website (e.g., rrbmumbai.gov.in). Each railway zone has its own website. Find the notification for the post you want to apply for.',
        },
        {
          'step': 'Step 2',
          'title': 'Register and Create Account',
          'detail':
              'Click "New Registration". Enter your name, mobile number, email, and date of birth. An OTP will be sent to your mobile for verification.',
        },
        {
          'step': 'Step 3',
          'title': 'Fill Personal and Educational Details',
          'detail':
              'Enter your 10th/12th/graduation marks, ITI certificate details (if applicable), community certificate details, and preferred exam language.',
        },
        {
          'step': 'Step 4',
          'title': 'Upload Photo and Signature',
          'detail':
              'Photo: 20-50 KB, passport size with white background. Signature: 10-40 KB on white paper. Both must be in JPG/JPEG format.',
        },
        {
          'step': 'Step 5',
          'title': 'Pay Fee and Submit',
          'detail':
              'Pay ₹500 (refunded after CBT for eligible candidates) online. SC/ST/Women/Minorities/EBC pay ₹250. Submit and download the application PDF.',
        },
      ],
      'UPSC': [
        {
          'step': 'Step 1',
          'title': 'Register on UPSCONLINE Portal',
          'detail':
              'Go to upsconline.nic.in. Click "Online Application for Various Examinations of UPSC". Register with your email and mobile number.',
        },
        {
          'step': 'Step 2',
          'title': 'Fill Part I of Application',
          'detail':
              'Enter personal details, educational qualification, and select the number of attempts. Choose your optional subject (for Mains) and preferred exam center.',
        },
        {
          'step': 'Step 3',
          'title': 'Upload Photo and Signature',
          'detail':
              'Photo: 300x300 pixels, 20-300 KB. Signature: 300x80 pixels, 10-100 KB. Both in JPG format. Your face should be clearly visible in the photo.',
        },
        {
          'step': 'Step 4',
          'title': 'Fill Part II and Pay Fee',
          'detail':
              'Pay ₹100 via SBI net banking/cash or Visa/Master/RuPay card. Women, SC/ST, and PwBD candidates are exempted. Keep payment receipt safe.',
        },
        {
          'step': 'Step 5',
          'title': 'Print Application Form',
          'detail':
              'After submission, print the application form. Keep it safe — you may need to present it at the exam center along with a valid photo ID.',
        },
      ],
      'Banking': [
        {
          'step': 'Step 1',
          'title': 'Visit IBPS or Bank Website',
          'detail':
              'For IBPS exams, go to ibps.in. For SBI, go to sbi.co.in/careers. Find the notification for PO, Clerk, or SO post you want to apply for.',
        },
        {
          'step': 'Step 2',
          'title': 'Register with Basic Details',
          'detail':
              'Enter your name (as in Class 10 certificate), date of birth, email, and mobile number. Save your provisional registration number and password.',
        },
        {
          'step': 'Step 3',
          'title': 'Fill Application Form',
          'detail':
              'Enter educational qualifications (graduation percentage is important), work experience if any, category details, and select the exam center state.',
        },
        {
          'step': 'Step 4',
          'title': 'Upload Documents',
          'detail':
              'Photo: 4.5x3.5 cm, 20-50 KB. Signature: 3.5x1.5 cm, 10-20 KB. Left thumb impression and a handwritten declaration may also be required.',
        },
        {
          'step': 'Step 5',
          'title': 'Pay Fee and Submit',
          'detail':
              'General/OBC: ₹850. SC/ST/PwD: ₹175. Pay via debit/credit card, net banking, or UPI. Take a printout of the final submitted form.',
        },
      ],
    };
    return guides[category] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final steps = getSteps();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          '$category Application Guide',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['title']!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        step['detail']!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}