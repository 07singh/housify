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
  final TextEditingController _phoneController = TextEditingController();

  int maxPhoneLength = 10; // Default India
  String? phoneError;

  int getMaxLengthForCountry(Country country) {
    final digitsOnly = country.example.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length;
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
    if (value.length < 7 || value.length > 15) {
      return "Enter a valid phone number (7-15 digits)";
    }
    if (RegExp(r'^0+$').hasMatch(value)) {
      return "Invalid phone number (all zeros not allowed)";
    }
    if (RegExp(r'(\d)\1{3,}').hasMatch(value)) {
      return "Invalid phone number (digit repeated too many times)";
    }
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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

                  // Country selector + phone input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: phoneError != null
                            ? Colors.red
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Country box
                        GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              showSearch: true,
                              countryListTheme: CountryListThemeData(
                                borderRadius: BorderRadius.circular(16),
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Search by country name or code',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              onSelect: _selectCountry,
                            );
                          },
                          child: Container(
                            height: 55,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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

                        // Grey line between
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.shade300,
                        ),

                        // Phone number input
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone number',
                              counterText: '',
                              errorText: phoneError,
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
                                phoneError = validatePhone(value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

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
                        final error = validatePhone(phoneNumber);
                        if (error == null) {
                          final fullNumber = '($selectedCountryCode)$phoneNumber';
                          Navigator.pushNamed(
                            context,
                            '/otp',
                            arguments: {'phoneNumber': fullNumber},
                          );
                        } else {
                          setState(() {
                            phoneError = error;
                          });
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
