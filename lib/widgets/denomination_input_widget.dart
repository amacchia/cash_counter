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
    List<CurrencyCard> currencyCards = _buildCurrencyCards();
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final crossAxisCount = _getItemsInRow(isLargeScreen);
    final maxWidth = _getMaxWidth(isLargeScreen);

    return Padding(
        padding: EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: GridView.builder(
            itemCount: currencyCards.length,
            itemBuilder: (context, index) => currencyCards[index],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
          ),
        ));
  }

  List<CurrencyCard> _buildCurrencyCards() {
    final List<CurrencyCard> currencyCards = [];

    for (final denomination in usdCashDenominations) {
      final denominationCard = CurrencyCard(denomination, calculateTotal);
      currencyCards.add(denominationCard);
    }

    return currencyCards;
  }

  int _getItemsInRow(bool isLargeScreen) {
    final itemsInLargeScreenRow = 3;
    final itemsInSmallScreenRow = 2;

    return isLargeScreen ? itemsInLargeScreenRow : itemsInSmallScreenRow;
  }

  double _getMaxWidth(bool isLargeScreen) {
    final smallScreenSidePadding = double.infinity;
    final largeScreenSidePadding = 1200.0;

    return isLargeScreen ? largeScreenSidePadding : smallScreenSidePadding;
  }
}
