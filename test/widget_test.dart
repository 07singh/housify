import 'package:flutter_test/flutter_test.dart';
import 'package:house_service/main.dart';
import 'package:house_service/screens/onboarding_screen.dart';
import 'package:house_service/screens/welcome_screen.dart';

void main() {
  testWidgets('Onboarding screen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const HouseServiceApp());
    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('Next'), findsOneWidget); // change 'Next' if different
  });

  testWidgets('Tapping Next navigates to WelcomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const HouseServiceApp());
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });
}
