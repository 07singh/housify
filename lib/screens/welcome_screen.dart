import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';

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
  bool showCountryDropdown = false;
  final TextEditingController _phoneController = TextEditingController();

  int maxPhoneLength = 10; // Default India

  // 🔹 Helper function: get max length from example number
  int getMaxLengthForCountry(Country country) {
    final digitsOnly = country.example.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length;
  }

  void _selectCountry(Country country) {
    setState(() {
      selectedCountryCode = '+${country.phoneCode}';
      selectedCountryFlag = country.flagEmoji;
      selectedCountryShortCode = country.countryCode.toUpperCase();

      // Dynamic max length
      maxPhoneLength = getMaxLengthForCountry(country);

      showCountryDropdown = false;
      _phoneController.clear();
      phoneNumber = '';
    });
  }

  Widget _buildCountryDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListView(
        children: CountryService().getAll().map((country) {
          return ListTile(
            leading: Text(country.flagEmoji),
            title: Text(country.name),
            trailing: Text('+${country.phoneCode}'),
            onTap: () => _selectCountry(country),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
        child: Center(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.05),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'Welcome',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'Enter your \nphone number to get started.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),

                  // Country selector and phone input
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showCountryDropdown = !showCountryDropdown;
                          });
                        },
                        child: Container(
                          height: 55,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300, // 👈 Visible line
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                selectedCountryFlag,
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$selectedCountryShortCode ($selectedCountryCode)',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      if (showCountryDropdown) _buildCountryDropdown(),

                      // Phone number input
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        child: TextField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone number',
                            counterText: '',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: const TextStyle(fontSize: 18),
                          maxLength: maxPhoneLength,
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.02),

                  // 🔹 Plain text only (not clickable anymore)
                  const Center(
                    child: Text(
                      'Privacy and Agreements',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.015),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final fullNumber = '$selectedCountryCode$phoneNumber';
                        if (phoneNumber.length == maxPhoneLength) {
                          Navigator.pushNamed(
                            context,
                            '/otp',
                            arguments: {'phoneNumber': fullNumber},
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please enter a valid $maxPhoneLength-digit phone number',
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
