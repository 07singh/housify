import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'shifthing_confrimation_screen.dart';
import '../services/api_service.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String selectedHouse;
  final Map<String, int> furnitures;
  final int packedBoxes;
  final int workers;
  final int electricians;
  final DateTime selectedDate;
  final String selectedTime;
  final String selectedVehicle;
  final Map<String, dynamic> location; // from previous screen

  const OrderDetailsScreen({
    super.key,
    required this.selectedHouse,
    required this.furnitures,
    required this.packedBoxes,
    required this.workers,
    required this.electricians,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedVehicle,
    required this.location,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int selectedCardIndex = -1; // -1 = none selected

  @override
  Widget build(BuildContext context) {
    int totalFurniture = widget.furnitures.values.fold(0, (a, b) => a + b);

    double houseCost = 22;
    double furnitureCost = 30 + (widget.packedBoxes > 0 ? 5 : 0);
    double workerCost = 15 + ((widget.workers + widget.electricians) > 1 ? 5 : 0);
    double vehicleCost = 20;
    double serviceCharge = 2;
    double promoDiscount = 20;
    double totalCost = houseCost + furnitureCost + workerCost + vehicleCost + serviceCharge - promoDiscount;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white)),
                  const Text(
                    "Order Details",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // MAP + Addresses
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  "assets/map.png",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text("847m", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildAddressRow(Icons.circle, "Pickup: ${widget.selectedHouse}"),
                          const SizedBox(height: 8),
                          _buildAddressRow(Icons.location_on, "Drop: ${widget.location['address']}", iconColor: Colors.green),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Order Details Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Order Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.edit, size: 18),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Order Items
                    _buildOrderItem("🏠", "${widget.selectedHouse}", "+\$5 for baby room", "\$$houseCost"),
                    _buildOrderItem("🛋️", "$totalFurniture Furniture, ${widget.packedBoxes} Boxes", "+\$5 for additional box", "\$$furnitureCost"),
                    _buildOrderItem("👷", "${widget.workers} Worker, ${widget.electricians} Electrician", "+\$5 for additional person", "\$$workerCost"),

                    const Divider(height: 32),

                    // Cost Details
                    _buildCostRow("Vehicle (${widget.selectedVehicle})", "\$$vehicleCost"),
                    _buildCostRow("Service Charge", "\$$serviceCharge"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: const [
                                  Text("A9CCXJP", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 6),
                                  Icon(Icons.close, size: 16, color: Colors.blue),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text("-\$$promoDiscount", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildCostRow("Total (Estimated Cost)", "\$$totalCost", isBold: true, isOrange: true),

                    const SizedBox(height: 24),

                    // Payment Options (Selectable Cards)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedCardIndex = 0),
                            child: _buildPaymentOption(Icons.credit_card, "Online Payment", selectedCardIndex == 0),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedCardIndex = 1),
                            child: _buildPaymentOption(Icons.account_balance_wallet, "Cash", selectedCardIndex == 1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedCardIndex == -1 ? Colors.grey : Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: selectedCardIndex == -1
                ? null
                : () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );

              final result = await ApiService.placeOrder(
                houseType: widget.selectedHouse,
                furnitures: widget.furnitures,
                packedBoxes: widget.packedBoxes,
                workers: widget.workers,
                electricians: widget.electricians,
                vehicle: widget.selectedVehicle,
                time: widget.selectedTime,
                date: widget.selectedDate.toIso8601String(),
                location: widget.location,
              );

              Navigator.pop(context); // close loading

              if (result["success"] == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShiftingConfirmationScreen(
                      scheduledDate: widget.selectedDate,
                      phoneNumber: "999 999 999",
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result["message"] ?? "Order Failed")),
                );
              }
            },
            child: Text("Confirm (\$$totalCost)", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
        ),
      ),
    );
  }

  // --- Helpers (unchanged)
  Widget _buildAddressRow(IconData icon, String text, {Color iconColor = Colors.black}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ],
    );
  }

  Widget _buildOrderItem(String emoji, String title, String subtitle, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, String value, {bool isBold = false, bool isOrange = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: 14, color: isOrange ? Colors.orange : Colors.black, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(IconData icon, String label, bool selected) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? Colors.orange : Colors.grey.shade300, width: 2),
          ),
          child: Row(
            children: [
              Icon(icon, color: selected ? Colors.black : Colors.grey, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(label, style: TextStyle(fontWeight: FontWeight.w500, color: selected ? Colors.black : Colors.grey), overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
        if (selected)
          const Positioned(
            right: 8,
            top: 8,
            child: Icon(Icons.check_circle, color: Colors.orange, size: 20),
          ),
      ],
    );
  }
}
