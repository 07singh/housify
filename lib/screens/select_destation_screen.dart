import 'package:flutter/material.dart';
import 'shifting_order_screen.dart';

class SelectDestinationScreen extends StatefulWidget {
  final String selectedHouse;
  final Map<String, int> furnitures;
  final int packedBoxes;
  final int workers;
  final int electricians;
  final DateTime selectedDate;
  final String selectedTime;
  final String selectedVehicle;

  const SelectDestinationScreen({
    super.key,
    required this.selectedHouse,
    required this.furnitures,
    required this.packedBoxes,
    required this.workers,
    required this.electricians,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedVehicle,
  });

  @override
  _SelectDestinationScreenState createState() =>
      _SelectDestinationScreenState();
}

class _SelectDestinationScreenState extends State<SelectDestinationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // ✅ Custom AppBar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

          // ✅ White Section with Map
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Stack(
                children: [
                  // ✅ Full Map
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: Image.asset(
                        'assets/map.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // ✅ Address box on top
                  Positioned(
                    top: 20,
                    left: 24,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.circle, size: 12, color: Colors.black),
                          SizedBox(width: 8),
                          Expanded(
                              child:
                              Text('2045 Lodgeville Street, Eagan')),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Center Pin
                  const Center(
                    child: Icon(Icons.location_on,
                        color: Colors.yellow, size: 50),
                  ),

                  // ✅ Current Location Icon (Bottom right)
                  Positioned(
                    bottom: 100,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: const Icon(Icons.my_location,
                          color: Colors.orange, size: 30),
                    ),
                  ),

                  // ✅ Confirm Button at bottom
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailsScreen(
                                selectedHouse: widget.selectedHouse,
                                furnitures: widget.furnitures,
                                packedBoxes: widget.packedBoxes,
                                workers: widget.workers,
                                electricians: widget.electricians,
                                selectedDate: widget.selectedDate,
                                selectedTime: widget.selectedTime,
                                selectedVehicle: widget.selectedVehicle,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
