
import 'package:flutter/material.dart';

import '../atoms/app_button.dart';

class ProductActions extends StatelessWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onDelete;

  const ProductActions({
    super.key,
    required this.onAddToCart,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          label: 'Add to Cart',
          onPressed: onAddToCart,
        ),
        const SizedBox(height: 6),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

