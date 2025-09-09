import 'package:flutter/material.dart';
import 'housify_home_screen.dart';
import 'profile_screen.dart';
import 'history_screen.dart';
import 'notification_screen.dart';


class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  int _selectedIndex = 2; // Offers tab selected

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HousifyHomeScreen()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
    } else if (index == 2) {
      // Already on Offers
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2526),
      body: Column(
        children: [
          // ------------------ Top App Bar ------------------
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HousifyHomeScreen()),
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
                        'Offers',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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

          const SizedBox(height: 16),

          // ------------------ White Container ------------------
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
                    // -------- Latest Offers --------
                    const Text(
                      'Latest Offers',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildRectOfferCard(
                            Colors.purple,
                            '40% OFF',
                            'On First Cleaning',
                            'HOME40',
                            'assets/cleaninggirl.png',
                          ),
                          const SizedBox(width: 12),
                          _buildRectOfferCard(
                            Colors.orange,
                            'Summer Offer',
                            'New User Offer !!',
                            'NEW50',
                            null,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // -------- Limited Offer --------
                    const Text(
                      'Limited Offer',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildLimitedOfferCard(size),

                    const SizedBox(height: 16),

                    // -------- Just For You --------
                    const Text(
                      'Just for you',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildServiceOfferCard(
                            Colors.blue, 'Painting Service', 'Save 30%'),
                        const SizedBox(width: 12),
                        _buildServiceOfferCard(
                            Colors.green, 'Shifting Service', '20% Off'),
                        const SizedBox(width: 12),
                        _buildServiceOfferCard(
                            Colors.pink, 'Vehicle Service', 'Save 30%'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ------------------ Bottom Nav ------------------
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HistoryScreen()));
                }),
                _buildBottomNavItem(Icons.local_offer, 'Offers', 2, () {}),
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

  // ✅ Rectangular Offer Card (like Housify)
  Widget _buildRectOfferCard(Color bgColor, String title, String subtitle,
      String code, String? image) {
    return Container(
      width: 240,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(height: 4),
                Text('Code: $code',
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
          // Right Side Image/Icon
          if (image != null)
            Image.asset(image, width: 60, height: 60, fit: BoxFit.contain)
          else
            const Icon(Icons.local_offer, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  // ✅ Limited Offer Smaller & Image Right
  Widget _buildLimitedOfferCard(Size size) {
    return Container(
      height: size.height * 0.18, // smaller
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '20% OFF',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 4),
              Text('Online Payment', style: TextStyle(color: Colors.white)),
              SizedBox(height: 4),
              Text('Code: GO20', style: TextStyle(color: Colors.white)),
            ],
          ),

          // Right Side Image
          Image.asset('assets/truck.png', width: size.width * 0.28),
        ],
      ),
    );
  }

  // Service Offer Card
  Widget _buildServiceOfferCard(Color color, String title, String subtitle) {
    return Container(
      width: 100,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
          const SizedBox(height: 8),
          Text(subtitle,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: const Text('ORDER NOW',
                style: TextStyle(color: Colors.black, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation
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
