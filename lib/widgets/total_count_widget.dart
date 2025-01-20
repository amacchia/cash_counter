import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalCountWidget extends StatelessWidget {
  final int total;
  final currencyFormatter =
      NumberFormat.currency(locale: "en_US", symbol: "\$");

  TotalCountWidget(this.total, {super.key});

  @override
  Widget build(BuildContext context) {
    final formattedTotal = currencyFormatter.format(total);

    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Total $formattedTotal",
          style: Theme.of(context).textTheme.headlineLarge,
        ));
  }
}
