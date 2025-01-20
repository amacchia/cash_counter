import 'package:flutter/material.dart';

import 'currency_card_widget.dart';
import '../models/denomination.dart';

class DenominationInput extends StatelessWidget {
  static List<Denomination> usdCashDenominations = [
    Denomination("Singles", 1),
    Denomination("Fives", 5),
    Denomination("Tens", 10),
    Denomination("Twenties", 20),
    Denomination("Fifties", 50),
    Denomination("Hundreds", 100),
  ];
  final Function(int) updateTotalCountDisplay;

  const DenominationInput(
    this.updateTotalCountDisplay, {
    super.key,
  });

  void calculateTotal() {
    int total = 0;
    for (final denomination in usdCashDenominations) {
      total += denomination.total;
    }
    updateTotalCountDisplay(total);
  }

  @override
  Widget build(BuildContext context) {
    final List<CurrencyCard> currencyCards = [];
    for (final denomination in usdCashDenominations) {
      final denominationCard = CurrencyCard(denomination, calculateTotal);
      currencyCards.add(denominationCard);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    debugPrint("Screen width: $screenWidth");
    final isLargeScreen = screenWidth > 600;
    final crossAxisCount = isLargeScreen ? 3 : 2;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      padding: EdgeInsets.all(8.0),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: currencyCards,
    );
  }
}
