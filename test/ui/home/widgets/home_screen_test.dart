import 'package:cash_counter/ui/home/widgets/denomination_input_widget.dart';
import 'package:cash_counter/ui/home/widgets/total_count_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cash_counter/ui/home/widgets/home_screen.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('renders TotalCountWidget and DenominationInput',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: HomeScreen()),
        ),
      );

      expect(find.byType(TotalCountWidget), findsOneWidget);
      expect(find.byType(DenominationInput), findsOneWidget);
    });
  });
}
