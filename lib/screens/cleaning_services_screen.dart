import 'package:flutter/material.dart';
import 'package:house_service/screens/cleaning_date_screen.dart';
import 'package:house_service/screens/housify_home_screen.dart';
import 'notification_screen.dart';

class  CleaningServiceApp extends StatefulWidget {
  const  CleaningServiceApp({super.key});

  @override
  State< CleaningServiceApp> createState() => _CleaningServiceScreenState();
}

class _CleaningServiceScreenState extends State< CleaningServiceApp> {
  int requiredPersons = 0;
  int workingHours = 2;
  String? selectedRoom;

  final List<Map<String, dynamic>> rooms = [
    {'name': '2 Bedrooms\n1 Kitchen', 'icon': Icons.home},
    {'name': '3 Bedrooms\n1 Kitchen', 'icon': Icons.house},
    {'name': '4 Bedrooms\n1 Kitchen', 'icon': Icons.apartment},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Custom AppBar
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Icon(Icons.notifications,
                      color: Colors.white, size: 24),
                ],
              ),
            ),

            // ✅ White rounded container content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    // ✅ Scrollable content
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔥 Header
                          Row(
                            children: [
                              const Icon(Icons.cleaning_services,
                                  color: Color(0xFF2ECC71), size: 32),
                              const SizedBox(width: 8),
                              const Text(
                                'Cleaning',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF2ECC71),
                                  side: const BorderSide(
                                      color: Color(0xFF2ECC71)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                child: const Text('+ Custom'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Select your rooms and workers correctly to measure estimated cost.',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 16),

                          // 🔥 Promo Banners
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _promoCard(
                                  title: "Shifty",
                                  discount: "40% OFF",
                                  description: "On First Cleaning Service",
                                  color: const Color(0xFF2ECC71),
                                ),
                                const SizedBox(width: 12),
                                _promoCard(
                                  title: "Summer Offer",
                                  discount: "30% OFF",
                                  description: "On Deep Cleaning",
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // 🔥 Room Selection (Equal Containers)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: rooms.map((room) {
                              bool isSelected = selectedRoom == room['name'];
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRoom = room['name'];
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF2ECC71)
                                          .withOpacity(0.1)
                                          : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF2ECC71)
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(room['icon'],
                                            size: 36, color: Colors.grey[600]),
                                        const SizedBox(height: 6),
                                        Text(room['name'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),

                          // 🔥 Counters
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

                    // ✅ Proceed Button
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedRoom != null &&
                                requiredPersons > 0 &&
                                workingHours > 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CleaningDateServiceScreen(
                                        selectedRoom: selectedRoom!,
                                        requiredPersons: requiredPersons,
                                        workingHours: workingHours,
                                      ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please select a room, person and hours.')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2ECC71),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            'Proceed',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
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
      ),
    );
  }

  // ✅ Promo Card
  Widget _promoCard({
    required String title,
    required String discount,
    required String description,
    required Color color,
  }) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 8),
          Text(discount,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          Text(description,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
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
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFF2ECC71).withOpacity(0.2),
          child: Icon(icon, color: const Color(0xFF2ECC71)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove_circle_outline,
                    color: Colors.green)),
            Text('$value',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: onIncrement,
                icon:
                const Icon(Icons.add_circle_outline, color: Colors.green)),
          ],
        ),
      ],
    );
  }
}
