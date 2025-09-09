import 'package:flutter/material.dart';
import 'notification_screen.dart';



class OfficeShiftingScreen extends StatefulWidget {
  const OfficeShiftingScreen({super.key});

  @override
  State<OfficeShiftingScreen> createState() => _OfficeShiftingScreenState();
}

class _OfficeShiftingScreenState extends State<OfficeShiftingScreen> {
  int packedBoxes = 0;
  int workers = 0;
  int electricians = 0;
  String? selectedOfficeSize;

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white)),
                  const Text(
                    'Office Shifting Service',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const NotificationScreen()));
                    },
                    child: const Icon(Icons.notifications, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child: Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        // Office Size Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Office Size',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.orange),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text('+ Custom', style: TextStyle(color: Colors.orange)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // ✅ Niche Description Line
                        const Text(
                          'Select your office rooms to help us calculate the shifting cost accurately.',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 12),

                        // Office Size Choices
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _officeSizeCard(
                              title: 'Small Office',
                              subtitle: '2 or less rooms',
                              color: Colors.lightBlue[100]!,
                              selected: selectedOfficeSize == 'Small Office',
                              onTap: () => setState(() => selectedOfficeSize = 'Small Office'),
                            ),
                            _officeSizeCard(
                              title: 'Large Office',
                              subtitle: '3 rooms',
                              color: Colors.yellow[100]!,
                              selected: selectedOfficeSize == 'Large Office',
                              onTap: () => setState(() => selectedOfficeSize = 'Large Office'),
                            ),
                            _officeSizeCard(
                              title: 'Multiple Office',
                              subtitle: '4 or more rooms',
                              color: Colors.pink[100]!,
                              selected: selectedOfficeSize == 'Multiple Office',
                              onTap: () => setState(() => selectedOfficeSize = 'Multiple Office'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey),

                        // Office Items Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Office Items',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('${selectedItems.length} Selected',
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _ItemChip(
                              title: 'Table',
                              color: Colors.lightBlue,
                              selected: selectedItems.contains('Table'),
                              onTap: () => _toggleItem('Table'),
                            ),
                            _ItemChip(
                              title: 'Sofa',
                              color: Colors.orange,
                              selected: selectedItems.contains('Sofa'),
                              onTap: () => _toggleItem('Sofa'),
                            ),
                            _ItemChip(
                              title: 'Chair',
                              color: Colors.green,
                              selected: selectedItems.contains('Chair'),
                              onTap: () => _toggleItem('Chair'),
                            ),
                            _ItemChip(
                              title: 'AC',
                              color: Colors.red,
                              selected: selectedItems.contains('AC'),
                              onTap: () => _toggleItem('AC'),
                            ),
                            _ItemChip(
                              title: '+',
                              color: Colors.grey,
                              selected: false,
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey),

                        // Packed Boxes Counter
                        _counterRow(
                          icon: Icons.inventory,
                          title: 'Packed Boxes',
                          subtitle: 'Weight below 10Kg',
                          count: packedBoxes,
                          onAdd: () => setState(() => packedBoxes++),
                          onRemove: () =>
                              setState(() => packedBoxes = packedBoxes > 0 ? packedBoxes - 1 : 0),
                        ),

                        // Workers Counter
                        _counterRow(
                          icon: Icons.groups_2,
                          title: 'Workers',
                          subtitle: 'Regular cost is 5/hr',
                          count: workers,
                          onAdd: () => setState(() => workers++),
                          onRemove: () =>
                              setState(() => workers = workers > 0 ? workers - 1 : 0),
                        ),

                        // Electricians Counter
                        _counterRow(
                          icon: Icons.flash_on,
                          title: 'Electricians',
                          subtitle: 'Regular cost is 10/hr',
                          count: electricians,
                          onAdd: () => setState(() => electricians++),
                          onRemove: () =>
                              setState(() => electricians = electricians > 0 ? electricians - 1 : 0),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),

                    // ✅ Proceed button
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Your proceed logic
                        },
                        child: const Text('Proceed',
                            style: TextStyle(color: Colors.white, fontSize: 18)),
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

  void _toggleItem(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  Widget _officeSizeCard({
    required String title,
    required String subtitle,
    required Color color,
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
              color: color,
              borderRadius: BorderRadius.circular(15),
              border: selected ? Border.all(color: Colors.orange, width: 2) : null,
              boxShadow: selected
                  ? [
                BoxShadow(
                    color: Colors.orange.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ]
                  : null,
            ),
            child: const Center(child: Icon(Icons.business, size: 40)),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _counterRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.remove), onPressed: onRemove),
              Text('$count', style: const TextStyle(fontSize: 18)),
              IconButton(icon: const Icon(Icons.add), onPressed: onAdd),
            ],
          )
        ],
      ),
    );
  }
}

class _ItemChip extends StatelessWidget {
  final String title;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _ItemChip({
    required this.title,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: selected ? Colors.orange : color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
        ),
      ),
    );
  }
}
