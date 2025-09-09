import 'package:flutter/material.dart';
import 'package:house_service/screens/painting_choose_screen.dart';
import 'notification_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaintingServiceScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PaintingServiceScreen extends StatefulWidget {
  @override
  _PaintingServiceScreenState createState() => _PaintingServiceScreenState();
}

class _PaintingServiceScreenState extends State<PaintingServiceScreen> {
  String? selectedRoom;
  List<Color> selectedColors = [];
  int requiredPersons = 0;

  final List<Map<String, dynamic>> rooms = [
    {'name': 'Full House', 'description': '3 room Kitchen', 'icon': Icons.home},
    {'name': 'Large House', 'description': '4 room Kitchen', 'icon': Icons.home_work},
    {'name': 'Others', 'description': 'Backyard & Garage', 'icon': Icons.garage},
  ];

  final List<Color> colors = [
    Color(0xFFF5A623),
    Colors.purple,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2526),
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Top AppBar Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const Text(
                    'Painting Service',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Icon(Icons.notifications, color: Colors.white, size: 24),
                ],
              ),
            ),

            // ✅ Full White Container Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    // Scrollable Content
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔥 Painting Header
                          Row(
                            children: [
                              const Icon(Icons.brush,
                                  color: Color(0xFFF5A623), size: 32),
                              const SizedBox(width: 8),
                              const Text(
                                'Painting',
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFF5A623),
                                  side: const BorderSide(color: Color(0xFFF5A623)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                child: const Text('+ Custom'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Select your rooms and place correctly in order to measure estimated cost.',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 16),

                          // 🔥 Offers Section (Scrollable Row)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  width: 220,
                                  margin: const EdgeInsets.only(right: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5A623),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Row(
                                        children: [
                                          Text('Shifty',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          Spacer(),
                                          Icon(Icons.person,
                                              color: Colors.white, size: 64),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text('40% OFF',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      Text('On First Cleaning Service',
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 220,
                                  margin: const EdgeInsets.only(right: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Shifty',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16)),
                                      SizedBox(height: 8),
                                      Text('10% OFF',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      Text('Online Pay',
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 🔥 Room Selection (Equal Containers)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: rooms.map((room) {
                              bool isSelected = selectedRoom == room['name'];
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRoom = room['name'];
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFF5A623).withOpacity(0.1)
                                          : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFFF5A623)
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(room['icon'],
                                            size: 36, color: Colors.grey[600]),
                                        const SizedBox(height: 6),
                                        Text(room['name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                        Text(room['description'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.grey, fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),

                          // 🔥 Color Selection
                          const Text('Choose Color',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ...colors.map((color) {
                                bool isSelected = selectedColors.contains(color);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedColors.remove(color);
                                      } else {
                                        selectedColors.add(color);
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: color,
                                        ),
                                        if (isSelected)
                                          const Icon(Icons.check,
                                              color: Colors.white, size: 20),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // 🔥 Required Person
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                const Color(0xFFF5A623).withOpacity(0.2),
                                child: const Icon(Icons.person,
                                    color: Color(0xFFF5A623)),
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text('Required Person'),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      if (requiredPersons > 0) {
                                        setState(() => requiredPersons--);
                                      }
                                    },
                                  ),
                                  Text('$requiredPersons',
                                      style: const TextStyle(fontSize: 16)),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      setState(() => requiredPersons++);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    // ✅ Proceed Button
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedRoom != null &&
                                selectedColors.isNotEmpty &&
                                requiredPersons > 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseDateTimeScreen(
                                    selectedRooms: [selectedRoom!],
                                    selectedColors: selectedColors,
                                    requiredPersons: requiredPersons,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please select one room, at least one color, and person.')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5A623),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            'Proceed',
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
      ),
    );
  }
}
