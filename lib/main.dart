import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_screen.dart';

void main() {
  runApp(
    ProviderScope(child: MaterialApp(
      title: '割り勘金額計算アプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const WarikanCalculatorScreen(),
    ))
  );
}
