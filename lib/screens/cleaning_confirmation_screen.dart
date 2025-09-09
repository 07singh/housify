import 'package:flutter/material.dart';
import'cleaning_order_screen.dart';



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
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
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
  double getTotalCost() => getBaseCost() + getCleanerCost() + getWorkingHourCost() - getPromoDiscount();

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Confirmation'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Card
              Card(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Icon(Icons.location_pin, color: Colors.green, size: 40.0),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.green),
                      title: Text(widget.location),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Order Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              // Bedrooms & Kitchens
              Card(
                child: ListTile(
                  leading: Image.asset('assets/home.png', width: 40, height: 40),
                  title: Text('${widget.bedrooms} Bedrooms, ${widget.kitchens} Kitchen'),
                  trailing: Text('\$${getBaseCost()}/hr', style: const TextStyle(color: Colors.green)),
                  subtitle: hasBabyRoom ? const Text('+ 5 for baby room') : null,
                ),
              ),

              // Cleaner
              Card(
                child: ListTile(
                  leading: Image.asset('assets/cleaner.png', width: 40, height: 40),
                  title: Text('$cleaners Cleaner'),
                  trailing: Text('\$${getCleanerCost()}/hr', style: const TextStyle(color: Colors.green)),
                  subtitle: hasAdditionalCleaner ? const Text('+ 5 for additional') : null,
                ),
              ),

              // Working Hours
              Card(
                child: ListTile(
                  title: Text('Working Hour ($workingHours hours)'),
                  trailing: Text('\$${getWorkingHourCost()}', style: const TextStyle(color: Colors.green)),
                ),
              ),

              // Service Charge
              Card(
                child: ListTile(
                  title: const Text('Service Charge'),
                  trailing: const Text('\$0', style: TextStyle(color: Colors.green)),
                ),
              ),

              // Promo Code
              Card(
                child: ListTile(
                  title: const Text('Promo Code'),
                  trailing: Text(isPromoApplied ? '-\$${getPromoDiscount()}' : ''),
                  subtitle: TextFormField(
                    initialValue: promoCode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: isPromoApplied ? const Icon(Icons.check, color: Colors.green) : null,
                    ),
                    readOnly: true,
                  ),
                ),
              ),

              // Total Cost
              Card(
                child: ListTile(
                  title: const Text('Total (estimated Cost)'),
                  trailing: Text('\$${getTotalCost()}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                ),
              ),

              const SizedBox(height: 16.0),

              // Payment Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.credit_card),
                      title: const Text('Online Payment'),
                      trailing: const Icon(Icons.check, color: Colors.green),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.money),
                      title: const Text('Cash'),
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
                  minimumSize: const Size(double.infinity, 50.0),
                ),
                child: Text('Confirm (\$${getTotalCost()})'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}