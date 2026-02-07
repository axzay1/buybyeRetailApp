import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

class SellingHistoryScreen extends StatelessWidget {
  const SellingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.sellingHistory),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sell_outlined,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No selling history yet',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
