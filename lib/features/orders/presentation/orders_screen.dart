import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.orders),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No orders yet',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
