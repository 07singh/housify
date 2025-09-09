import 'package:flutter/material.dart';

void main() {
  runApp(DateTimePickerApp());
}

class DateTimePickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DateTimePickerScreen(),
    );
  }
}

class DateTimePickerScreen extends StatefulWidget {
  @override
  _DateTimePickerScreenState createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  DateTime selectedDate = DateTime(2025, 7, 11);
  String selectedTimeSlot = "Afternoon";
  String selectedTime = "07:00 AM";
  bool includeInstruments = true;

  final List<String> timeSlots = ["Afternoon", "Late Morning"];
  final List<String> times = ["07:00 AM", "11:00 AM", "12:00 PM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Choose Date & Time", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                top: 10,
                right: 12,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month and Year with navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "July, 2025",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back_ios, size: 16),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Calendar mock (simplified static)
            Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 12,
              children: List.generate(31, (index) {
                DateTime date = DateTime(2025, 7, index + 1);
                bool isSelected = selectedDate.day == date.day;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amber : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 24),
            Text("Pick time", style: TextStyle(fontSize: 16, color: Colors.grey)),

            SizedBox(height: 12),
            // Time Slot Selection
            Row(
              children: timeSlots.map((slot) {
                bool isSelected = selectedTimeSlot == slot;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTimeSlot = slot;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amber : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      slot,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 16),

            // Time Buttons
            Row(
              children: times.map((time) {
                bool isSelected = selectedTime == time;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amber.shade100 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: isSelected ? Colors.amber : Colors.transparent),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 16),

            // Checkbox
            Row(
              children: [
                Checkbox(
                  value: includeInstruments,
                  onChanged: (value) {
                    setState(() {
                      includeInstruments = value!;
                    });
                  },
                  activeColor: Colors.amber,
                ),
                Text("Include All painting Instruments"),
              ],
            ),

            Spacer(),

            // Proceed Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle proceed
                },
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
    );
  }
}
