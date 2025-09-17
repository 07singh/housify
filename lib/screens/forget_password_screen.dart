import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart'; // 👈 Import your API service

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  bool _isLoading = false; // 👈 Loading state

  // Check form validity
  void _checkValid() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  // Handle Reset Password button press
  void _handleResetPassword() async {
    if (!_isValid) return;

    setState(() => _isLoading = true);

    final res = await ApiService.forgetPassword(email: emailController.text.trim());

    setState(() => _isLoading = false);

    if (res['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Reset link sent to your email!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, '/reset_email'); // Navigate after success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res['message'] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150),

                // Heading
                const Text(
                  'Forget Password',
                  style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 25),

                // Form
                Form(
                  key: _formKey,
                  onChanged: _checkValid,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter your email address \nto reset password.',
                        style: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                      const SizedBox(height: 35),

                      // Email Field
                      SizedBox(
                        height: 63,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@._\-+]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFFFF7300),
                                width: 2,
                              ),
                            ),
                            errorStyle: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                          validator: (val) {
                            val = val?.trim();
                            if (val == null || val.isEmpty) {
                              return 'Enter email';
                            }
                            if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(val)) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Reset Button
                      SizedBox(
                        width: double.infinity,
                        height: 62,
                        child: ElevatedButton(
                          onPressed: _isValid && !_isLoading
                              ? _handleResetPassword
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isValid && !_isLoading
                                ? const Color(0xFFFF7300) // Orange
                                : Colors.grey, // Grey when invalid
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
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
