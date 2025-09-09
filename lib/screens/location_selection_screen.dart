import 'package:flutter/material.dart';

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String selectedLocationType = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Text("Location", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          )
        ],
      ),

      // Body
      body: Stack(
        children: [
          // Map Mock
          Container(
            margin: EdgeInsets.only(top: 60),
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade200, // placeholder map
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.location_on, size: 60, color: Colors.green),
                Positioned(
                  right: 20,
                  bottom: 200,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.my_location, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          // Top Overlay with room and person info
          Positioned(
            top: 0,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.home, color: Colors.orange),
                    SizedBox(width: 8),
                    Text("3 Bedrooms, 1 Kitchen"),
                  ]),
                  Row(children: [
                    Icon(Icons.person, color: Colors.amber),
                    SizedBox(width: 8),
                    Text("1 Person"),
                  ])
                ],
              ),
            ),
          ),

          // Bottom Card with address and location type
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Address Row
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "3329 Joyce Street, CA, USA",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(Icons.clear, size: 20),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(),

                  // Location Type Icons
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      locationOption(icon: Icons.home, label: 'Home'),
                      locationOption(icon: Icons.work, label: 'Work'),
                      locationOption(icon: Icons.add_location_alt, label: 'Add New'),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Proceed Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Proceed", style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

  Widget locationOption({required IconData icon, required String label}) {
    final isSelected = selectedLocationType == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLocationType = label;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: isSelected ? Colors.amber : Colors.grey.shade200,
            radius: 28,
            child: Icon(icon, color: isSelected ? Colors.white : Colors.black),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
