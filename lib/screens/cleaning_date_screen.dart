import 'package:flutter/material.dart';
import 'cleaning_location_screen.dart'; // fixed import
import 'notification_screen.dart';
class CleaningDateServiceScreen extends StatefulWidget {
  final String selectedRoom;
  final int requiredPersons;
  final int workingHours;

  const CleaningDateServiceScreen({
    Key? key,
    required this.selectedRoom,
    required this.requiredPersons,
    required this.workingHours,
  }) : super(key: key);

  @override
  _CleaningDateServiceScreenState createState() => _CleaningDateServiceScreenState();
}

class _CleaningDateServiceScreenState extends State<CleaningDateServiceScreen> {
  DateTime currentMonth = DateTime.now();
  DateTime? selectedDate;
  String selectedTimePeriod = 'Afternoon';
  String? selectedTime;
  bool includeInstruments = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2526), // black bg same as History
      body: Column(
        children: [
          // ✅ Custom AppBar (same as History)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cleaning Service',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications, color: Colors.white, size: 24),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ✅ White rounded container for content
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selected Room: ${widget.selectedRoom}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Required Persons: ${widget.requiredPersons}',
                        style: const TextStyle(fontSize: 14)),
                    Text('Working Hours: ${widget.workingHours}',
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 16),

                    // ✅ Calendar Month Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_getMonthName(currentMonth.month)}, ${currentMonth.year}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 16),
                              onPressed: () {
                                setState(() {
                                  currentMonth =
                                      DateTime(currentMonth.year, currentMonth.month - 1, 1);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, size: 16),
                              onPressed: () {
                                setState(() {
                                  currentMonth =
                                      DateTime(currentMonth.year, currentMonth.month + 1, 1);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // ✅ Weekday Labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                          .map((day) => Text(
                        day,
                        style: const TextStyle(color: Colors.green, fontSize: 14),
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 10),

                    // ✅ Calendar Grid
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                        itemCount: _daysInMonth(currentMonth) + _firstDayOffset(currentMonth),
                        itemBuilder: (context, index) {
                          if (index < _firstDayOffset(currentMonth)) return Container();
                          final day = index - _firstDayOffset(currentMonth) + 1;
                          final date = DateTime(currentMonth.year, currentMonth.month, day);
                          final isSelected = selectedDate?.day == day &&
                              selectedDate?.month == currentMonth.month &&
                              selectedDate?.year == currentMonth.year;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Colors.green : Colors.transparent,
                              ),
                              child: Text(
                                '$day',
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ✅ Time Selection
                    const Text('Pick time',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimePeriodButton('Afternoon'),
                        _buildTimePeriodButton('Late Morning'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeButton('07:00 AM'),
                        _buildTimeButton('11:00 AM'),
                        _buildTimeButton('12:00'),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // ✅ Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: includeInstruments,
                          onChanged: (value) =>
                              setState(() => includeInstruments = value ?? true),
                          activeColor: Colors.green,
                        ),
                        const Text('Include cleaning instruments',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ✅ Proceed Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (selectedDate != null &&
                            selectedTime != null &&
                            selectedTimePeriod.isNotEmpty)
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationScreen(
                                selectedDate: selectedDate!,
                                selectedTimePeriod: selectedTimePeriod,
                                selectedTime: selectedTime!,
                                includeInstruments: includeInstruments,
                              ),
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Proceed',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePeriodButton(String period) {
    bool isSelected = selectedTimePeriod == period;
    return GestureDetector(
      onTap: () => setState(() => selectedTimePeriod = period),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          border: Border.all(color: isSelected ? Colors.green : Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          period,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildTimeButton(String time) {
    bool isSelected = selectedTime == time;
    return GestureDetector(
      onTap: () => setState(() => selectedTime = time),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          border: Border.all(color: isSelected ? Colors.green : Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          time,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  int _daysInMonth(DateTime month) => DateTime(month.year, month.month + 1, 0).day;

  int _firstDayOffset(DateTime month) => DateTime(month.year, month.month, 1).weekday - 1;

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
