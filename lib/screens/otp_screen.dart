import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({super.key, required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  int _secondsRemaining = 30;
  Timer? _timer;

  bool _isOtpFilled() =>
      _otpControllers.every((controller) => controller.text.isNotEmpty);

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (index) => TextEditingController());
    _focusNodes = List.generate(4, (index) => FocusNode());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  /// ✅ Final Format: (+91) 9876543210
  String _formatPhoneWithCountryCode(String fullNumber) {
    // remove all spaces
    fullNumber = fullNumber.replaceAll(" ", "");

    // find country code (e.g. +91)
    final RegExp regExp = RegExp(r"^\+?\d+");
    final match = regExp.firstMatch(fullNumber);

    if (match != null) {
      final countryCode = match.group(0)!; // +91
      final phoneNumber = fullNumber.substring(match.end); // 9876543210
      return "($countryCode) $phoneNumber"; // => (+91) 9876543210
    }
    return fullNumber;
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
          child: Column(
            children: [
              const SizedBox(height: 40),

              // 🔹 Title with Back Arrow
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, size: 24),
                    ),
                    const Spacer(),
                    const Text(
                      'OTP Verification',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const SizedBox(width: 24),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Instructions
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'An authentication code has been sent to\n',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                  children: [
                    TextSpan(
                      text: _formatPhoneWithCountryCode(widget.phoneNumber),
                      style: const TextStyle(
                        color: Color(0xFFFF7300),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFFF7300)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 1]);
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index - 1]);
                          }
                          setState(() {});
                        },
                        onSubmitted: (_) {
                          if (!_isOtpFilled()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text("Please fill all OTP boxes")),
                            );
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // 🔹 Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_isOtpFilled()) {
                        Navigator.pushNamed(context, '/register');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                              Text("Please enter the complete OTP")),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Resend Code with Timer
              Text.rich(
                TextSpan(
                  text: 'Code Sent. ',
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: _secondsRemaining > 0
                          ? 'Resend Code in 00:${_secondsRemaining.toString().padLeft(2, '0')}'
                          : 'You can resend the code now',
                      style:
                      const TextStyle(color: Color(0xFFFF7300)),
                    ),
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
