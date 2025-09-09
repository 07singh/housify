import 'package:flutter/material.dart';
import 'housify_home_screen.dart';
import 'offers_screen.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HistoryScreen(),
  ));
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedIndex = 1; // History tab selected

  // Example rooms and colors (same as painting screen)
  List<String> selectedRooms = [];
  List<Color> selectedColors = [];
  int requiredPersons = 0;

  final List<Map<String, dynamic>> rooms = [
    {'name': 'Full House', 'description': '3 room Kitchen', 'icon': Icons.home},
    {'name': 'Large House', 'description': '4 room Kitchen', 'icon': Icons.home_work},
    {'name': 'Others', 'description': 'Backyard & Garage', 'icon': Icons.garage},
  ];

  final List<Color> colors = [
    Color(0xFFF5A623),
    Colors.purple,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2526),
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔸 Left side App Logo (instead of back arrow)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HousifyHomeScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/app_icon.png',
                      height: 32,
                      width: 32,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // 🔸 Right side Notification Icon
                  Stack(
                    children: [
                      const Icon(Icons.notifications, color: Colors.white, size: 24),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Month Filter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'This Month',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.filter_list, size: 20),
                            SizedBox(width: 8),
                            Icon(Icons.grid_view, size: 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Service Cards
                    _buildServiceCard('Active', Colors.green, 'House Shifting Service',
                        'Friday, May 11, 2025', '3329 Joyce Stree, PA, USA'),
                    const SizedBox(height: 16),
                    _buildServiceCard('Cancelled', Colors.orange, 'Painting Service',
                        'Friday, May 11, 2025', '3329 Joyce Stree, PA, USA'),
                    const SizedBox(height: 16),
                    _buildServiceCard('Done', Colors.black, 'Cleaning Service',
                        'Sunday, January 03, 2025', '3329 Joyce Stree, PA, USA'),
                  ],
                ),
              ),
            ),
          ),

          // Rectangular Bottom Navigation Bar
          Container(
            height: 70,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home, 'Home', 0, () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HousifyHomeScreen()));
                }),
                _buildBottomNavItem(Icons.history, 'History', 1, () {
                  // Already on HistoryScreen
                }),
                _buildBottomNavItem(Icons.local_offer, 'Offers', 2, () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const OffersScreen()));
                }),
                _buildBottomNavItem(Icons.person, 'Profile', 3, () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ProfileScreen()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
      String status, Color statusColor, String title, String date, String address) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Icon(Icons.map, color: Colors.grey.shade600, size: 50),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              const Positioned(
                top: 50,
                right: 16,
                child: Icon(Icons.location_on, color: Colors.yellow, size: 24),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(date,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.green, size: 16),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(address, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
      IconData icon, String label, int index, VoidCallback onTap) {
    Color color = _selectedIndex == index ? Colors.orange : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
