import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../services/api_service.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({super.key, required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  int _secondsRemaining = 50;
  Timer? _timer;
  bool isLoading = false;
  bool otpVerified = false; // ✅ OTP verify flag

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _otpControllers) c.dispose();
    for (var n in _focusNodes) n.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final otp = _otpControllers.map((c) => c.text).join();
    setState(() => isLoading = true);

    try {
      final res = await ApiService.verifyOtp(widget.phoneNumber, otp);

      // ✅ Backend से हमेशा { success: true/false, message: "..." } आना चाहिए
      final bool success = res['success'] == true;
      final String message = res['message'] ?? "OTP verification failed";

      if (success) {
        if (mounted) {
          setState(() => otpVerified = true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      } else {
        if (mounted) {
          setState(() => otpVerified = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => otpVerified = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 45),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const Spacer(),
                  const Text(
                    'OTP Verification',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const SizedBox(width: 45),
                ],
              ),
              const SizedBox(height: 45),
              Column(
                children: [
                  const Text(
                    'An authentication code has been sent to',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.phoneNumber,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFF7300),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),

              // OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: SizedBox(
                      width: 54,
                      height: 65,
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          counterText: '',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFFF7300)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Verify OTP button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Verify OTP", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Submit button → OTP verified होने के बाद ही enable
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (otpVerified && !isLoading)
                        ? () {
                      Navigator.pushReplacementNamed(context, '/register');
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: otpVerified ? const Color(0xFFFF7300) : Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Timer
              Text.rich(
                TextSpan(
                  text: 'Code Sent. ',
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: _secondsRemaining > 0
                          ? 'Resend Code in 00:${_secondsRemaining.toString().padLeft(2, '0')}'
                          : 'You can resend the code now',
                      style: const TextStyle(color: Color(0xFFA19E9E)),
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
