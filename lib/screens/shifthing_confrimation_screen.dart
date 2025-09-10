import 'package:flutter/material.dart';

class ShiftingConfirmationScreen extends StatelessWidget {
  final DateTime scheduledDate;
  final String phoneNumber;

  const ShiftingConfirmationScreen({
    super.key,
    required this.scheduledDate,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Order Confirmation",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.notifications_none, color: Colors.white),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                ),
              )
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            // 🎉 Success Icon
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEFFFEF),
              ),
              child: const Center(
                child: Icon(Icons.celebration,
                    size: 80, color: Colors.greenAccent),
              ),
            ),
            const SizedBox(height: 32),

            // ✅ Title
            const Text(
              "Order Placed",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // 📝 Subtitle
            Text(
              "Your order has been Successfully placed,\n"
                  "Our logistic team will contact with you soon.\n"
                  "For any help, call ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            // 📞 Phone Number
            Text(
              "(+1) $phoneNumber",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // 📅 Schedule
            const Text(
              "SCHEDULE",
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 1,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatDateTime(scheduledDate),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            // 📌 Add to Calendar Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade100,
                foregroundColor: Colors.green,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                // TODO: Implement calendar logic
              },
              child: const Text(
                "ADD TO CALENDER",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),

            const Spacer(),

            // 🏠 Homepage Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  "Go to Homepage",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Format Date & Time
  static String _formatDateTime(DateTime date) {
    return "${_getWeekday(date.weekday)}, "
        "${_getMonth(date.month)} ${date.day}, ${date.year} @ "
        "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  static String _getWeekday(int weekday) {
    const days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    return days[weekday - 1];
  }

  static String _getMonth(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }
}
