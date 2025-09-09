import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'notification_screen.dart';


void main() {
  runApp(const VehicleServiceApp());
}

class VehicleServiceApp extends StatelessWidget {
  const VehicleServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VehicleServiceScreen(),
    );
  }
}

// ---------------- VEHICLE SERVICE SCREEN ----------------
class VehicleServiceScreen extends StatelessWidget {
  const VehicleServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2526),

      body: Column(
        children: [
          // ✅ AppBar like HistoryScreen
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Vehicle Service',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications,
                        color: Colors.white, size: 26),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // ✅ Body white rounded container
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Header
                    Row(
                      children: const [
                        Icon(Icons.local_shipping, color: Color(0xFFF4A261)),
                        SizedBox(width: 8.0),
                        Text(
                          'Vehicle',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      "Choose vehicle type as your need, we'll calculate the cost for you.",
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    // ✅ Offer Cards (wide + scrollable)
                    SizedBox(
                      height: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _offerCard(
                            bgColor: const Color(0xFFF4A261),
                            img: 'assets/truck.png',
                            text: "Shifty\n20% Off\nOn Vehicle Service",
                            width: 260, // ✅ width बढ़ाई
                          ),
                          const SizedBox(width: 16),
                          _offerCard(
                            bgColor: const Color(0xFF2E7D32),
                            img: 'assets/truck.png',
                            text: "Shi\n10% Off",
                            width: 260, // ✅ width बढ़ाई
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ✅ Vehicle Options Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.8,
                      children: const [
                        VehicleOption(
                          imageUrl: 'assets/truck.png',
                          title: 'Mini Truck',
                        ),
                        VehicleOption(
                          imageUrl: 'assets/truck.png',
                          title: 'Pickup',
                        ),
                        VehicleOption(
                          imageUrl: 'assets/truck.png',
                          title: 'Large Truck',
                        ),
                        VehicleOption(
                          imageUrl: 'assets/truck.png',
                          title: 'Custom Order',
                        ),
                      ],
                    ),

                    SizedBox(height: screenH * 0.03),

                    // ✅ Proceed Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ConfirmLocationScreen(),
                            ),
                          );
                        },
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Offer Card Widget
  Widget _offerCard({
    required Color bgColor,
    required String img,
    required String text,
    double width = 180,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(img, height: 50),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// ✅ Vehicle Option Card
class VehicleOption extends StatelessWidget {
  final String imageUrl;
  final String title;

  const VehicleOption({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, height: 80),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}






// ---------------- CONFIRM LOCATION SCREEN ----------------


class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  DateTime currentDate = DateTime.now();
  int selectedDay = DateTime.now().day;
  String selectedTime = "07:00 AM";
  int workers = 0;
  bool isLoadingPoint = true;

  final List<String> times = ["07:00 AM", "11:00 AM", "12:00 AM"];

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void _changeMonth(int change) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + change, 1);
      selectedDay = 1; // reset day when month changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int daysInMonth = getDaysInMonth(currentDate.year, currentDate.month);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Confirm Location",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 90), // leave space for button
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Location",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(height: 6),
                    const Text(
                      "Please choose your destination location accurately. For any info call (+1) 999 999 999",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 18),

                    // Loading / Unloading Point
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.circle,
                                color: Colors.black),
                            title: const Text("Loading Point",
                                style: TextStyle(fontSize: 16)),
                            onTap: () {
                              setState(() => isLoadingPoint = true);
                            },
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.location_on,
                                color: Colors.green),
                            title: const Text("Unloading Point",
                                style: TextStyle(fontSize: 16)),
                            onTap: () {
                              setState(() => isLoadingPoint = false);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Calendar Header with Month Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => _changeMonth(-1),
                          icon: const Icon(Icons.arrow_back_ios, size: 18),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            DateFormat("MMMM, yyyy").format(currentDate),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _changeMonth(1),
                          icon: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Calendar Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: daysInMonth,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7, childAspectRatio: 1.2),
                      itemBuilder: (context, index) {
                        int day = index + 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedDay = day);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: selectedDay == day
                                  ? Colors.orange
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "$day",
                                style: TextStyle(
                                    color: selectedDay == day
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Pick time",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.grey)),
                    const SizedBox(height: 10),

                    // Time Slots
                    Row(
                      children: times.map((time) {
                        bool selected = time == selectedTime;
                        return GestureDetector(
                          onTap: () => setState(() => selectedTime = time),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: selected ? Colors.orange : Colors.white,
                              border: Border.all(
                                color: selected
                                    ? Colors.orange
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : Colors.grey.shade700,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 25),

                    // Workers Section
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Workers",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text(
                                "Regular cost is \$5/hr. Total cost will be calculated later",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (workers > 0) setState(() => workers--);
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text("$workers",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () {
                                setState(() => workers++);
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // ✅ Proceed Button (Fixed at bottom, full-width)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadingPointScreen()),
                  );
                },
                child: const Text(
                  "Proceed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingPointScreen extends StatelessWidget {
  const LoadingPointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Loading Point",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // ✅ Same style as confirmation
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Stack(
          children: [
            // --- Map background ---
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey.shade200,
              child: Center(
                child: Icon(
                  Icons.map,
                  size: 200,
                  color: Colors.grey.shade400,
                ),
              ),
            ),

            // --- Orange pin ---
            const Positioned(
              left: 160,
              top: 280,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.location_pin,
                    size: 42, color: Colors.orange),
              ),
            ),

            // --- GPS button ---
            Positioned(
              right: 20,
              bottom: 280,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.gps_fixed, color: Colors.black87),
              ),
            ),

            // --- Bottom white panel ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: size.height * 0.35,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Selected Address ---
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.green),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "3329 Joyce Street",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 30),

                    // --- Quick Locations ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _QuickLocation(
                          icon: Icons.home,
                          label: "Home",
                          color: Colors.orange,
                        ),
                        _QuickLocation(
                          icon: Icons.work,
                          label: "Work",
                          color: Colors.black87,
                        ),
                        _QuickLocation(
                          icon: Icons.add_location_alt,
                          label: "Add New",
                          color: Colors.black87,
                        ),
                      ],
                    ),

                    const Spacer(),

                    // --- Confirm Button ---
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const OrderDetailsScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _QuickLocation extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickLocation({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFF5F5F5),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14)),
      ],
    );
  }
}



