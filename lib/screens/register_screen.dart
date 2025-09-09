import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _selectedState;
  bool _agree = false;

  final List<String> _states = ['State 1', 'State 2', 'State 3'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 🔹 Responsive screen size

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: size.width,   // 🔹 Full responsive width
          height: size.height, // 🔹 Full responsive height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            // ❌ Grey border removed
          ),
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context), // ← Back
                    ),
                    const Spacer(), // Push title to center
                    const Text(
                      'Register',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(), // Equal space on right for center alignment
                    const SizedBox(width: 48), // Optional, to balance arrow size
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Centered Getting Started section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(height: 20),
                            Text(
                              'Getting Started',
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Seems you are new here, \nLets set up your profile.',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Name
                        _buildInputField(
                          label: 'Full Name',
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Enter name';
                            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(val)) {
                              return 'Name can only contain letters';
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                        ),

                        // Email
                        _buildInputField(
                          label: 'Email Address',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Enter email';
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                        ),

                        // Address
                        _buildInputField(
                          label: 'Current Address',
                          controller: _addressController,
                          validator: (val) => val == null || val.isEmpty ? 'Enter address' : null,
                        ),

                        // Zip & State
                        Row(
                          children: [
                            Expanded(
                              child: _buildInputField(
                                label: 'Zip Code',
                                controller: _zipController,
                                keyboardType: TextInputType.number,
                                validator: (val) => val == null || val.isEmpty ? 'Enter Zip' : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  hintText: 'State',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction, // ✅ Added
                                value: _selectedState,
                                items: _states
                                    .map((state) => DropdownMenuItem(
                                  value: state,
                                  child: Text(state),
                                ))
                                    .toList(),
                                onChanged: (val) => setState(() => _selectedState = val),
                                validator: (val) => val == null || val.isEmpty ? 'Select state' : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Password
                        _buildInputField(
                          label: 'Password',
                          controller: _passwordController,
                          isPassword: true,
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Enter password';
                            if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$').hasMatch(val)) {
                              return 'Use uppercase, lowercase & number';
                            }
                            return null;
                          },
                        ),

                        // Confirm Password
                        _buildInputField(
                          label: 'Confirm Password',
                          controller: _confirmPasswordController,
                          isPassword: true,
                          validator: (val) {
                            if (val != _passwordController.text) return 'Passwords do not match';
                            return null;
                          },
                        ),

                        // Checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _agree,
                              onChanged: (val) {
                                setState(() => _agree = val ?? false);
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  text: 'By creating an account, you agree to our ',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: 'Terms and Conditions',
                                      style: TextStyle(color: Color(0xFFFF7300)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Submit
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true && _agree) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Account Created Successfully")),
                              );

                              // ✅ Navigate to login screen
                              Navigator.pushNamed(context, '/login');
                            } else if (!_agree) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Please agree to terms")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF87202),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Already have account
                        // Already have account
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login'); // Navigate to login screen
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(color: Color(0xFFFF7300), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    String? Function(String?)? validator,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction, // ✅ Added here
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorStyle: const TextStyle(color: Colors.red), // Optional
        ),
      ),
    );
  }
}
