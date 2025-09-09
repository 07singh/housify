import 'package:flutter/material.dart';

void main() {
  runApp(ConfirmLocationApp());
}

class ConfirmLocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConfirmLocationScreen(),
    );
  }
}

class ConfirmLocationScreen extends StatelessWidget {
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
          'Confirm Location',
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
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Please choose your destination location accurately. For any info call (+1) 999 999 999',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio(value: true, groupValue: true, onChanged: (value) {}),
                      Text('Loading Point'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: false, groupValue: true, onChanged: (value) {}),
                      Icon(Icons.location_on, color: Colors.green),
                      Text('Unloading Point'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {},
                  ),
                  Text(
                    'May, 2025',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF4A261),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 200.0,
              child: GridView.count(
                crossAxisCount: 7,
                children: List.generate(31, (index) {
                  return Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: index == 10 ? Color(0xFFF4A261) : Colors.black,
                      ),
                    ),
                  );
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      minimumSize: Size(80.0, 40.0),
                    ),
                    onPressed: () {},
                    child: Text('07:00 AM', style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      minimumSize: Size(80.0, 40.0),
                    ),
                    onPressed: () {},
                    child: Text('11:00 AM', style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      minimumSize: Size(80.0, 40.0),
                    ),
                    onPressed: () {},
                    child: Text('12:00', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.person, color: Color(0xFFF4A261)),
                  SizedBox(width: 8.0),
                  Text(
                    'Workers\nRegular cost is 5/hr. Total cost will be calculated later',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.remove), onPressed: () {}),
                      Text('0'),
                      IconButton(icon: Icon(Icons.add), onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF4A261),
                  minimumSize: Size(double.infinity, 50.0),
                ),
                onPressed: () {},
                child: Text('Proceed', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}