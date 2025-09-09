import 'package:flutter/material.dart';
import 'shifting_order_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectDestinationScreen(),
    );
  }
}

class SelectDestinationScreen extends StatefulWidget {
  @override
  _SelectDestinationScreenState createState() =>
      _SelectDestinationScreenState();
}

class _SelectDestinationScreenState extends State<SelectDestinationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // ✅ AppBar like Office Shifting
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white)),
                const Text(
                  'Select Destination',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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

          // ✅ Main White Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Stack(
                children: [
                  // Map inside white container
                  Positioned.fill(
                    top: 16,
                    bottom: 100,
                    left: 16,
                    right: 16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/map.png', // replace with actual map
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Source Address Box
                  Positioned(
                    top: 24,
                    left: 32,
                    right: 32,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.circle, size: 10, color: Colors.black),
                          SizedBox(width: 8),
                          Expanded(
                              child: Text(
                                  '2045 Lodgeville Street, Eagan')),
                        ],
                      ),
                    ),
                  ),

                  // Destination Pin
                  Positioned(
                    top: size.height * 0.25,
                    left: 0,
                    right: 0,
                    child: const Center(
                      child: Icon(Icons.location_on,
                          color: Colors.yellow, size: 40),
                    ),
                  ),

                  // Current Location Icon
                  Positioned(
                    bottom: 120,
                    left: 0,
                    right: 0,
                    child: const Center(
                      child:
                      Icon(Icons.my_location, color: Colors.orange, size: 30),
                    ),
                  ),

                  // ✅ Confirm Button
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Confirm',
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
    );
  }
}
