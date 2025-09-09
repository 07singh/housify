import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConfirmationScreen(),
    );
  }
}

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('Confirmation'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/map_placeholder.png', // Replace with actual map image
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            color: Colors.grey.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage('assets/map_placeholder.png'), // Replace with actual map image
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('1.2km', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 10, color: Colors.black),
                        SizedBox(width: 5),
                        Text('2045 Lodgeville Street, Eagan'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('My Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: Text('+ Add New', style: TextStyle(color: Colors.orange)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.credit_card, color: Colors.white, size: 40),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Add your card',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "It's seems like you don't add any credit or debit card. Add card for faster access",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text('Back'),
                        ),
                      ],
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