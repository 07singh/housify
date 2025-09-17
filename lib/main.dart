import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forget_password_screen.dart';
import 'screens/reset_email_screen.dart';
import 'screens/set_new_password_screen.dart';
import 'screens/housify_home_screen.dart';
import 'services/api_service.dart';

void main() {
  runApp(const HouseServiceApp());
}

class HouseServiceApp extends StatelessWidget {
  const HouseServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());

          case '/welcome':
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());

          case '/otp':
            final args = settings.arguments;
            if (args is Map<String, dynamic> &&
                args.containsKey('phoneNumber')) {
              return MaterialPageRoute(
                builder: (_) => OTPScreen(phoneNumber: args['phoneNumber']),
              );
            }
            return _errorScreen('Invalid arguments for OTP screen');

          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());

          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());

          case '/forget_password':
            return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

          case '/reset_email':
            return MaterialPageRoute(builder: (_) => const ResetEmailScreen());

          case '/set_new_password':
            return MaterialPageRoute(builder: (_) => const SetNewPasswordScreen());

          case '/home':
            return MaterialPageRoute(builder: (_) => const HousifyHomeScreen());

          default:
            return _errorScreen('404 - Page not found');
        }
      },
    );
  }

  MaterialPageRoute _errorScreen(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
