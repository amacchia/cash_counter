import 'package:flutter/material.dart';

import '../models/denomination.dart';

class CurrencyCard extends StatelessWidget {
  final Denomination denomination;
  final Function() calculateTotal;

  const CurrencyCard(this.denomination, this.calculateTotal, {super.key});

  @override
  Widget build(BuildContext context) {
    final currencyCardBody = ListTile(
      title: Text(
        denomination.title,
      ),
      subtitle: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          int count = 0;
          if (value != "") {
            // Should just check if it's not a number
            count = int.parse(value);
          }
          denomination.total = count * denomination.multiplier;
          calculateTotal();
        },
      ),
    );

    return Card(child: currencyCardBody);
  }
}
