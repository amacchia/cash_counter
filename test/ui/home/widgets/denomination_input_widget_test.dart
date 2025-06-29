import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cash_counter/ui/home/widgets/denomination_input_widget.dart';
import 'package:cash_counter/ui/home/view_models/home_viewmodel.dart';
import 'package:cash_counter/models/usd_denominations.dart';

class FakeHomeViewModel extends HomeViewModel {
  bool clearAllCalled = false;

  @override
  void clearAll() {
    clearAllCalled = true;
    super.clearAll();
  }

  @override
  String getDenominationTitle(USDDenomination usdDenomination) {
    return usdDenomination.name;
  }
}

void main() {
  late FakeHomeViewModel viewModel;

  setUp(() {
    viewModel = FakeHomeViewModel();
  });

  group('DenominationInput', () {
    testWidgets('renders a CurrencyCard for each denomination',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DenominationInput(viewModel: viewModel),
        ),
      );

      for (final denomination in USDDenomination.values) {
        expect(find.text(denomination.name), findsOneWidget);
      }
    });

    testWidgets(
        'Clear All button clears all fields and calls viewModel.clearAll',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DenominationInput(viewModel: viewModel),
        ),
      );
      final textFields = find.byType(TextField);
      for (var i = 0; i < USDDenomination.values.length; i++) {
        await tester.enterText(textFields.at(i), '123');
      }

      await tester.tap(find.text('Clear All'));
      await tester.pump();

      for (var i = 0; i < USDDenomination.values.length; i++) {
        final textField = tester.widget<TextField>(textFields.at(i));
        expect(textField.controller?.text ?? '', '');
      }
      expect(viewModel.clearAllCalled, isTrue);
    });

    testWidgets('Large screens have 3 cards per row', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(700, 800)),
            child: DenominationInput(viewModel: viewModel),
          ),
        ),
      );

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate = gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 3);
    });

    testWidgets('Grid adapts to small screen size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(400, 800)),
            child: DenominationInput(viewModel: viewModel),
          ),
        ),
      );
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate = gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisCount, 2);
    });
  });
}
