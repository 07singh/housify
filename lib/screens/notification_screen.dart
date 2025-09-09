import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'offers_screen.dart';
import 'profile_screen.dart';
import 'housify_home_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2526), // Dark background on top
      body: Column(
        children: [
          // ----------------- Top AppBar -----------------
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.grid_view_rounded,
                      color: Colors.white, size: 28),
                  const Text(
                    "Notification",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications,
                          color: Colors.white, size: 28),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ----------------- White Body -----------------
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                  // Reminder
                  _buildNotificationTile(
                    bgColor: const Color(0xFFEAF1FF),
                    icon: Icons.notifications,
                    iconColor: Colors.blue,
                    title: "Reminder",
                    subtitle: "House Shifting - #2F33J scheduled Tomorrow.",
                    time: "13min",
                  ),

                  const Divider(height: 32),

                  // New Message
                  _buildNotificationTile(
                    bgColor: const Color(0xFFEAF1FF),
                    image: "assets/img_1.png",
                    title: "You have a new Message",
                    subtitle:
                    "“Hey! I looked your problem and it’s fixed now. can you confirm?”",
                    time: "1 hr",
                  ),

                  const Divider(height: 32),

                  // Order Confirmed
                  _buildNotificationTile(
                    bgColor: const Color(0xFFEFF9F2),
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    title: "Order Confirmed",
                    subtitle:
                    "Your Vehicle - Mini Van Order is successfully placed.",
                    time: "1 hr",
                  ),

                  const Divider(height: 32),

                  // Summer Offer
                  _buildNotificationTile(
                    bgColor: const Color(0xFFFFF2F6),
                    icon: Icons.celebration,
                    iconColor: Colors.pink,
                    title: "Summer Offer",
                    subtitle:
                    "49% off on House Painting service until November 23rd.",
                    time: "1 hr",
                  ),
                ],
              ),
            ),
          ),

          // ----------------- Bottom Navigation -----------------
          Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home, "Home", 0, context),
                _buildBottomNavItem(Icons.history, "History", 1, context),
                _buildBottomNavItem(Icons.local_offer, "Offers", 2, context),
                _buildBottomNavItem(Icons.person, "Profile", 3, context),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ---------------- Notification Tile ----------------
  Widget _buildNotificationTile({
    required String title,
    required String subtitle,
    required String time,
    Color bgColor = Colors.grey,
    IconData? icon,
    Color? iconColor,
    String? image,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(16)),
          child: icon != null
              ? Icon(icon, color: iconColor, size: 28)
              : ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(image!, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  Text(time,
                      style:
                      const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
        )
      ],
    );
  }

  // ---------------- Bottom Nav Item (with navigation) ----------------
  Widget _buildBottomNavItem(
      IconData icon, String label, int index, BuildContext context) {
    bool isSelected = _selectedIndex == index;
    Color color = isSelected ? Colors.orange : Colors.white;

    return GestureDetector(
      onTap: () {
        if (label == 'Home') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HousifyHomeScreen()));
        } else if (label == 'History') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HistoryScreen()));
        } else if (label == 'Offers') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OffersScreen()));
        } else if (label == 'Profile') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProfileScreen()));
        }

        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
