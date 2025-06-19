import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../view_models/home_viewmodel.dart';

class TotalCountWidget extends StatelessWidget {
  final currencyFormatter =
      NumberFormat.currency(locale: "en_US", symbol: "\$");
  final HomeViewModel viewModel;

  TotalCountWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final total = viewModel.totalCount;
    final formattedTotal = currencyFormatter.format(total);

    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Total $formattedTotal",
          style: Theme.of(context).textTheme.headlineLarge,
        ));
  }
}
