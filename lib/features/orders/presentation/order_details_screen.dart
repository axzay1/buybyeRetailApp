import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.orderDetails),
      ),
      body: const Center(
        child: Text('Order Details - Coming Soon'),
      ),
    );
  }
}
