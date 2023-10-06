import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WarikanCalculatorBody extends StatelessWidget {
  const WarikanCalculatorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: null, //TODO: 後で変更
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: '金額（円）',
              hintText: '金額を入力してください',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: null,  //TODO: 後で変更
                icon: Icon(Icons.clear),
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          TextFormField(
            controller: null, //TODO: 後で変更
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: '税率（％）',
              hintText: '税率を入力してください',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: null,  //TODO: 後で変更
                icon: Icon(Icons.clear),
              ),
            ),
          ),
          const SizedBox(height: 16.0),

          TextFormField(
            controller: null, //TODO: 後で変更
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: '人数（人）',
              hintText: '人数を入力してください',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: null,  //TODO: 後で変更
                icon: Icon(Icons.clear),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
