import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isPasswordEntered = false; // ✅ Track password input

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      setState(() {
        _isPasswordEntered = passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ✅ Email validation
  String? _validateEmail(String? val) {
    val = val?.trim();
    if (val == null || val.isEmpty) {
      return 'Enter email';
    }
    if (!RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(val)) {
      return 'Invalid email';
    }
    return null;
  }

  // ✅ Password validation
  String? _validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter password';
    }
    if (!RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$')
        .hasMatch(val)) {
      return 'Invalid password (8+ chars, upper, lower, number, special)';
    }
    return null;
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
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 65),

              // ✅ Heading Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Let\'s Sign You In',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 70),
                    Text(
                      'Welcome back,\n you\'ve been missed!',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // ✅ Form area scrollable
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          // Email
                          SizedBox(
                            height: 70,
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFFF7300),
                                    width: 5,
                                  ),
                                ),
                                errorStyle: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Password
                          SizedBox(
                            height: 62,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: _validatePassword,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: 'Password',
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
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Remember Me + Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (val) {
                                      setState(() =>
                                      _rememberMe = val ?? false);
                                    },
                                  ),
                                  const Text('Remember Me'),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/forget_password');
                                },
                                child: const Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                    color: Color(0xFFFFA600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Login Button (grey -> orange after password entered)
                          SizedBox(
                            height: 62,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isPasswordEntered
                                  ? () {
                                if (_formKey.currentState?.validate() ==
                                    true) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/home',
                                          (route) => false);
                                }
                              }
                                  : null, // disabled when no password
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isPasswordEntered
                                    ? const Color(0xFFFF7300) // Orange when active
                                    : Colors.grey, // Grey when disabled
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text('OR',
                              style: TextStyle(color: Colors.grey)),

                          const SizedBox(height: 20),

                          // Google Button (62 height)
                          SizedBox(
                            height: 62,
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/goggle_logo.png',
                                width: 20,
                                height: 20,
                              ),
                              label: const Text('Continue with Google'),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Sign Up Text
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      color: Color(0xFFF87202),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
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
}
