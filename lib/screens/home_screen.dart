import 'package:flutter/material.dart';

import '../widgets/denomination_input_widget.dart';
import '../widgets/total_count_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TotalCountState();
}

class _TotalCountState extends State<StatefulWidget> {
  int _total = 0;

  void _updateTotalCountDisplay(int total) {
    setState(() {
      _total = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TotalCountWidget(_total),
        Expanded(child: DenominationInput(_updateTotalCountDisplay))
      ],
    );
  }
}
