import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:house_service/screens/profile_screen.dart';
import 'package:house_service/screens/housify_home_screen.dart';
import 'change_password_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
  TextEditingController(text: "Michael Jackson");
  final TextEditingController emailController =
  TextEditingController(text: "uiuxseju@email.com");
  final TextEditingController phoneController =
  TextEditingController(text: "9999999999");
  final TextEditingController addressController =
  TextEditingController(text: "907 Valley Drive, Allentown");
  final TextEditingController zipController =
  TextEditingController(text: "18109");
  final TextEditingController passwordController =
  TextEditingController(text: "123456");

  String selectedState = "Pennsylvania";
  Country selectedCountry = Country(
    phoneCode: "1",
    countryCode: "US",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "United States",
    example: "2015550123",
    displayName: "United States",
    displayNameNoCountryCode: "US",
    e164Key: "",
  );

  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2526),
      body: Column(
        children: [
          // Custom AppBar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HousifyHomeScreen()),
                      );
                    },
                    child: Image.asset(
                      "assets/app_icon.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications,
                          color: Colors.white, size: 26),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          // White rounded container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      // Profile Image - Updated (no remove option)
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: _profileImage != null
                                  ? Image.file(
                                _profileImage!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                                  : Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.brown.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(Icons.person,
                                    size: 60, color: Colors.white),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: InkWell(
                                onTap: _pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.camera_alt,
                                      color: Colors.white, size: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Form Fields
                      _buildTextField(
                        "Full Name",
                        nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          if (!RegExp(r"^[A-Z][a-zA-Z\s]+$")
                              .hasMatch(value)) {
                            return "Start with capital & only alphabets";
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        "Email Address",
                        emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$")
                              .hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      _buildPhoneField(),
                      _buildTextField(
                        "Current Address",
                        addressController,
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? "Address is required"
                            : null,
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              "Zip Code",
                              zipController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Zip Code is required";
                                }
                                if (!RegExp(r"^\d+$").hasMatch(value)) {
                                  return "Only numbers allowed";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: _buildStateDropdown()),
                        ],
                      ),

                      _buildTextField(
                        "Password",
                        passwordController,
                        obscure: true,
                        validator: (value) => value == null || value.isEmpty
                            ? "Password is required"
                            : null,
                      ),

                      const SizedBox(height: 16),

                      // Change Password
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ChangePasswordScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black12),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Change Password",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Image.asset("assets/app_icon.png",
                                height: 18, width: 18),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Save Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ProfileScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Widgets
  Widget _buildTextField(String label, TextEditingController controller,
      {String? Function(String?)? validator,
        bool obscure = false,
        List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black54),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black12)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10)
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Phone number is required";
          }
          if (value.length != 10) {
            return "Phone number must be 10 digits";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                onSelect: (Country country) {
                  setState(() {
                    selectedCountry = country;
                  });
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black12)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          filled: true,
          fillColor: Colors.grey[100],
          labelText: "Phone Number",
        ),
      ),
    );
  }

  Widget _buildStateDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedState,
      items: ["Pennsylvania", "New York", "California"]
          .map((state) => DropdownMenuItem(
        value: state,
        child: Text(state),
      ))
          .toList(),
      onChanged: (val) {
        setState(() {
          selectedState = val!;
        });
      },
      validator: (value) =>
      value == null || value.isEmpty ? "State is required" : null,
      decoration: InputDecoration(
        labelText: "State",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
