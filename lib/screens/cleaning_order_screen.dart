import 'package:flutter/material.dart';
import 'housify_home_screen.dart'; // Make sure this file exists
import 'notification_screen.dart';
class OrderPlacedScreen extends StatelessWidget {
  final String location;
  final double totalCost;

  const OrderPlacedScreen({super.key, required this.location, required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed'),
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Order Placed', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Location: $location'),
            const SizedBox(height: 10),
            Text('Total Cost: \$${totalCost.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HousifyHomeScreen()),
                );
              },
              child: const Text('Go to Homepage'),
            ),
          ],
        ),
      ),
    );
  }
}