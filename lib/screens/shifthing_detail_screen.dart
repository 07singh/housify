import 'package:flutter/material.dart';
import 'select_destation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShiftingDetailsScreen(),
    );
  }
}

class ShiftingDetailsScreen extends StatefulWidget {
  @override
  _ShiftingDetailsScreenState createState() => _ShiftingDetailsScreenState();
}

class _ShiftingDetailsScreenState extends State<ShiftingDetailsScreen> {
  String selectedVehicle = 'Mini Truck';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background outside main content
      body: SafeArea(
        child: Column(
          children: [
            // ✅ AppBar like Office Shifting
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white)),
                  const Text(
                    'Friday, May 11, 2025\n8:00 pm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications, color: Colors.white),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ Main white content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Info Cards
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCategoryChip('2 Bedrooms\n1 Kitchen', Icons.home),
                          _buildCategoryChip('12 Furniture', Icons.chair),
                          _buildCategoryChip('10 Boxes', Icons.inventory),
                        ],
                      ),
                    ),

                    // Map Placeholder or Image
                    Expanded(
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/map.png', // Replace with actual map
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 50,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Icon(Icons.location_on,
                                  color: Colors.yellow, size: 40),
                            ),
                          ),
                          Positioned(
                            bottom: 150,
                            left: 20,
                            right: 20,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle,
                                        color: Colors.black, size: 10),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: Text(
                                            '2045 Lodgeville Road, Eagan...')),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.green, size: 20),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: Text('3329 Joyce Street')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Vehicle Options
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          _buildVehicleOption(
                              'Mini Truck', '<1.8 Ton', 'assets/mini_truck.png'),
                          _buildVehicleOption(
                              'Pickup', '~1.2 Ton', 'assets/mini_truck.png'),
                          _buildVehicleOption(
                              'Large', '~5 Ton', 'assets/mini_truck.png'),
                        ],
                      ),
                    ),

                    // ✅ Proceed Button
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectDestinationScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            'Proceed',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
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

  // --- Widgets ---
  Widget _buildCategoryChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, color: Colors.white),
      label: Text(label, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey[700],
    );
  }

  Widget _buildVehicleOption(String title, String capacity, String imagePath) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedVehicle = title;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200, // Always light grey
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 80,
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(capacity),
            ],
          ),
        ),
      ),
    );
  }
}
