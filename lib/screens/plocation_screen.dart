import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationScreen(
        selectedDate: null,
        selectedSession: "",
        selectedTime: "",
        includeInstruments: false,
        selectedRooms: [],
        selectedColors: [],
        requiredPersons: 0,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LocationScreen extends StatefulWidget {
  final DateTime? selectedDate;
  final String selectedSession;
  final String selectedTime;
  final bool includeInstruments;
  final List<String> selectedRooms;
  final List<Color> selectedColors;
  final int requiredPersons;

  const LocationScreen({
    super.key,
    required this.selectedDate,
    required this.selectedSession,
    required this.selectedTime,
    required this.includeInstruments,
    required this.selectedRooms,
    required this.selectedColors,
    required this.requiredPersons,
  });

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _selectedLocationType = 'Home';
  String _currentLocation = '3229 Joyce Stree, CA, USA';
  bool _isLocationDetailVisible = true;

  final Map<String, String> _locationDetails = {
    'Home': '3229 Joyce Stree, CA, USA',
    'Work': '123 Business Ave, CA, USA',
    'Add New': 'Add new location...',
  };

  void _selectLocationType(String type) {
    setState(() {
      _selectedLocationType = type;
      _currentLocation = _locationDetails[type]!;
      _isLocationDetailVisible = type != 'Add New';
    });
  }

  void _toggleLocationDetail() {
    setState(() {
      _isLocationDetailVisible = !_isLocationDetailVisible;
    });
  }

  void _onProceed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmed'),
        content: Text(
          '''
Selected Location: $_currentLocation
Type: $_selectedLocationType
Date: ${widget.selectedDate != null ? widget.selectedDate.toString().split(" ")[0] : "Not selected"}
Session: ${widget.selectedSession}
Time: ${widget.selectedTime}
Include Instruments: ${widget.includeInstruments ? "Yes" : "No"}
Rooms: ${widget.selectedRooms.join(", ")}
Colors: ${widget.selectedColors.isNotEmpty ? widget.selectedColors.map((c) => c.value.toRadixString(16)).join(", ") : "None"}
Required Persons: ${widget.requiredPersons}
          ''',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar like Office Shifting
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              height: height * 0.08,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: width * 0.06),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white, size: width * 0.06),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Main Body
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white, // <-- Main body white
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  children: [
                    // Top Info Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.home, color: Colors.green),
                            SizedBox(width: width * 0.02),
                            Text('${widget.requiredPersons} Person(s)'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.orange),
                            SizedBox(width: width * 0.02),
                            Text(widget.selectedDate != null
                                ? widget.selectedDate.toString().split(" ")[0]
                                : "Pick Date"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

                    // Map / Location Placeholder
                    Container(
                      height: height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Icon(Icons.location_on, color: Colors.orange, size: width * 0.12),
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    // Location Details
                    if (_isLocationDetailVisible)
                      GestureDetector(
                        onTap: _toggleLocationDetail,
                        child: Container(
                          padding: EdgeInsets.all(width * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.location_pin, color: Colors.orange),
                                  SizedBox(width: width * 0.02),
                                  Text(_currentLocation),
                                ],
                              ),
                              const Icon(Icons.close, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: height * 0.03),

                    // Location Type Buttons like Office Shifting
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _CircleButton(
                          icon: Icons.home,
                          label: 'Home',
                          isSelected: _selectedLocationType == 'Home',
                          onTap: () => _selectLocationType('Home'),
                        ),
                        _CircleButton(
                          icon: Icons.work,
                          label: 'Work',
                          isSelected: _selectedLocationType == 'Work',
                          onTap: () => _selectLocationType('Work'),
                        ),
                        _CircleButton(
                          icon: Icons.add,
                          label: 'Add',
                          isSelected: _selectedLocationType == 'Add New',
                          onTap: () => _selectLocationType('Add New'),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Proceed Button
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.06,
                      child: ElevatedButton(
                        onPressed: _onProceed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'proceed',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.045,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
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

// Circle Button Widget
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CircleButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.18,
        height: width * 0.18,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade100 : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: width * 0.08, color: isSelected ? Colors.orange : Colors.black),
            SizedBox(height: width * 0.02),
            Text(label, style: TextStyle(fontSize: width * 0.035)),
          ],
        ),
      ),
    );
  }
}
