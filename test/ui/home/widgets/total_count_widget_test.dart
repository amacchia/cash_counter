import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cash_counter/ui/home/widgets/total_count_widget.dart';
import 'package:cash_counter/ui/home/view_models/home_viewmodel.dart';

class FakeHomeViewModel extends HomeViewModel {
  final int _fakeTotal;
  FakeHomeViewModel(this._fakeTotal);
  @override
  int get totalCount => _fakeTotal;
}

void main() {
  group('TotalCountWidget', () {
    testWidgets('displays formatted total when totalCount is 0',
        (WidgetTester tester) async {
      final viewModel = FakeHomeViewModel(0);

      await tester.pumpWidget(
        MaterialApp(
          home: TotalCountWidget(viewModel: viewModel),
        ),
      );

      expect(find.text('Total \$0.00'), findsOneWidget);
    });

    testWidgets('displays formatted total when totalCount is positive',
        (WidgetTester tester) async {
      final viewModel = FakeHomeViewModel(1234);

      await tester.pumpWidget(
        MaterialApp(
          home: TotalCountWidget(viewModel: viewModel),
        ),
      );

      expect(find.text('Total \$1,234.00'), findsOneWidget);
    });
  });
}
