import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5000/api";

  /// Send OTP
  static Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final url = Uri.parse("$baseUrl/auth/send-otp");
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );
      if (res.statusCode == 200) return jsonDecode(res.body);
      return {"success": false, "message": "Server error: ${res.statusCode}"};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Verify OTP
  static Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      final url = Uri.parse("$baseUrl/auth/verify-otp");
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone, "otp": otp}),
      );
      if (res.statusCode == 200) return jsonDecode(res.body);
      return {"success": false, "message": "Server error: ${res.statusCode}"};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/auth/login");
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (res.statusCode == 200) return jsonDecode(res.body);
      return {"success": false, "message": "Server error: ${res.statusCode}"};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Forget Password
  static Future<Map<String, dynamic>> forgetPassword({required String email}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/forget-password'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Server error"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// House Shifting
  static Future<Map<String, dynamic>> submitHouseShifting({
    required String houseType,
    required Map<String, int> furnitures,
    required int packedBoxes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/house-shifting'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "houseType": houseType,
          "furnitures": furnitures,
          "packedBoxes": packedBoxes,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Server error"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Optional: Get Notifications
  static Future<Map<String, dynamic>> getNotifications() async {
    try {
      final url = Uri.parse("$baseUrl/notifications");
      final res = await http.get(url);
      if (res.statusCode == 200) return jsonDecode(res.body);
      return {"success": false, "message": "Server error: ${res.statusCode}"};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