class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            // --- Content scrollable ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Map & Locations ---
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(Icons.map,
                                  size: 80, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const ListTile(
                            leading: Icon(Icons.circle, color: Colors.black),
                            title: Text("2045 Lodgeville Street, Eagan"),
                          ),
                          const ListTile(
                            leading: Icon(Icons.star, color: Colors.green),
                            title: Text("3329 Joyce Street, PA, USA"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Order Details Title ---
                    const Text(
                      "Order Details",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    // --- Vehicle Card ---
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.local_shipping,
                                color: Colors.purple, size: 28),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              "Mini Truck\n~ 1.8 Ton, 9 Feet",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const Text(
                            "\$22",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // --- Charges Breakdown ---
                    _priceRow("Worker/Labours (2)", "\$20"),
                    const Divider(),
                    _priceRow("Service Charge", "\$2"),
                    const Divider(),
                    _priceRow("Promo Code", "-\$20"),
                    const Divider(),
                    _priceRow("Total (Estimated Cost)", "\$56", isBold: true),
                    const SizedBox(height: 25),

                    // --- Payment Options ---
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                              Border.all(color: Colors.orange, width: 2),
                            ),
                            child: Column(
                              children: const [
                                Icon(Icons.credit_card, color: Colors.black),
                                SizedBox(height: 5),
                                Text("Online Payment"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                              Border.all(color: Colors.grey, width: 2),
                            ),
                            child: Column(
                              children: const [
                                Icon(Icons.account_balance_wallet,
                                    color: Colors.grey),
                                SizedBox(height: 5),
                                Text("Cash",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),

            // --- Fixed Confirm Button ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const OrderConfirmationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Confirm (\$56)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _priceRow extends StatelessWidget {
  final String title;
  final String price;
  final bool isBold;

  const _priceRow(this.title, this.price, {this.isBold = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            )),
        Text(
          price,
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // Custom AppBar
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Confirmation",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          )
        ],
      ),

      // Main Body
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // ✅ Success Celebration Image
              Image.asset(
                "assets/img.png",
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 25),

              // ✅ Title
              const Text(
                "Order Placed",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // ✅ Subtext
              const Text(
                "Your order has been successfully placed,\nFor any info call",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 5),

              // ✅ Phone Number
              const Text(
                "(+1) 999 999 999",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Driver Section
              const Text(
                "YOUR DRIVER",
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 1.5,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),

              const Text(
                "Working Hour : 7PM - 9AM",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Driver Card
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      blurRadius: 8,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Driver photo
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/img_1.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Name + Rating
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Gabriel Payne",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: List.generate(
                                5,
                                    (index) => Icon(
                                  Icons.star,
                                  color: index < 4
                                      ? Colors.orange
                                      : Colors.grey.shade300,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ✅ Action Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _actionIcon(Icons.phone, Colors.orange, () {
                          // Phone action
                        }),
                        _actionIcon(Icons.chat, Colors.blue, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChatScreen(),
                            ),
                          );
                        }),
                        _actionIcon(Icons.reviews, Colors.purple, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReviewScreen(),
                            ),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ✅ Go to Homepage Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Back to homepage
                  },
                  child: const Text(
                    "Go to Homepage",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Action Icon widget with navigation
  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}


class Message {
  final String text;
  final String time;
  final bool isSender;

  Message({required this.text, required this.time, required this.isSender});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // ✅ Initial dummy messages
  List<Message> messages = [
    Message(
      text: "Hey, You there? I need to\ngive you some info.",
      time: "08:15 AM",
      isSender: true,
    ),
    Message(
      text: "Hey, Please tell me details.",
      time: "08:20 AM",
      isSender: false,
    ),
    Message(
      text:
      "Please come 30min early\nif you can, as I need some\nthings to load, and I need your help",
      time: "08:22 AM",
      isSender: true,
    ),
  ];

  // ✅ Add new message
  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messages.add(
        Message(
          text: _controller.text.trim(),
          time: TimeOfDay.now().format(context),
          isSender: true,
        ),
      );
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            // ✅ Driver Info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      "assets/driver.png",
                      width:23,
                      height: 23,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Gabriel Payne",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.call, color: Colors.orange),
                  )
                ],
              ),
            ),

            const Divider(height: 1),

            // ✅ Chat List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return Align(
                    alignment: msg.isSender
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: msg.isSender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          decoration: BoxDecoration(
                            color: msg.isSender
                                ? Colors.orange
                                : const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color: msg.isSender
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        Text(
                          msg.time,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ✅ Input Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image, color: Colors.black87),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.black87),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Aa",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFFF7F7F7),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: const Icon(Icons.send, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int selectedEmoji = -1;
  final TextEditingController _reviewController = TextEditingController();

  final List<String> emojis = ["😭", "🙁", "😐", "😄", "😍"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Review",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "How was your Experience?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Your order is Successfully Done, Do you mind\ngiving a small feedback about your experience?",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              // ✅ Emoji Row
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(emojis.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedEmoji = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: selectedEmoji == index
                              ? [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            )
                          ]
                              : [],
                        ),
                        child: Text(
                          emojis[index],
                          style: TextStyle(
                            fontSize: 36,
                            shadows: selectedEmoji == index
                                ? [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.orange.withOpacity(0.7),
                              )
                            ]
                                : [],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Review Input
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "WRITE A REVIEW",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Type here...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFF7F7F7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Buttons Row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedEmoji == -1 &&
                            _reviewController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please provide feedback")),
                          );
                          return;
                        }
                        // Handle submit
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Feedback submitted successfully")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
