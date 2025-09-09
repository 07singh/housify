import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController =
  TextEditingController(text: 'uiuxseju@email.com');
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  void _checkValid() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 🔹 Responsive

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: size.width, // 🔹 Full width
          height: size.height, // 🔹 Full height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30), // 🔹 Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20), // 🔹 Same padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 🔹 Left alignment
              children: [
                const SizedBox(height: 50),

                // Left-aligned Heading
                const Text(
                  'Forget Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 30),

                // Form Content
                Form(
                  key: _formKey,
                  onChanged: _checkValid,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter your email address \nto reset password.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),

                      // Email Input
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Reset Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isValid
                              ? () {
                            Navigator.pushNamed(context, '/reset_email');
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF7300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Reset Password',
                            style:
                            TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
