import 'package:flutter/material.dart';

class ServiceIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const ServiceIcon({super.key, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
          child: Icon(icon, size: 30, color: color),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}