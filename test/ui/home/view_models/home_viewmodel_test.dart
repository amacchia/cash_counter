import 'package:cash_counter/models/denomination.dart';
import 'package:cash_counter/models/usd_denominations.dart';
import 'package:cash_counter/ui/home/view_models/home_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeViewModel', () {
    late HomeViewModel viewModel;

    setUp(() {
      viewModel = HomeViewModel();
    });

    test('cash denominations should be set', () {
      Map<USDDenomination, Denomination> expectedDenominations = {
        USDDenomination.singles: Denomination("Singles", 1),
        USDDenomination.fives: Denomination("Fives", 5),
        USDDenomination.tens: Denomination("Tens", 10),
        USDDenomination.twenties: Denomination("Twenties", 20),
        USDDenomination.fifties: Denomination("Fifties", 50),
        USDDenomination.hundreds: Denomination("Hundreds", 100),
      };

      final actualDenominations = viewModel.cashDenominations;

      expect(actualDenominations.length, expectedDenominations.length);
      expect(
          actualDenominations.keys.toSet(), expectedDenominations.keys.toSet());
      for (var i = 0; i < expectedDenominations.length; i++) {
        final expectedDenomination = expectedDenominations.values.elementAt(i);
        final actualDenomination = actualDenominations.values.elementAt(i);
        expect(actualDenomination.title, expectedDenomination.title);
        expect(actualDenomination.multiplier, expectedDenomination.multiplier);
        expect(actualDenomination.total, 0);
      }
    });

    test('initial totalCount is 0', () {
      expect(viewModel.totalCount, 0);
    });

    test('getDenominationTitle returns correct title', () {
      expect(
          viewModel.getDenominationTitle(USDDenomination.singles), 'Singles');
      expect(viewModel.getDenominationTitle(USDDenomination.fives), 'Fives');
      expect(viewModel.getDenominationTitle(USDDenomination.tens), 'Tens');
      expect(
          viewModel.getDenominationTitle(USDDenomination.twenties), 'Twenties');
      expect(
          viewModel.getDenominationTitle(USDDenomination.fifties), 'Fifties');
      expect(
          viewModel.getDenominationTitle(USDDenomination.hundreds), 'Hundreds');
    });

    test('updateDenomination updates total and totalCount', () {
      viewModel.updateDenomination(USDDenomination.fives, '3');

      expect(viewModel.cashDenominations[USDDenomination.fives]?.total, 15);
      expect(viewModel.totalCount, 15);
    });

    test('updateDenomination with invalid value sets total to 0', () {
      viewModel.updateDenomination(USDDenomination.tens, 'abc');

      expect(viewModel.cashDenominations[USDDenomination.tens]?.total, 0);
      expect(viewModel.totalCount, 0);
    });

    test('calculateTotal sums all denominations', () {
      viewModel.updateDenomination(USDDenomination.singles, '2'); 
      viewModel.updateDenomination(USDDenomination.fives, '2');
      viewModel.updateDenomination(USDDenomination.tens, '1');

      viewModel.calculateTotal();

      expect(viewModel.totalCount, 22);
    });

    test('clearAll resets all totals and totalCount', () {
      viewModel.updateDenomination(USDDenomination.twenties, '2');
      viewModel.updateDenomination(USDDenomination.fifties, '1');

      viewModel.clearAll();

      for (final denom in viewModel.cashDenominations.values) {
        expect(denom.total, 0);
      }
      expect(viewModel.totalCount, 0);
    });
  });
}
