import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/denomination.dart';

class CurrencyCard extends StatelessWidget {
  final Denomination denomination;
  final Function() calculateTotal;

  const CurrencyCard(this.denomination, this.calculateTotal, {super.key});

  @override
  Widget build(BuildContext context) {
    final currencyCardBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            denomination.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
            padding: EdgeInsets.all(24.0),
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration(
                hintText: "0",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: _onChanged,
            ))
      ],
    );

    return SizedBox(height: 1, child: Card(child: currencyCardBody));
  }

  void _onChanged(String value) {
    int count = int.tryParse(value) ?? 0;
    denomination.total = count * denomination.multiplier;
    calculateTotal();
  }
}
