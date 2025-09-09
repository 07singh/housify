import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'offers_screen.dart';
import 'profile_screen.dart';
import 'house_shifting_screen.dart';
import 'office_shifting_screen.dart';
import 'commercial_shifting_screen.dart';
import 'vehicle_services_screen.dart';
import 'painting_screen.dart';
import 'cleaning_services_screen.dart';
import 'notification_screen.dart';

class HousifyHomeScreen extends StatefulWidget {
  const HousifyHomeScreen({super.key});

  @override
  State<HousifyHomeScreen> createState() => _HousifyHomeScreenState();
}

class _HousifyHomeScreenState extends State<HousifyHomeScreen> {
  int _selectedIndex = 0;

  // ✅ Added for offer tag selection
  String _selectedOfferTag = "Trending";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2526),
      body: Column(
        children: [
          // -------------------- Top App Bar --------------------
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
                            builder: (context) => const HousifyHomeScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/app_icon.png',
                      width: 28,
                      height: 28,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/housify_logo.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Housify',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                    child: Stack(
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
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // -------------------- White Rounded Container --------------------
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
                    // ---------------- Welcome Section ----------------
                    const Text(
                      'Welcome 👋',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Need a helping hand today?',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 16),

                    // ---------------- Shifting Services Section ----------------
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const HouseShiftingScreen()));
                            },
                            child: _buildCategoryCard(
                                Icons.home,
                                'House Shifting',
                                const Color(0xFFF5E6E6),
                                Colors.red),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OfficeShiftingScreen()));
                            },
                            child: _buildCategoryCard(
                                Icons.business,
                                'Office Shifting',
                                const Color(0xFFF5F0E6),
                                Colors.orange),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const CommercialShiftingScreen()));
                            },
                            child: _buildCategoryCard(
                                Icons.store,
                                'Commercial Shifting',
                                const Color(0xFFE6F0F5),
                                Colors.blue),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ---------------- Offers & News Section ----------------
                    const Text(
                      'Offers & News',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildSelectableOfferTag('Trending'),
                          _buildSelectableOfferTag('Promotion'),
                          _buildSelectableOfferTag('Summer Offer'),
                          _buildSelectableOfferTag('New'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildOfferCard('40% OFF',
                              'assets/cleaninggirl.png', Colors.purple),
                          const SizedBox(width: 12),
                          _buildOfferCard(
                              '15% OFF Online Payment', null, Colors.blue),
                          const SizedBox(width: 12),
                          _buildOfferCard(
                              '50% OFF Summer Offer', null, Colors.green),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ---------------- Other Services Section ----------------
                    const Text(
                      'Other Services',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ✅ Equal spacing
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CleaningServiceApp()));
                          },
                          child: _buildOtherService(Icons.cleaning_services,
                              'Cleaning', Colors.green,
                              newLabel: true),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CleaningServiceApp()));
                          },
                          child: _buildOtherService(
                              Icons.handyman, 'Labour', Colors.blue),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VehicleServiceScreen()));
                          },
                          child: _buildOtherService(Icons.local_shipping,
                              'Vehicle', const Color(0xFF800080)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PaintingServiceScreen()));
                          },
                          child: _buildOtherService(
                              Icons.format_paint, 'Painting', Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // -------------------- Bottom Navigation Bar --------------------
          Container(
            height: 70,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home, 'Home', 0),
                _buildBottomNavItem(Icons.history, 'History', 1),
                _buildBottomNavItem(Icons.local_offer, 'Offers', 2),
                _buildBottomNavItem(Icons.person, 'Profile', 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Helper Widgets ----------------
  Widget _buildCategoryCard(
      IconData icon, String title, Color bgColor, Color iconColor) {
    return Container(
      width: 100,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration:
      BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 12)),
        ],
      ),
    );
  }

  // ✅ Updated for selectable offer tags
  Widget _buildSelectableOfferTag(String text) {
    bool isSelected = _selectedOfferTag == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOfferTag = text;
        });
      },
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? null : Border.all(color: Colors.grey),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black, fontSize: 14),
        ),
      ),
    );
  }

  // ✅ Rectangular Offer Card
  Widget _buildOfferCard(String text, String? image, Color bgColor,
      {double width = 240, double height = 100}) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          if (image != null)
            Image.asset(image, width: 60, height: 60, fit: BoxFit.contain)
          else
            const Icon(Icons.local_offer, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  // ✅ Fixed equal size for Other Services
  Widget _buildOtherService(IconData icon, String label, Color bgColor,
      {bool newLabel = false}) {
    return SizedBox(
      width: 80, // ✅ Fixed width
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(30)),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          if (newLabel)
            const Text('New',
                style: TextStyle(color: Colors.red, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    Color color = isSelected ? Colors.orange : Colors.white;

    return GestureDetector(
      onTap: () {
        if (label == 'Profile') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        } else if (label == 'History') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()));
        } else if (label == 'Offers') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OffersScreen()));
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: color, size: 24),
        Text(label, style: TextStyle(color: color, fontSize: 12)),
      ]),
    );
  }
}
