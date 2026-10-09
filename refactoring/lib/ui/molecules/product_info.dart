
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../atoms/app_text.dart';

class ProductInfo extends StatelessWidget {
  final Product product;

  const ProductInfo({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: product.name,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 4),
        AppText(
          text: product.category,
          fontSize: 13,
          color: Colors.grey.shade600,
        ),
        const SizedBox(height: 4),
        AppText(
          text: 'PHP ${product.price.toStringAsFixed(2)}',
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ],
    );
  }
}

