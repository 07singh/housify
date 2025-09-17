import 'package:flutter/material.dart';
import 'shifthing_confrimation_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String selectedHouse;
  final Map<String, int> furnitures;
  final int packedBoxes;
  final int workers;
  final int electricians;
  final DateTime selectedDate;
  final String selectedTime;
  final String selectedVehicle;

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
  });

  @override
  Widget build(BuildContext context) {
    int totalFurniture = furnitures.values.fold(0, (a, b) => a + b);

    // ✅ Cost Calculation (Dynamic)
    double houseCost = 22; // base
    double furnitureCost = 30 + (packedBoxes > 0 ? 5 : 0);
    double workerCost = 15 + ((workers + electricians) > 1 ? 5 : 0);
    double vehicleCost = 20;
    double serviceCharge = 2;
    double promoDiscount = 20;

    double totalCost =
        houseCost + furnitureCost + workerCost + vehicleCost + serviceCharge - promoDiscount;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ AppBar
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
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
            ),

            // ✅ Main White Container
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
                    // --- MAP + ADDRESSES ---
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // Map Placeholder
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text("847m",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildAddressRow(
                              Icons.circle, "Pickup: $selectedHouse"),
                          const SizedBox(height: 8),
                          _buildAddressRow(Icons.location_on,
                              "Drop: Destination Address (Dynamic)",
                              iconColor: Colors.green),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --- ORDER DETAILS HEADER ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Order Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Icon(Icons.edit, size: 18),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // --- ORDER ITEMS (Dynamic) ---
                    _buildOrderItem(
                        "🏠",
                        "$selectedHouse",
                        "+\$5 for baby room",
                        "\$$houseCost"),
                    _buildOrderItem(
                        "🛋️",
                        "$totalFurniture Furniture, $packedBoxes Boxes",
                        "+\$5 for additional box",
                        "\$$furnitureCost"),
                    _buildOrderItem(
                        "👷",
                        "$workers Worker, $electricians Electrician",
                        "+\$5 for additional person",
                        "\$$workerCost"),

                    const Divider(height: 32),

                    // --- COST DETAILS ---
                    _buildCostRow("Vehicle ($selectedVehicle)", "\$$vehicleCost"),
                    _buildCostRow("Service Charge", "\$$serviceCharge"),

                    // Promo Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: const [
                                  Text("A9CCXJP",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 6),
                                  Icon(Icons.close, size: 16, color: Colors.blue),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text("-\$$promoDiscount",
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold)),
                      ],
                    ),

                    const SizedBox(height: 12),
                    _buildCostRow("Total (Estimated Cost)", "\$$totalCost",
                        isBold: true, isOrange: true),

                    const SizedBox(height: 24),

                    // --- PAYMENT OPTIONS ---
                    Row(
                      children: [
                        Expanded(
                          child: _buildPaymentOption(
                              Icons.credit_card, "Online Payment", true),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildPaymentOption(
                              Icons.account_balance_wallet, "Cash", false),
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

      // ✅ Confirm Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide.none,
              ),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShiftingConfirmationScreen(
                    scheduledDate: selectedDate,
                    phoneNumber: "999 999 999",
                  ),
                ),
              );
            },
            child: Text(
              "Confirm (\$$totalCost)",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helpers ---
  Widget _buildAddressRow(IconData icon, String text,
      {Color iconColor = Colors.black}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
      ],
    );
  }

  Widget _buildOrderItem(
      String emoji, String title, String subtitle, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(price,
              style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, String value,
      {bool isBold = false, bool isOrange = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              )),
          Text(value,
              style: TextStyle(
                fontSize: 14,
                color: isOrange ? Colors.orange : Colors.black,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              )),
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
            border: Border.all(
                color: selected ? Colors.orange : Colors.grey.shade300,
                width: 2),
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: selected ? Colors.black : Colors.grey, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.black : Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
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
