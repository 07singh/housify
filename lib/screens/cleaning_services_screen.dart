import 'package:flutter/material.dart';
import 'package:house_service/screens/cleaning_date_screen.dart';
import 'package:house_service/screens/housify_home_screen.dart';
import 'notification_screen.dart';

void main() {
  runApp(const CleaningServiceApp());
}

class CleaningServiceApp extends StatelessWidget {
  const CleaningServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2ECC71),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
      ),
      home: const CleaningServiceScreen(),
    );
  }
}

class CleaningServiceScreen extends StatefulWidget {
  const CleaningServiceScreen({super.key});

  @override
  State<CleaningServiceScreen> createState() => _CleaningServiceScreenState();
}

class _CleaningServiceScreenState extends State<CleaningServiceScreen> {
  int requiredPersons = 0;
  int workingHours = 2;
  String selectedRoom = '2 Bedrooms\n1 Kitchen'; // default selected room

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // ✅ Custom AppBar
          SafeArea(
            child: Container(
              height: 56,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HousifyHomeScreen()),
                            (route) => false,
                      );
                    },
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 24),
                  ),
                  const Text(
                    'Cleaning Service',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications,
                          color: Colors.white, size: 20),
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

          // ✅ White rounded container body
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Column(
                        children: [
                          // Header
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.cleaning_services,
                                        color: Color(0xFF2ECC71), size: 24),
                                    SizedBox(width: 8),
                                    Text(
                                      'Cleaning',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFE6F7EC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                  ),
                                  child: const Text(
                                    '+ Custom',
                                    style: TextStyle(
                                      color: Color(0xFF2ECC71),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ✅ Scrollable Promo Banners
                          SizedBox(
                            height: 140,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                _buildPromoBanner(
                                  title: "Shifty",
                                  subtitle: "Hot Deal",
                                  discount: "40% OFF",
                                  description: "On First Cleaning Service",
                                  imageUrl: "https://via.placeholder.com/140",
                                  bgColor: const Color(0xFF2ECC71),
                                ),
                                const SizedBox(width: 12),
                                _buildPromoBanner(
                                  title: "Summer Offer",
                                  subtitle: "Special Discount",
                                  discount: "30% OFF",
                                  description: "On Deep Cleaning Service",
                                  imageUrl: "https://via.placeholder.com/140",
                                  bgColor: Colors.orange,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ✅ Fixed Room Selection
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _buildRoomCard(
                                      '2 Bedrooms\n1 Kitchen',
                                      const Color(0xFFE6F7EC)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildRoomCard(
                                      '3 Bedrooms\n1 Kitchen',
                                      const Color(0xFFE6E6FA)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildRoomCard(
                                      '4 Bedrooms\n1 Kitchen',
                                      const Color(0xFFFFF5E6)),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ✅ Counters
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                _buildCounterRow(
                                  icon: Icons.person,
                                  title: 'Required Person',
                                  subtitle:
                                  'Regular cost is \$5/hr. Total cost will be calculated later',
                                  value: requiredPersons,
                                  onDecrement: () {
                                    if (requiredPersons > 0) {
                                      setState(() => requiredPersons--);
                                    }
                                  },
                                  onIncrement: () {
                                    setState(() => requiredPersons++);
                                  },
                                ),
                                const SizedBox(height: 16),
                                _buildCounterRow(
                                  icon: Icons.access_time,
                                  title: 'Working Hour',
                                  subtitle:
                                  'Cost will increase after 2 hrs of work.',
                                  value: workingHours,
                                  onDecrement: () {
                                    if (workingHours > 0) {
                                      setState(() => workingHours--);
                                    }
                                  },
                                  onIncrement: () {
                                    setState(() => workingHours++);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Proceed Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CleaningDateServiceScreen(
                                selectedRoom: selectedRoom,
                                requiredPersons: requiredPersons,
                                workingHours: workingHours,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2ECC71),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Proceed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  // ✅ Promo Banner Widget
  Widget _buildPromoBanner({
    required String title,
    required String subtitle,
    required String discount,
    required String description,
    required String imageUrl,
    required Color bgColor,
  }) {
    return Container(
      width: 280,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: bgColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                      const TextStyle(color: Colors.white, fontSize: 12)),
                  Text(discount,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  Text(description,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
          ),
          Container(
            width: 120,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Room Card
  Widget _buildRoomCard(String text, Color bgColor) {
    return GestureDetector(
      onTap: () => setState(() => selectedRoom = text),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: selectedRoom == text ? Colors.green.shade100 : bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ✅ Counter Row
  Widget _buildCounterRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(icon, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(subtitle,
                        style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove, color: Colors.green)),
            Text('$value',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add, color: Colors.green)),
          ],
        ),
      ],
    );
  }
}
