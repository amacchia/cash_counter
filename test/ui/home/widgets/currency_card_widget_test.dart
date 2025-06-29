import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cash_counter/ui/home/widgets/currency_card_widget.dart';
import 'package:cash_counter/ui/home/view_models/home_viewmodel.dart';
import 'package:cash_counter/models/usd_denominations.dart';

class FakeHomeViewModel extends HomeViewModel {
  String? lastValue;
  USDDenomination? lastDenomination;

  @override
  void updateDenomination(USDDenomination usdDenomination, String value) {
    lastDenomination = usdDenomination;
    lastValue = value;
    super.updateDenomination(usdDenomination, value);
  }

  @override
  String getDenominationTitle(USDDenomination usdDenomination) {
    return usdDenomination.name;
  }
}

void main() {
  group('CurrencyCard', () {
    testWidgets('displays denomination title', (WidgetTester tester) async {
      final viewModel = FakeHomeViewModel();
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: CurrencyCard(USDDenomination.fives, controller,
              viewModel: viewModel),
        ),
      );

      expect(find.text('fives'), findsOneWidget);
    });

    testWidgets('calls updateDenomination on input',
        (WidgetTester tester) async {
      final viewModel = FakeHomeViewModel();
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: CurrencyCard(USDDenomination.tens, controller,
              viewModel: viewModel),
        ),
      );
      await tester.enterText(find.byType(TextField), '42');

      expect(viewModel.lastDenomination, USDDenomination.tens);
      expect(viewModel.lastValue, '42');
    });

    testWidgets('TextField only accepts digits', (WidgetTester tester) async {
      final viewModel = FakeHomeViewModel();
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: CurrencyCard(USDDenomination.singles, controller,
              viewModel: viewModel),
        ),
      );
      await tester.enterText(find.byType(TextField), 'abc123');

      expect(controller.text, '123');
    });
  });
}
