import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ResetEmailScreen(),
  ));
}

class ResetEmailScreen extends StatefulWidget {
  const ResetEmailScreen({super.key});

  @override
  State<ResetEmailScreen> createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen> {
  bool _isPressed = false; // For button color change

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 🔹 Responsive screen

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // ✅ Left alignment
              children: [
                // 🔹 Heading
                const Text(
                  'Reset email sent',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // 🔹 Description (same left alignment)
                const Text(
                  'We have sent all required \ninstructions details to your \nmail.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const Spacer(),

                // 🔹 Button
                SizedBox(
                  width: double.infinity,
                  height: 61,
                  child: GestureDetector(
                    onTapDown: (_) {
                      setState(() => _isPressed = true);
                    },
                    onTapUp: (_) {
                      setState(() => _isPressed = false);
                      Navigator.pushNamed(context, '/set_new_password');
                    },
                    onTapCancel: () {
                      setState(() => _isPressed = false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isPressed ? const Color(0xFFF87202) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF87202)),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go for set new password',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF87202),
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, color: Color(0xFFF87202)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
