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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Total ',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
            child: Text(
              formattedTotal,
              key: ValueKey(total),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }
}
