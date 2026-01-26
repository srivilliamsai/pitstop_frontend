import 'package:flutter_test/flutter_test.dart';
import 'package:pitstop_frontend/main.dart';

void main() {
  testWidgets('App launch smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PitStopApp());

    // Verify that we are on the Login Page (it has "Log in or sign up" text)
    expect(find.text('Log in or sign up'), findsOneWidget);
  });
}
