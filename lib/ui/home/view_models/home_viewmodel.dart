import 'package:cash_counter/models/denomination.dart';
import 'package:cash_counter/models/usd_denominations.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  final Map<USDDenomination, Denomination> _cashDenominations = {
    USDDenomination.singles: Denomination("Singles", 1),
    USDDenomination.fives: Denomination("Fives", 5),
    USDDenomination.tens: Denomination("Tens", 10),
    USDDenomination.twenties: Denomination("Twenties", 20),
    USDDenomination.fifties: Denomination("Fifties", 50),
    USDDenomination.hundreds: Denomination("Hundreds", 100),
  };
  Map<USDDenomination, Denomination> get cashDenominations => _cashDenominations;

  var _totalCount = 0;
  int get totalCount => _totalCount;

  String getDenominationTitle(USDDenomination usdDenomination) {
    return _cashDenominations[usdDenomination]?.title ?? '';
  }

  void updateDenomination(USDDenomination usdDenomination, String value) {
    int count = int.tryParse(value) ?? 0;
    final denomination = _cashDenominations[usdDenomination];
    denomination!.total = count * denomination.multiplier;
    
    calculateTotal();
  }

  void calculateTotal() {
    _totalCount = 0;
    for (final denomination in _cashDenominations.values) {
      _totalCount += denomination.total;
    }
    
    notifyListeners();
  }

  void clearAll() {
    for (final denomination in _cashDenominations.values) {
      denomination.total = 0;
    }
    _totalCount = 0;
    
    notifyListeners();
  }

}
