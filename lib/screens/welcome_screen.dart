import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import '../services/api_service.dart';
import 'otp_screen.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedCountryCode = '+91';
  String selectedCountryFlag = '🇮🇳';
  String selectedCountryShortCode = 'IND';
  String phoneNumber = '';
  final TextEditingController _phoneController = TextEditingController();

  int maxPhoneLength = 10;
  String? phoneError;
  bool isLoading = false;

  // ✅ API call using ApiService
  Future<void> _sendOtp(String phone) async {
    setState(() => isLoading = true);
    try {
      final res = await ApiService.sendOtp(phone);

      if (res['success'] == true) {
        // OTP screen pe navigate
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OTPScreen(phoneNumber: phone)),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['message'] ?? "OTP sent successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['message'] ?? "Failed to send OTP")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  int getMaxLengthForCountry(Country country) {
    final digitsOnly = country.example.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.isNotEmpty ? digitsOnly.length : 10;
  }

  void _selectCountry(Country country) {
    setState(() {
      selectedCountryCode = '+${country.phoneCode}';
      selectedCountryFlag = country.flagEmoji;
      selectedCountryShortCode = country.countryCode.toUpperCase();
      maxPhoneLength = getMaxLengthForCountry(country);
      _phoneController.clear();
      phoneNumber = '';
      phoneError = null;
    });
  }

  String? validatePhone(String value) {
    if (value.isEmpty) return "Phone number is required";
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "Only digits are allowed";
    if (value.length < 7 || value.length > 15) return "Enter valid phone (7-15 digits)";
    if (RegExp(r'^0+$').hasMatch(value)) return "Invalid number (all zeros)";
    if (RegExp(r'(\d)\1{3,}').hasMatch(value)) return "Invalid number (digit repeated)";
    return null;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: Container(
              width: size.width,
              height: size.height,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.09),
                    const Text('Welcome', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 14),
                    const Text('Enter your phone \nnumber to get started.', style: TextStyle(fontSize: 25, color: Colors.grey)),
                    SizedBox(height: size.height * 0.03),

                    // Phone input
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: phoneError != null ? Colors.red : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                showSearch: true,
                                onSelect: _selectCountry,
                              );
                            },
                            child: Container(
                              height: 55,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: Row(
                                children: [
                                  Text(selectedCountryFlag, style: const TextStyle(fontSize: 24)),
                                  const SizedBox(width: 8),
                                  Text('$selectedCountryShortCode ($selectedCountryCode)', style: const TextStyle(fontSize: 16)),
                                  const Spacer(),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 1, thickness: 2, color: Colors.grey.shade300),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                            child: TextField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone number',
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              maxLength: maxPhoneLength,
                              onChanged: (value) {
                                setState(() {
                                  phoneNumber = value;
                                  phoneError = validatePhone(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (phoneError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
                        child: Text(phoneError!, style: const TextStyle(color: Colors.red, fontSize: 13)),
                      ),

                    SizedBox(height: size.height * 0.04),

                    Center(
                      child: SizedBox(
                        width: size.width * 0.9,
                        height: 62,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            final error = validatePhone(phoneNumber);
                            if (error == null) {
                              final fullNumber = '$selectedCountryCode$phoneNumber';
                              _sendOtp(fullNumber);
                            } else {
                              setState(() => phoneError = error);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF7300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Continue', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
