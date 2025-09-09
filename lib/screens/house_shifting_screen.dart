import 'package:flutter/material.dart';
import 'package:house_service/screens/sehudule_shifting_screen.dart';

class HouseShiftingScreen extends StatefulWidget {
  const HouseShiftingScreen({Key? key}) : super(key: key);

  @override
  State<HouseShiftingScreen> createState() => _HouseShiftingScreenState();
}

class _HouseShiftingScreenState extends State<HouseShiftingScreen> {
  final List<Map<String, dynamic>> houseSizes = [
    {"title": "2BHK", "subtitle": "2 Bedrooms 1 Kitchen", "icon": Icons.home},
    {"title": "3BHK", "subtitle": "3 Bedrooms 1 Kitchen", "icon": Icons.home_filled},
    {"title": "4BHK", "subtitle": "4 Bedrooms 1 Kitchen", "icon": Icons.house},
    {"title": "Custom", "subtitle": "Choose yourself", "icon": Icons.add_home},
  ];

  String? selectedHouse;

  final Map<String, int> furnitures = {
    "Bed": 0,
    "Sofa": 0,
    "Chair": 0,
    "Almira": 0,
    "AC": 0,
    "Fridge": 0,
    "Oven": 0,
    "TV": 0,
    "Wardrobe": 0,
  };

  final Map<String, IconData> furnitureIcons = {
    "Bed": Icons.bed,
    "Sofa": Icons.chair,
    "Chair": Icons.event_seat,
    "Almira": Icons.inventory,
    "AC": Icons.ac_unit,
    "Fridge": Icons.kitchen,
    "Oven": Icons.microwave,
    "TV": Icons.tv,
    "Wardrobe": Icons.storage,
  };

  int packedBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _Header(onBack: () => Navigator.pop(context)),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        const SizedBox(height: 10),
                        const Text("House Size",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text(
                          "Select your house rooms and kitchen in order to measure the total cost.",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 12),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: houseSizes.map((house) {
                              int index = houseSizes.indexOf(house);
                              return Row(
                                children: [
                                  _houseSizeCard(
                                    title: house["title"],
                                    subtitle: house["subtitle"],
                                    icon: house["icon"],
                                    selected: selectedHouse == house["title"],
                                    onTap: () =>
                                        setState(() => selectedHouse = house["title"]),
                                  ),
                                  if (index != houseSizes.length - 1)
                                    const SizedBox(width: 12),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        const Text("Furnitures",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text(
                          "Approximate furnitures",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 12),

                        GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: furnitures.keys.map((item) {
                            int count = furnitures[item]!;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => furnitures[item] = count + 1),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.grey.shade300, width: 1),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(furnitureIcons[item] ?? Icons.category,
                                              color: Colors.orange, size: 26),
                                          const SizedBox(height: 6),
                                          Text(item,
                                              style: const TextStyle(fontSize: 13)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (count > 0)
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.orange,
                                      child: Text("$count",
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.white)),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),
                        const Text("Packed Boxes",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text(
                          "Weight below 10 Kg",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.inventory_2,
                                      color: Colors.orange, size: 28),
                                  SizedBox(width: 12),
                                  Text("Packed Boxes",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.black54),
                                    onPressed: () => setState(() =>
                                    packedBoxes =
                                    packedBoxes > 0 ? packedBoxes - 1 : 0),
                                  ),
                                  Text("$packedBoxes",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.black54),
                                    onPressed: () =>
                                        setState(() => packedBoxes++),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 90),
                      ],
                    ),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const ScheduleShiftingScreen()),
                              );
                            },
                            child: const Text("Proceed",
                                style:
                                TextStyle(color: Colors.white, fontSize: 18)),
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

  Widget _Header({required VoidCallback onBack}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: onBack, child: const Icon(Icons.arrow_back, color: Colors.white)),
          const Text(
            "House Shifting Service",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Stack(
            children: [
              const Icon(Icons.notifications, color: Colors.white),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration:
                  const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _houseSizeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: selected ? Colors.orange : Colors.grey.shade300,
                  width: selected ? 2 : 1),
            ),
            child: Stack(
              children: [
                Center(child: Icon(icon, size: 36, color: Colors.black54)),
                if (selected)
                  const Positioned(
                    right: 6,
                    top: 6,
                    child: Icon(Icons.check_circle, color: Colors.orange, size: 20),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
