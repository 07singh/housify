import 'package:flutter/material.dart';
import 'housify_home_screen.dart';
import 'notification_screen.dart';

class OrderPlacedScreen extends StatelessWidget {
  final String location;
  final double totalCost;

  const OrderPlacedScreen({
    super.key,
    required this.location,
    required this.totalCost,
  });

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
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 24),
                  ),
                  const Text(
                    'Order Placed',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Icon(Icons.notifications,
                      color: Colors.white, size: 24),
                ],
              ),
            ),

            // ✅ White rounded container
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
                    // ✅ Centered Content
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle,
                              size: 100, color: Colors.green),
                          const SizedBox(height: 20),
                          const Text(
                            'Order Placed',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Location: $location',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Total Cost: \$${totalCost.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),

                    // ✅ Bottom Button
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const HousifyHomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2ECC71),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Go to Homepage',
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
}
