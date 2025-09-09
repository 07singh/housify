import 'package:flutter/material.dart';
import 'notification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CommercialShiftingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CommercialShiftingScreen extends StatefulWidget {
  const CommercialShiftingScreen({super.key});

  @override
  State<CommercialShiftingScreen> createState() =>
      _CommercialShiftingScreenState();
}

class _CommercialShiftingScreenState extends State<CommercialShiftingScreen> {
  int heavyItemCount = 0;
  int workerCount = 0;
  int electricianCount = 0;

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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const _IndustrySizeSection(),
                    const SizedBox(height: 10),
                    const _FloorSizeDropdown(),
                    const SizedBox(height: 10),
                    const _IndustryTypeDropdown(),
                    const SizedBox(height: 10),
                    const _NotesSection(),

                    // 🔹 Divider only once between Industry Size section & Heavy Item
                    const SizedBox(height: 20),
                    const Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 20),

                    // Counters
                    _buildCounterSection(
                      title: 'Heavy Item',
                      subtitle:
                      'For automated machines we charge 10 per item',
                      count: heavyItemCount,
                      onAdd: () => setState(() => heavyItemCount++),
                      onRemove: () {
                        if (heavyItemCount > 0) {
                          setState(() => heavyItemCount--);
                        }
                      },
                    ),
                    _buildCounterSection(
                      title: 'Workers',
                      subtitle:
                      'Regular cost is 5/hr. Total cost will be calculated later',
                      count: workerCount,
                      onAdd: () => setState(() => workerCount++),
                      onRemove: () {
                        if (workerCount > 0) {
                          setState(() => workerCount--);
                        }
                      },
                    ),
                    _buildCounterSection(
                      title: 'Electrician',
                      subtitle:
                      'Regular cost is 10/hr. Total cost will be calculated later',
                      count: electricianCount,
                      onAdd: () => setState(() => electricianCount++),
                      onRemove: () {
                        if (electricianCount > 0) {
                          setState(() => electricianCount--);
                        }
                      },
                    ),
                    const SizedBox(height: 80), // Button ke liye space
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            // Proceed ka logic yaha likho
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            minimumSize: const Size(double.infinity, 50),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Proceed'),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onBack;
  const _Header({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: onBack,
              child: const Icon(Icons.arrow_back, color: Colors.white)),
          const Text(
            'Commercial Shifting',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Icon(Icons.notifications, color: Colors.white),
        ],
      ),
    );
  }
}

class _IndustrySizeSection extends StatelessWidget {
  const _IndustrySizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Industry Size',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.orange),
          ),
          child: const Text('+ Add', style: TextStyle(color: Colors.orange)),
        ),
      ],
    );
  }
}

class _FloorSizeDropdown extends StatelessWidget {
  const _FloorSizeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: 'Large (200 Sqft+)',
      items: const [
        DropdownMenuItem(
          value: 'Large (200 Sqft+)',
          child: Text('Large (200 Sqft+)'),
        ),
      ],
      onChanged: (_) {},
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color(0xFFE0E0E0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _IndustryTypeDropdown extends StatelessWidget {
  const _IndustryTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: 'Chemical Supplier',
      items: const [
        DropdownMenuItem(
          value: 'Chemical Supplier',
          child: Text('Chemical Supplier'),
        ),
      ],
      onChanged: (_) {},
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color(0xFFE0E0E0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _NotesSection extends StatelessWidget {
  const _NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'NOTES',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: 'Type here...',
            filled: true,
            fillColor: Color(0xFFE0E0E0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}

Widget _buildCounterSection({
  required String title,
  required String subtitle,
  required int count,
  required VoidCallback onAdd,
  required VoidCallback onRemove,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title + Counter Row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                title == 'Heavy Item'
                    ? Icons.local_shipping
                    : (title == 'Electrician'
                    ? Icons.flash_on
                    : Icons.person),
                color: Colors.orange,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.remove), onPressed: onRemove),
              Text('$count',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.add), onPressed: onAdd),
            ],
          ),
        ],
      ),

      const SizedBox(height: 5),
      Text(subtitle, style: const TextStyle(color: Colors.grey)),
      const SizedBox(height: 10),
    ],
  );
}
