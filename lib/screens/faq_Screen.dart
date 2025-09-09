import 'package:flutter/material.dart';
import 'notification_screen.dart';
class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Keep black for the top appbar area
      body: Column(
        children: [
          // Custom AppBar with curved bottom
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Arrow
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const Text(
                    "FAQs",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
            ),
          ),

          // FAQ Body Content with white background and rounded top corners
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                children: [
                  const Text(
                    "FAQ",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Find important information and update about any recent changes and fees here.",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "General",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _faqItem("How to contact with riders ?"),
                  _faqItem("How to change my selected furniture ?"),
                  _faqItem("What is cost of each item ?"),

                  const SizedBox(height: 24),

                  const Text(
                    "Contact",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _faqItem("What is the customer care number?"),
                  _faqItem("Can I Cancel the order after one week?"),
                  _faqItem(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium."),
                  _faqItem("How to call any service now?"),

                  const SizedBox(height: 32),

                  // Go to Homepage Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Adjust this if needed
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Go to Homepage',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _faqItem(String text) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Divider(thickness: 0.5, color: Colors.grey),
      ],
    );
  }
}
