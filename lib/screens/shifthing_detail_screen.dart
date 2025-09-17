import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'select_destation_screen.dart';
import 'package:geocoding/geocoding.dart';

class ShiftingDetailsScreen extends StatefulWidget {
  final String selectedHouse;
  final Map<String, int> furnitures;
  final int packedBoxes;
  final DateTime selectedDate;
  final String selectedTime;
  final int workers;
  final int electricians;

  const ShiftingDetailsScreen({
    Key? key,
    required this.selectedHouse,
    required this.furnitures,
    required this.packedBoxes,
    required this.selectedDate,
    required this.selectedTime,
    required this.workers,
    required this.electricians,
  }) : super(key: key);

  @override
  _ShiftingDetailsScreenState createState() => _ShiftingDetailsScreenState();
}

class _ShiftingDetailsScreenState extends State<ShiftingDetailsScreen> {
  String selectedVehicle = 'Mini Truck';

  // Example pickup & drop coordinates
  final LatLng pickupLocation = LatLng(28.6139, 77.2090); // Delhi
  final LatLng dropLocation = LatLng(28.7041, 77.1025); // Another point

  String pickupAddress = "Loading pickup...";
  String dropAddress = "Loading drop...";

  @override
  void initState() {
    super.initState();
    _getAddresses();
  }

  Future<void> _getAddresses() async {
    try {
      List<Placemark> pickupPlacemarks = await placemarkFromCoordinates(
        pickupLocation.latitude,
        pickupLocation.longitude,
      );
      List<Placemark> dropPlacemarks = await placemarkFromCoordinates(
        dropLocation.latitude,
        dropLocation.longitude,
      );

      setState(() {
        pickupAddress =
        "${pickupPlacemarks.first.street}, ${pickupPlacemarks.first.locality}";
        dropAddress =
        "${dropPlacemarks.first.street}, ${dropPlacemarks.first.locality}";
      });
    } catch (e) {
      setState(() {
        pickupAddress = "Pickup address not found";
        dropAddress = "Drop address not found";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Custom AppBar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Column(
                    children: [
                      Text(
                        _formatDate(widget.selectedDate),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.selectedTime,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications, color: Colors.white),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ White Content Section with Map
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    // ✅ FlutterMap (OpenStreetMap)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: FlutterMap(
                          options: MapOptions(
                            center: pickupLocation,
                            zoom: 12.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                              userAgentPackageName: 'com.example.yourapp', // Required in v5+
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: pickupLocation,
                                  width: 40,
                                  height: 40,
                                  builder: (ctx) =>
                                  const Icon(Icons.home, color: Colors.green, size: 40),
                                ),
                                Marker(
                                  point: dropLocation,
                                  width: 40,
                                  height: 40,
                                  builder: (ctx) =>
                                  const Icon(Icons.location_on, color: Colors.red, size: 40),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Floating Info Chips
                    Positioned(
                      top: 12,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildChip(Icons.home, widget.selectedHouse),
                            _buildChip(Icons.chair,
                                '${widget.furnitures.length} Furniture'),
                            _buildChip(Icons.inventory,
                                '${widget.packedBoxes} Boxes'),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Bottom Section with addresses + vehicles + button
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildBottomSection(),
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

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pickup & Drop
          // Pickup & Drop
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.circle, size: 12, color: Colors.black),
                  const SizedBox(width: 8),
                  Expanded(child: Text(pickupAddress)),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(child: Text(dropAddress)),
                ],
              ),
            ],
          ),

          // Vehicles horizontal
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildVehicleCard('Mini Truck', '~1.8 Ton', 'assets/truck.png'),
                _buildVehicleCard('Pickup', '~1.2 Ton', 'assets/truck.png'),
                _buildVehicleCard('Large', '~5 Ton', 'assets/truck.png'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Proceed button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectDestinationScreen(
                      selectedHouse: widget.selectedHouse,
                      furnitures: widget.furnitures,
                      packedBoxes: widget.packedBoxes,
                      workers: widget.workers,
                      electricians: widget.electricians,
                      selectedDate: widget.selectedDate,
                      selectedTime: widget.selectedTime,
                      selectedVehicle: selectedVehicle,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Proceed',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers ---
  String _formatDate(DateTime date) => "${date.day}-${date.month}-${date.year}";

  Widget _buildChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange, size: 18),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildVehicleCard(String title, String capacity, String imagePath) {
    final isSelected = selectedVehicle == title;
    return GestureDetector(
      onTap: () => setState(() => selectedVehicle = title),
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 50),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(capacity, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
