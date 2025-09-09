import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Moving App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HouseMovingScreen(),
    );
  }
}

class HouseMovingScreen extends StatefulWidget {
  const HouseMovingScreen({super.key});

  @override
  State<HouseMovingScreen> createState() => _HouseMovingScreenState();
}

class _HouseMovingScreenState extends State<HouseMovingScreen> {
  int selectedRoomOption = 0;
  int selectedTimeSlot = 0;
  int selectedVehicle = 0;
  DateTime selectedDate = DateTime(2025, 7, 15); // Default to July 15, 2025

  final List<String> roomOptions = [
    "2 Redrooms\n1 Kitchen",
    "3 Redrooms\n1 Kitchen",
    "4 Redrooms\n1 Kitchen",
  ];

  final List<String> timeSlots = [
    "07:00 AM",
    "11:00 AM",
    "12:00",
  ];

  final List<String> vehicles = [
    "Mail Truck\n-18 Ton",
    "Pickup\n-12 Ton",
    "Large\n+5 ton",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Size'),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select your house rooms and kitchen in order to measure the total cost.',
                style: TextStyle(fontSize: 16),
              ),
            ),

            // Room options
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: roomOptions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRoomOption = index;
                      });
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedRoomOption == index
                              ? Colors.blue
                              : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        roomOptions[index],
                        style: TextStyle(
                          fontWeight: selectedRoomOption == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Furniture section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Furnitures',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Furniture items
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FurnitureItem(name: 'Bed'),
                  FurnitureItem(name: 'Sala'),
                  FurnitureItem(name: 'Chair'),
                  FurnitureItem(name: 'Alaska'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FurnitureItem(name: 'AC'),
                  FurnitureItem(name: 'fridge'),
                  FurnitureItem(name: 'Own'),
                  FurnitureItem(name: 'TV'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FurnitureItem(name: 'Waterlabs'),
                  FurnitureItem(name: 'Add'),
                  SizedBox(width: 80),
                  SizedBox(width: 80),
                ],
              ),
            ),

            // Packed Boxes section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Packed Boxes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Weight taken 10 kg'),
                ],
              ),
            ),

            // Proceed button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Proceed'),
                ),
              ),
            ),

            // Schedule Shifting section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Schedule Shifting',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Summary of selection
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2 Redrooms\n1 Kitchen'),
                  SizedBox(height: 8),
                  Text('5 Furniture'),
                  SizedBox(height: 8),
                  Text('10 Box'),
                ],
              ),
            ),

            // Calendar section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'July, 2025',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Calendar days
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Table(
                children: [
                  // Week days header
                  const TableRow(
                    children: [
                      CalendarDay(day: 'Mo'),
                      CalendarDay(day: 'Tu'),
                      CalendarDay(day: 'Wa'),
                      CalendarDay(day: 'Th'),
                      CalendarDay(day: 'Fr'),
                      CalendarDay(day: 'Sa'),
                      CalendarDay(day: 'Su'),
                    ],
                  ),
                  // Week 1
                  TableRow(
                    children: [
                      const CalendarDay(day: '1'),
                      const CalendarDay(day: '2'),
                      const CalendarDay(day: '3'),
                      const CalendarDay(day: '4'),
                      const CalendarDay(day: '5'),
                      const CalendarDay(day: '6'),
                      CalendarDay(
                        day: '7',
                        isSelected: selectedDate.day == 7,
                      ),
                    ],
                  ),
                  // Week 2
                  TableRow(
                    children: [
                      const CalendarDay(day: '8'),
                      const CalendarDay(day: '9'),
                      const CalendarDay(day: '10'),
                      const CalendarDay(day: '11'),
                      const CalendarDay(day: '12'),
                      const CalendarDay(day: '13'),
                      CalendarDay(
                        day: '14',
                        isSelected: selectedDate.day == 14,
                      ),
                    ],
                  ),
                  // Week 3
                  TableRow(
                    children: [
                      CalendarDay(
                        day: '15',
                        isSelected: selectedDate.day == 15,
                      ),
                      const CalendarDay(day: '16'),
                      const CalendarDay(day: '17'),
                      const CalendarDay(day: '18'),
                      const CalendarDay(day: '19'),
                      const CalendarDay(day: '20'),
                      const CalendarDay(day: '21'),
                    ],
                  ),
                  // Week 4
                  TableRow(
                    children: [
                      const CalendarDay(day: '22'),
                      const CalendarDay(day: '23'),
                      const CalendarDay(day: '24'),
                      const CalendarDay(day: '25'),
                      const CalendarDay(day: '26'),
                      const CalendarDay(day: '27'),
                      const CalendarDay(day: '28'),
                    ],
                  ),
                  // Week 5
                  TableRow(
                    children: [
                      const CalendarDay(day: '29'),
                      const CalendarDay(day: '30'),
                      const CalendarDay(day: '31'),
                      const CalendarDay(day: ''),
                      const CalendarDay(day: ''),
                      const CalendarDay(day: ''),
                      const CalendarDay(day: ''),
                    ],
                  ),
                ],
              ),
            ),

            // Pick time section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pick time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Time slots
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(timeSlots.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeSlot = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedTimeSlot == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(timeSlots[index]),
                    ),
                  );
                }),
              ),
            ),

            // Workers section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Workers',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  // This would typically be a dropdown or selection widget
                  Text('2'),
                ],
              ),
            ),

            // Electrical work
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Electrical\nRepeat work \$10m. Total cost will be calculated later',
                style: TextStyle(fontSize: 16),
              ),
            ),

            // Price summary
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('- 2 Redrooms'),
                  Text('- 1 Kitchen'),
                  Text('- 5 Furniture'),
                  Text('- 10 Box'),
                ],
              ),
            ),

            // Time and date display
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    '9:41',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Friday, May 11, 2025'),
                      Text('450 pm'),
                    ],
                  ),
                ],
              ),
            ),

            // Destination selection
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Destination',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('2045 Lodgerville Street, Esgan'),
                  SizedBox(height: 4),
                  Text('2045 Lodgerville Road, Esgan...'),
                  SizedBox(height: 4),
                  Text('3320 Joyce Stree'),
                ],
              ),
            ),

            // Vehicle selection
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Vehicle Selection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Vehicle options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(vehicles.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedVehicle = index;
                      });
                    },
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedVehicle == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        vehicles[index],
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Final proceed button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Proceed'),
                ),
              ),
            ),

            // Confirm section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class FurnitureItem extends StatelessWidget {
  final String name;

  const FurnitureItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon would go here based on furniture type
          const Icon(Icons.chair, size: 30),
          const SizedBox(height: 4),
          Text(name),
        ],
      ),
    );
  }
}

class CalendarDay extends StatelessWidget {
  final String day;
  final bool isSelected;

  const CalendarDay({
    super.key,
    required this.day,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}