import 'package:flutter/material.dart';
import 'cleaning_confirmation_screen.dart';

class LocationScreen extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTimePeriod;
  final String selectedTime;
  final bool includeInstruments;

  const LocationScreen({
    Key? key,
    required this.selectedDate,
    required this.selectedTimePeriod,
    required this.selectedTime,
    required this.includeInstruments,
  }) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String selectedLocation = '3229 Joyce St, CA, USA';
  int bedrooms = 3;
  int kitchens = 1;
  int persons = 1;

  void _navigateToConfirmation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  ConfirmationScreen(
          location: selectedLocation,
          bedrooms: bedrooms,
          kitchens: kitchens,
          persons: persons,
          selectedDate: widget.selectedDate,
          selectedTimePeriod: widget.selectedTimePeriod,
          selectedTime: widget.selectedTime,
          includeInstruments: widget.includeInstruments,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: width * 0.06),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Location',
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.05,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white, size: width * 0.06),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.home, color: Colors.green, size: width * 0.07),
                  title: Text(
                    '$bedrooms Bedrooms, $kitchens Kitchen',
                    style: TextStyle(fontSize: width * 0.045),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, color: Colors.green, size: width * 0.07),
                      SizedBox(width: width * 0.01),
                      Text('$persons Person', style: TextStyle(fontSize: width * 0.04)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(Icons.location_pin, color: Colors.green, size: width * 0.12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.location_on, color: Colors.green, size: width * 0.07),
                  title: Text(selectedLocation, style: TextStyle(fontSize: width * 0.04)),
                  trailing: IconButton(
                    icon: Icon(Icons.close, size: width * 0.06, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        selectedLocation = '';
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircleButton(Icons.home, width),
                  _buildCircleButton(Icons.work, width),
                  _buildCircleButton(Icons.add, width),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.04, 0, width * 0.04, height * 0.03),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: ElevatedButton(
                  onPressed: _navigateToConfirmation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.045,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, double width) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(width * 0.05),
        backgroundColor: Colors.green.shade100,
        foregroundColor: Colors.green,
      ),
      child: Icon(icon, size: width * 0.07),
    );
  }
}
