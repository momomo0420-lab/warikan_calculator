import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_body.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_view_model.dart';

class WarikanCalculatorScreen extends ConsumerWidget {
  const WarikanCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(warikanCalculatorViewModelProvider.notifier);
    final state = ref.watch(warikanCalculatorViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('割り勘金額計算アプリ')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: WarikanCalculatorBody(
            viewModel: viewModel,
            state: state,
          ),
        ),
      ),
    );
  }
}
