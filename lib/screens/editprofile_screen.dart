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
  TextEditingController(text: "Test@123");

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

  /// ================== IMAGE PICK + REMOVE ==================
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () async {
                Navigator.pop(ctx);
                await _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                Navigator.pop(ctx);
                await _pickImage(ImageSource.gallery);
              },
            ),
            if (_profileImage != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Remove Photo"),
                onTap: () {
                  Navigator.pop(ctx);
                  setState(() {
                    _profileImage = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  /// ================== VALIDATORS ==================
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return "Name is required";
    if (!RegExp(r"^[A-Z][a-zA-Z\s]{1,49}$").hasMatch(value.trim())) {
      return "Name must start with capital & only letters (max 50 chars)";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email is required";
    if (!RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value.trim())) {
      return "Enter a valid email";
    }
    return null;
  }

// ================= PHONE VALIDATOR =================
  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    final phone = value.trim();
    final code = selectedCountry.countryCode;

    // ❌ Repeated digit check (111111, 9999999999, etc.)
    if (RegExp(r'^(\d)\1{5,}$').hasMatch(phone)) {
      return "Phone number cannot have repeated digits only";
    }

    // ✅ Country-specific validation
    if (code == "IN") {
      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) {
        return "Enter valid 10-digit Indian number";
      }
      if (phone.length != 10) return "Indian number must be 10 digits";
    } else if (code == "US") {
      if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
        return "Enter valid 10-digit US number";
      }
      if (phone.length != 10) return "US number must be 10 digits";
    } else if (code == "GB") {
      if (!RegExp(r'^\d{10,11}$').hasMatch(phone)) {
        return "Enter valid UK number (10–11 digits)";
      }
    } else {
      if (!RegExp(r'^\d{6,15}$').hasMatch(phone)) {
        return "Enter valid phone number (6–15 digits)";
      }
    }

    return null;
  }

// ================= ADDRESS VALIDATOR =================
  String? _validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }
    if (value.trim().length < 5) {
      return "Address must be at least 5 characters";
    }
    return null;
  }

// ================= ZIP VALIDATOR =================
  String? _validateZip(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "ZIP/Postal Code is required";
    }

    final zip = value.trim();
    final code = selectedCountry.countryCode;

    // ❌ Prevent only repeated characters (111111, 000000, AAAA)
    if (RegExp(r'^(\w)\1{2,}$').hasMatch(zip)) {
      return "ZIP/Postal Code cannot have only repeated characters";
    }

    if (code == "US") {
      if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(zip)) {
        return "Enter valid US ZIP (e.g. 12345 or 12345-6789)";
      }
    } else if (code == "IN") {
      if (!RegExp(r'^\d{6}$').hasMatch(zip)) {
        return "Enter valid 6-digit Indian PIN code";
      }
    } else if (code == "GB") {
      if (!RegExp(r'^[A-Za-z0-9\s]{5,8}$').hasMatch(zip)) {
        return "Enter valid UK postal code";
      }
    } else {
      if (!RegExp(r'^[A-Za-z0-9\s-]{3,12}$').hasMatch(zip)) {
        return "Enter valid postal code";
      }
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 8) return "Min 8 characters required";
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Must contain at least 1 uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Must contain at least 1 lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Must contain at least 1 number";
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return "Must contain at least 1 special character";
    }
    return null;
  }

  /// ================== UI ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2526),
      body: Column(
        children: [
          /// ✅ Custom AppBar
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

          /// ✅ White rounded container
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
                      /// ✅ Profile Image
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
                              right: 0,
                              child: InkWell(
                                onTap: _showImageOptions,
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

                      /// ✅ Fields with validators
                      _buildTextField("Full Name", nameController,
                          validator: _validateName),
                      _buildTextField("Email Address", emailController,
                          validator: _validateEmail),
                      _buildPhoneField(),
                      _buildTextField("Current Address", addressController,
                          validator: _validateAddress),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField("ZIP Code", zipController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: _validateZip),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: _buildStateDropdown()),
                        ],
                      ),
                      _buildTextField("Password", passwordController,
                          obscure: true, validator: _validatePassword),

                      const SizedBox(height: 16),

                      /// ✅ Change Password Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                  const ChangePasswordScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black12),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Change Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// ✅ Save Button
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

  /// ================== Reusable Widgets ==================
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
        validator: _validatePhone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(15)
        ],
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
