import 'package:flutter/material.dart';

void main() {
  runApp(OrderPlacedApp());
}

class OrderPlacedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderPlacedScreen(),
    );
  }
}

class OrderPlacedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.2),
              ),
              child: Icon(
                Icons.celebration,
                color: Colors.green,
                size: 100.0,
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Order Placed',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Your order has been Successfully placed,',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            Text(
              'For any info call (+1) 999 999 999',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'YOUR DRIVER',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Working Hour: 7PM - 9AM',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://via.placeholder.com/50x50'), // Replace with actual driver image URL
                    radius: 25.0,
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gabriel Payne',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) => Icon(Icons.star, color: Colors.yellow, size: 16.0)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.phone, color: Colors.blue[100]),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.chat_bubble, color: Colors.blue[100]),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.sentiment_satisfied, color: Colors.purple[100]),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Container(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF4A261),
                  minimumSize: Size(double.infinity, 50.0),
                ),
                onPressed: () {},
                child: Text('Go to Homepage', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}