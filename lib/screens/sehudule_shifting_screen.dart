import 'shifthing_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ScheduleShiftingScreen(),
    );
  }
}

class ScheduleShiftingScreen extends StatefulWidget {
  const ScheduleShiftingScreen({super.key});

  @override
  State<ScheduleShiftingScreen> createState() => _ScheduleShiftingScreenState();
}

class _ScheduleShiftingScreenState extends State<ScheduleShiftingScreen> {
  int workers = 0;
  int electricians = 0;
  int selectedDay = 1;
  int selectedTime = -1;

  DateTime currentMonth = DateTime(2025, 7);
  final List<String> times = ["07:00 AM", "11:00 AM", "12:00 PM"];

  int getDaysInMonth(DateTime date) {
    final firstDayThisMonth = DateTime(date.year, date.month, 1);
    final firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  int getFirstWeekday(DateTime date) {
    int wd = DateTime(date.year, date.month, 1).weekday;
    return wd % 7;
  }

  void prevMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
      selectedDay = 1;
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      selectedDay = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = getDaysInMonth(currentMonth);
    int firstWeekday = getFirstWeekday(currentMonth);

    List<Widget> dayWidgets = [];
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(Container());
    }
    for (int day = 1; day <= daysInMonth; day++) {
      bool isSelected = day == selectedDay;
      dayWidgets.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedDay = day;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Text(
            "$day",
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1C2526), // black background
      body: SafeArea(
        child: Column(
          children: [
            // ✅ AppBar like Cleaning Service
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 28)),
                  const Text(
                    "Schedule Shifting",
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications, color: Colors.white, size: 24),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ White Container for content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      children: [
                        // Info Cards
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            infoCard(Icons.home, "2 Bedrooms\n1 Kitchen"),
                            infoCard(Icons.chair, "12 Furniture"),
                            infoCard(Icons.inventory_2, "10 Boxes"),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Calendar Title
                        Row(
                          children: [
                            Text(
                              DateFormat("MMMM, yyyy").format(currentMonth),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 16),
                              onPressed: prevMonth,
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, size: 16),
                              onPressed: nextMonth,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Calendar Grid
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text("Mo", style: TextStyle(color: Colors.orange)),
                            Text("Tu", style: TextStyle(color: Colors.orange)),
                            Text("We", style: TextStyle(color: Colors.orange)),
                            Text("Th", style: TextStyle(color: Colors.orange)),
                            Text("Fr", style: TextStyle(color: Colors.orange)),
                            Text("Sa", style: TextStyle(color: Colors.orange)),
                            Text("Su", style: TextStyle(color: Colors.orange)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 7,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: dayWidgets,
                        ),
                        const SizedBox(height: 20),

                        // Pick Time
                        const Text("Pick time", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(times.length, (index) {
                            bool isSelected = selectedTime == index;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSelected ? Colors.orange : Colors.grey.shade200,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedTime = index;
                                    });
                                  },
                                  child: Text(
                                    times[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 20),

                        // Workers & Electricians
                        workerCard(
                          icon: Icons.person,
                          title: "Workers",
                          subtitle: "Regular cost is \$5/hr. Total cost will be calculated later",
                          value: workers,
                          onAdd: () => setState(() => workers++),
                          onRemove: () => setState(() { if (workers > 0) workers--; }),
                        ),
                        workerCard(
                          icon: Icons.flash_on,
                          title: "Electrician",
                          subtitle: "Regular cost is \$10/hr. Total cost will be calculated later",
                          value: electricians,
                          onAdd: () => setState(() => electricians++),
                          onRemove: () => setState(() { if (electricians > 0) electricians--; }),
                        ),

                        const SizedBox(height: 120),
                      ],
                    ),

                    // ✅ Bottom Proceed Button - Full Width like House Shifting
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56, // same height as HouseShifting button
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShiftingDetailsScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Proceed",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
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
      ),
    );
  }

  // --- Widgets ---
  Widget infoCard(IconData icon, String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange, size: 22),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget workerCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required int value,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              counterButton(Icons.remove, onRemove),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "$value",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              counterButton(Icons.add, onAdd),
            ],
          ),
        ],
      ),
    );
  }

  Widget counterButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.orange),
      ),
    );
  }
}
