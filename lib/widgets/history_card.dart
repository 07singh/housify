import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String status;
  final String serviceName;
  final String date;
  final String location;
  final Color statusColor;

  const HistoryCard({
    super.key,
    required this.status,
    required this.serviceName,
    required this.date,
    required this.location,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withAlpha(25), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/sample_image.png', fit: BoxFit.cover), // Replace with map image
            ),
          ),
          Positioned(top: 10, left: 10, child: _buildStatusBadge()),
          const Positioned(top: 70, right: 20, child: Icon(Icons.location_on, color: Color(0xFFFFCC00), size: 40)),
          Positioned(
            left: 10,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(serviceName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(date, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.green, size: 16),
                    const SizedBox(width: 5),
                    Text(location, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(12)),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}