import 'package:flutter/material.dart';

class PrivacyAgreementScreen extends StatelessWidget {
  const PrivacyAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Housify style background
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(70),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 13,
            ),
          ),
          child: Column(
            children: [
              // 🔹 Custom AppBar (Housify style)
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(70),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context); // Back to previous screen
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "Privacy & Agreement",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // To balance alignment
                  ],
                ),
              ),

              // 🔹 Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    "Welcome to Housify!\n\n"
                        "🔹 Privacy Policy\n"
                        "We respect your privacy and are committed to protecting "
                        "your personal data. The information we collect is used "
                        "only to improve our service.\n\n"
                        "🔹 Terms of Service\n"
                        "1. By using our service, you agree to these terms.\n"
                        "2. Your information will not be shared with third parties "
                        "without your consent.\n"
                        "3. Any disputes will be resolved according to our policy.\n\n"
                        "👉 For more details, please visit our official website.",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
