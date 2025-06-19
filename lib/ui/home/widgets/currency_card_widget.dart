import 'package:cash_counter/models/usd_denominations.dart';
import 'package:cash_counter/ui/home/view_models/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyCard extends StatelessWidget {
  final USDDenomination denominationType;
  final TextEditingController _controller;
  final HomeViewModel viewModel;

  const CurrencyCard(this.denominationType, this._controller,
      {super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final currencyCardBody = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            viewModel.getDenominationTitle(denominationType),
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
            padding: EdgeInsets.all(24.0),
            child: TextField(
              controller: _controller,
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
    viewModel.updateDenomination(denominationType, value);
  }
}
