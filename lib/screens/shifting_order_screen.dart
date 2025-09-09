import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications_none, color: Colors.white),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main white container
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
                    // Map + addresses
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              const Positioned(
                                left: 40,
                                top: 40,
                                child: Icon(Icons.location_pin,
                                    size: 40, color: Colors.orange),
                              ),
                              const Positioned(
                                right: 40,
                                bottom: 40,
                                child: Icon(Icons.home,
                                    size: 40, color: Colors.blue),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                      )
                                    ],
                                  ),
                                  child: const Text(
                                    "847m",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.radio_button_checked,
                                      color: Colors.black),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "2045 Lodgeville Street, Eagan",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: const [
                                  Icon(Icons.location_on, color: Colors.green),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "3329 Joyce Stree, PA, USA",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Order details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Order Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Icon(Icons.edit, size: 18),
                      ],
                    ),
                    const SizedBox(height: 12),

                    _buildOrderItem("🏠", "3 Bedrooms, 1 Kitchen",
                        "+\$5 for baby room", "\$22"),
                    _buildOrderItem("🛋️", "8 Furniture, 6 Boxes",
                        "+\$5 for additional box", "\$30"),
                    _buildOrderItem("👷", "3 Worker, 1 Electrician",
                        "+\$5 for additional person", "\$15"),

                    const Divider(height: 32),

                    // Cost breakdown
                    _buildCostRow("Vehicle (Mini Truck)", "\$20"),
                    _buildCostRow("Service Charge", "\$2"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Promo Code"),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                "A9CCXJP",
                                style: TextStyle(color: Colors.blue),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.close, size: 14, color: Colors.blue),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildCostRow("Total (Estimated Cost)", "\$56",
                        isBold: true, isOrange: true),

                    const SizedBox(height: 24),

                    // Payment method (horizontal like PNG)
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

      // Confirm Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            onPressed: () {},
            child: const Text(
              "Confirm (\$56)",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(
      String emoji, String title, String subtitle, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), // ✅ matches PNG
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    )),
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
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.black : Colors.grey,
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
