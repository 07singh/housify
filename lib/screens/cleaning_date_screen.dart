import 'package:flutter/material.dart';
import 'cleaning_location_screen.dart';
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
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  String? _selectedSession;
  String? _selectedTime;
  bool _includeInstruments = false;

  final List<String> sessions = ["Morning", "Late Morning", "Afternoon", "Evening"];
  final Map<String, List<String>> timeSlots = {
    "Morning": ["07:00 AM", "08:00 AM", "09:00 AM"],
    "Late Morning": ["10:00 AM", "11:00 AM"],
    "Afternoon": ["12:00 PM", "01:00 PM", "02:00 PM"],
    "Evening": ["05:00 PM", "06:00 PM", "07:00 PM"],
  };

  void _goToLocationScreen() {
    if (_selectedDate != null && _selectedSession != null && _selectedTime != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            selectedDate: _selectedDate!,
            selectedTimePeriod: _selectedSession!,
            selectedTime: _selectedTime!,
            includeInstruments: _includeInstruments,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all selections")),
      );
    }
  }

  Widget _buildCalendar() {
    final daysInMonth = List.generate(
      DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day,
          (i) => DateTime(_focusedDate.year, _focusedDate.month, i + 1),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${_monthName(_focusedDate.month)}, ${_focusedDate.year}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Weekdays
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text("Mo"), Text("Tu"), Text("We"), Text("Th"),
            Text("Fr"), Text("Sa"), Text("Su"),
          ],
        ),

        const SizedBox(height: 8),

        // Dates
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: daysInMonth.map((day) {
            final isSelected = _selectedDate?.day == day.day &&
                _selectedDate?.month == day.month &&
                _selectedDate?.year == day.year;
            return GestureDetector(
              onTap: () => setState(() => _selectedDate = day),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${day.day}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const months = [
      "January","February","March","April","May","June",
      "July","August","September","October","November","December"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // dark background same as painting
      body: Column(
        children: [
          // Custom AppBar
          SafeArea(
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white)
                  ),
                  const Text(
                    "Cleaning Service",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
            ),
          ),

          // White rounded body
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Selected Room: ${widget.selectedRoom}",
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Required Persons: ${widget.requiredPersons}"),
                        Text("Working Hours: ${widget.workingHours}"),
                        const SizedBox(height: 20),

                        _buildCalendar(),
                        const SizedBox(height: 20),

                        const Text("Pick time",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),

                        Wrap(
                          spacing: 12,
                          children: sessions.map((s) {
                            final selected = _selectedSession == s;
                            return ChoiceChip(
                              label: Text(s),
                              selected: selected,
                              onSelected: (_) => setState(() {
                                _selectedSession = s;
                                _selectedTime = null;
                              }),
                              selectedColor: Colors.green,
                              labelStyle: TextStyle(
                                color: selected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),

                        if (_selectedSession != null)
                          Wrap(
                            spacing: 12,
                            children: timeSlots[_selectedSession]!.map((t) {
                              final selected = _selectedTime == t;
                              return ChoiceChip(
                                label: Text(t),
                                selected: selected,
                                onSelected: (_) => setState(() => _selectedTime = t),
                                selectedColor: Colors.green,
                                labelStyle: TextStyle(
                                  color: selected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList(),
                          ),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Checkbox(
                              value: _includeInstruments,
                              onChanged: (v) => setState(() => _includeInstruments = v!),
                              activeColor: Colors.green,
                            ),
                            const Text("Include all cleaning instruments"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Proceed Button
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _goToLocationScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          "Proceed",
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
    );
  }
}
