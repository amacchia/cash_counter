import 'package:cash_counter/models/usd_denominations.dart';
import 'package:cash_counter/ui/home/view_models/home_viewmodel.dart';
import 'package:flutter/material.dart';

import 'currency_card_widget.dart';

class DenominationInput extends StatefulWidget {
  final HomeViewModel viewModel;

  const DenominationInput({
    super.key,
    required this.viewModel,
  });

  @override
  State<StatefulWidget> createState() => _DenominationInputState();
}

class _DenominationInputState extends State<DenominationInput> {
  final List<TextEditingController> _textEditcontrollers = [];

  @override
  void initState() {
    super.initState();
    for (final _ in USDDenomination.values) {
      final controller = TextEditingController();
      _textEditcontrollers.add(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CurrencyCard> currencyCards = _buildCurrencyCards();
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final crossAxisCount = _getItemsInRow(isLargeScreen);
    final maxWidth = _getMaxWidth(isLargeScreen);

    final currencyCardGridView = GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: currencyCards.length,
      itemBuilder: (context, index) => currencyCards[index],
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
    );
    final clearAllButtonRow = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => clearAll(),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(200, 60),
            textStyle: TextStyle(fontSize: 18),
            foregroundColor: Colors.white,
          ),
          child: const Text("Clear All"),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              currencyCardGridView,
              SizedBox(height: 16.0),
              clearAllButtonRow,
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _textEditcontrollers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<CurrencyCard> _buildCurrencyCards() {
    final List<CurrencyCard> currencyCards = [];
    final denominationTypes = widget.viewModel.cashDenominations.keys.toList();

    for (int i = 0; i < denominationTypes.length; i++) {
      final denominationType = denominationTypes[i];
      final controller = _textEditcontrollers[i];

      final denominationCard = CurrencyCard(denominationType, controller,
          viewModel: widget.viewModel);

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
    final smallScreenWidth = double.infinity;
    final largeScreenWidth = 1200.0;

    return isLargeScreen ? largeScreenWidth : smallScreenWidth;
  }

  void clearAll() {
    for (final controller in _textEditcontrollers) {
      controller.clear();
    }
    widget.viewModel.clearAll();
  }
}
