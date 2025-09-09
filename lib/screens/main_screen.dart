import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HousifyHomeScreen(),
    );
  }
}

class HousifyHomeScreen extends StatefulWidget {
  const HousifyHomeScreen({super.key});

  @override
  State<HousifyHomeScreen> createState() => _HousifyHomeScreenState();
}

class _HousifyHomeScreenState extends State<HousifyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375,
        height: 812,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(70),
          border: Border.all(color: Colors.grey.shade300, width: 13),
        ),
        child: Column(
          children: [
            // Top App Bar (Black Background)
            Container(
              height: 80, // Adjusted to include status bar (approx. 24px) + 56px app bar
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16), // Status bar + padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.dashboard, color: Colors.white, size: 24), // Grid/Dashboard icon
                    Row(
                      children: [
                        Image.asset(
                          'assets/housify_logo.png', // Placeholder for house icon with red roof
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Housify',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        const Icon(Icons.notifications, color: Colors.white, size: 24), // Notification bell
                        Positioned(
                          right: 0,
                          top: 0,
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
              ),
            ),
            // Welcome Section (White Background)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome 👋',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Need a helping hand today?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Main Categories (3 Cards in Row)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 111, // (375 - 32 - 16) / 3, adjusted for padding
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5E6E6), // Pastel red
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.home, color: Colors.red, size: 32), // Red home icon
                        const SizedBox(height: 8),
                        const Text(
                          'House Shifting',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 111,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F0E6), // Pastel orange
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.business, color: Colors.orange, size: 32), // Orange office icon
                        const SizedBox(height: 8),
                        const Text(
                          'Office Shifting',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 111,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F0F5), // Pastel blue
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.store, color: Colors.blue, size: 32), // Blue building icon
                        const SizedBox(height: 8),
                        const Text(
                          'Commercial Shifting',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Offers & News Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Offers & News',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF7B00), // Orange filled
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Trending',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Promotion',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Summer Offer',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'New',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDDA0DD), // Purple
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '40% OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Image.asset(
                              'assets/cleaninggirl.png', // Placeholder for cleaning lady image
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xADD8E6), // Blue
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '15% OFF Online Payment',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(Icons.house, color: Colors.white, size: 32), // House icon
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Other Services Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Other Services',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2ECC71), // Green
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(Icons.cleaning_services, color: Colors.white, size: 32),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Cleaning',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                          const Text(
                            'New',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(Icons.handyman, color: Colors.white, size: 32), // Labour icon
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Labour Service',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF800080), // Purple
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(Icons.local_shipping, color: Colors.white, size: 32), // Truck icon
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Vehicle',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(Icons.format_paint, color: Colors.white, size: 32), // Roller brush icon
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Painting',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Bottom Navigation Bar (Black, Curved Top)
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.home, color: Color(0xFFFF7B00), size: 24), // Orange filled
                      const Text(
                        'Home',
                        style: TextStyle(
                          color: Color(0xFFFF7B00),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.history, color: Colors.white, size: 24),
                      const Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.local_offer, color: Colors.white, size: 24),
                      const Text(
                        'Offers',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, color: Colors.white, size: 24),
                      const Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}