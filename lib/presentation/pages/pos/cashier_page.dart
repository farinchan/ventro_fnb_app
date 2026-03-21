import 'package:flutter/material.dart';

class CashierPage extends StatelessWidget {
  static const String routeName = 'cashier';
  const CashierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashier Page'),
      ),
      body: const Center(
        child: Text('This is the Cashier Page'),
      ),
    );
  }
}