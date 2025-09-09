import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SetNewPasswordScreen(),
    );
  }
}

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  void _checkValid() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 🔹 Responsive screen

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          width: size.width, // 🔹 Full width
          height: size.height, // 🔹 Full height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30), // 🔹 Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              onChanged: _checkValid,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 🔹 Left align
                children: [
                  const SizedBox(height: 60), // 🔹 Heading spacing

                  // Heading
                  const Text(
                    'Set New Password',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start, // 🔹 Left align
                  ),

                  const SizedBox(height: 10),

                  // Description
                  const Text(
                    'Create strong and secured password',
                    textAlign: TextAlign.start, // 🔹 Left align
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter password';
                      }
                      if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$')
                          .hasMatch(val)) {
                        return 'Use uppercase, lowercase & number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Confirm Password Field
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Confirm password';
                      }
                      if (val != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Save Password Button
                  SizedBox(
                    width: double.infinity,
                    height: 61,
                    child: ElevatedButton(
                      onPressed: _isValid
                          ? () {
                        // ✅ Only navigate when valid
                        Navigator.pushNamed(context, '/login');
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF87202),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40), // Bottom spacing
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
