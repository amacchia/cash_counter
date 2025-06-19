import 'package:cash_counter/ui/home/view_models/home_viewmodel.dart';
import 'package:flutter/material.dart';

import 'denomination_input_widget.dart';
import 'total_count_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeViewModel();

    return Column(
      children: [
        ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) {
            return TotalCountWidget(viewModel: viewModel);
          },
        ),
        Expanded(child: DenominationInput(viewModel: viewModel))
      ],
    );
  }
}
