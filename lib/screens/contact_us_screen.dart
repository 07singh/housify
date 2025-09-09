import 'package:flutter/material.dart';
import 'support_chat_screen.dart';
import 'faq_Screen.dart';
import 'notification_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactUsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32.0),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Please choose what types of support do you need and let us know.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 28),

            // Row 1: Support Chat + Call Center
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupportChatScreen(),
                        ),
                      );
                    },
                    child: _buildOptionCard(
                      bgColor: Colors.green[100],
                      iconColor: Colors.green[300],
                      icon: Icons.chat,
                      title: 'Support Chat',
                      subtitle: '24x7 Online Support',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildOptionCard(
                    bgColor: Colors.orange[100],
                    iconColor: Colors.orange[300],
                    icon: Icons.phone,
                    title: 'Call Center',
                    subtitle: '24x7 Customer Service',
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Row 2: Email + FAQ
            Row(
              children: [
                Expanded(
                  child: _buildOptionCard(
                    bgColor: Colors.purple[100],
                    iconColor: Colors.purple[300],
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'admin@houseify.com',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FAQScreen(),
                        ),
                      );
                    },
                    child: _buildOptionCard(
                      bgColor: Colors.yellow[100],
                      iconColor: Colors.yellow[300],
                      icon: Icons.help_outline,
                      title: 'FAQ',
                      subtitle: '+50 Answers',
                    ),
                  ),
                ),
              ],
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Go to Homepage',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Card Builder Method
  Widget _buildOptionCard({
    required Color? bgColor,
    required Color? iconColor,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: iconColor,
              child: Icon(icon, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
