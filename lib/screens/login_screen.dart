import 'package:flutter/material.dart';

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
              const SizedBox(height: 60), // top spacing

              // ✅ Heading Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Let\'s Sign You In',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10), // proper gapping
                    Text(
                      'Welcome back,\n you\'ve been missed!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ✅ Form area scrollable
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                                return 'Enter valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Password
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter password';
                              }
                              if (val.length < 6) {
                                return 'Password too short';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Remember Me + Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (val) {
                                      setState(() => _rememberMe = val ?? false);
                                    },
                                  ),
                                  const Text('Remember Me'),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/forget_password');
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

                          // Login Button
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (route) => false);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF7300),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text('OR', style: TextStyle(color: Colors.grey)),

                          const SizedBox(height: 20),

                          // Google Button
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/goggle_logo.png',
                              width: 18,
                              height: 18,
                            ),
                            label: const Text('Continue with Google'),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              minimumSize: const Size(double.infinity, 50),
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
