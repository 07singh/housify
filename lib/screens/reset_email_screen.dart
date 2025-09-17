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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content container
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 42),

                  // Heading
                  const Text(
                    'Reset email sent',
                    style: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'We have sent all required \ninstructions details to your \nmail.',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  // Spacer to push content to top
                  const Spacer(),
                ],
              ),
            ),

            // Fixed bottom button
            Positioned(
              bottom: 40,
              left: 35,
              right: 35,
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
                  height: 61,
                  decoration: BoxDecoration(
                    color: _isPressed ? const Color(0xFFF87202) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFDBD0D0)),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Go to login page',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF060606),
                          ),
                        ),
                        SizedBox(width: 30),
                        Icon(Icons.arrow_forward, color: Color(0xFF060606)),
                      ],
                    ),
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
