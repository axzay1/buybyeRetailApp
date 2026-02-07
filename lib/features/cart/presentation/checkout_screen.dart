import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.checkout),
      ),
      body: const Center(
        child: Text('Checkout Screen - Coming Soon'),
      ),
    );
  }
}
