import 'package:flutter/material.dart';
import 'cleaning_order_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  final String location;
  final int bedrooms;
  final int kitchens;
  final int persons;
  final DateTime selectedDate;
  final String selectedTimePeriod;
  final String selectedTime;
  final bool includeInstruments;

  const ConfirmationScreen({
    Key? key,
    required this.location,
    required this.bedrooms,
    required this.kitchens,
    required this.persons,
    required this.selectedDate,
    required this.selectedTimePeriod,
    required this.selectedTime,
    required this.includeInstruments,
  }) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int cleaners = 2;
  int workingHours = 2;
  bool hasBabyRoom = true;
  bool hasAdditionalCleaner = true;
  String promoCode = 'A9CCXJP';
  bool isPromoApplied = true;

  double getBaseCost() => (widget.bedrooms + widget.kitchens) * 10.0;
  double getCleanerCost() => cleaners * 5.0;
  double getWorkingHourCost() => workingHours * 5.0;
  double getPromoDiscount() => isPromoApplied ? 10.0 : 0.0;
  double getTotalCost() =>
      getBaseCost() + getCleanerCost() + getWorkingHourCost() - getPromoDiscount();

  void _navigateToOrderPlaced() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderPlacedScreen(
          location: widget.location,
          totalCost: getTotalCost(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Custom AppBar (like CleaningServiceApp)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 24),
                  ),
                  const Text(
                    'Confirmation',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Icon(Icons.notifications,
                      color: Colors.white, size: 24),
                ],
              ),
            ),

            // ✅ White rounded container content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location Card
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Icon(Icons.location_pin,
                                    color: Colors.green, size: 40.0),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on,
                                  color: Colors.green),
                              title: Text(widget.location),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      const Text(
                        'Order Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      // Bedrooms & Kitchens
                      Card(
                        child: ListTile(
                          leading: Image.asset('assets/home.png',
                              width: width * 0.1,
                              height: width * 0.1,
                              fit: BoxFit.contain),
                          title: Text(
                            '${widget.bedrooms} Bedrooms, ${widget.kitchens} Kitchen',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: Text(
                            '\$${getBaseCost()}/hr',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: hasBabyRoom
                              ? const Text('+ \$5 for baby room')
                              : null,
                        ),
                      ),

                      // Cleaner
                      Card(
                        child: ListTile(
                          leading: Image.asset('assets/cleaner.png',
                              width: width * 0.1,
                              height: width * 0.1,
                              fit: BoxFit.contain),
                          title: Text(
                            '$cleaners Cleaner${cleaners > 1 ? "s" : ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: Text(
                            '\$${getCleanerCost()}/hr',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: hasAdditionalCleaner
                              ? const Text('+ \$5 for additional cleaner')
                              : null,
                        ),
                      ),

                      // Working Hours
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.access_time,
                              color: Colors.green),
                          title: Text('Working Hours ($workingHours hrs)'),
                          trailing: Text(
                            '\$${getWorkingHourCost()}',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // Service Charge
                      const Card(
                        child: ListTile(
                          leading: Icon(Icons.miscellaneous_services,
                              color: Colors.green),
                          title: Text('Service Charge'),
                          trailing: Text(
                            '\$0',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // Promo Code
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.local_offer,
                              color: Colors.green),
                          title: const Text('Promo Code'),
                          trailing:
                          Text(isPromoApplied ? '-\$10.0' : ''),
                          subtitle: TextFormField(
                            initialValue: promoCode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: isPromoApplied
                                  ? const Icon(Icons.check,
                                  color: Colors.green)
                                  : null,
                            ),
                            readOnly: true,
                          ),
                        ),
                      ),

                      // Total Cost
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.calculate,
                              color: Colors.green),
                          title: const Text(
                            'Total (estimated cost)',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          trailing: Text(
                            '\$${getTotalCost()}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Payment Options
                      const Text(
                        'Payment Options',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: ListTile(
                                leading: const Icon(Icons.credit_card,
                                    color: Colors.green),
                                title: const Text('Online Payment'),
                                trailing: const Icon(Icons.check,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Card(
                              child: ListTile(
                                leading: const Icon(Icons.money,
                                    color: Colors.green),
                                title: const Text('Cash'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // Confirm Button
                      ElevatedButton(
                        onPressed: _navigateToOrderPlaced,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize:
                          const Size(double.infinity, 50.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          'Confirm (\$${getTotalCost()})',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
