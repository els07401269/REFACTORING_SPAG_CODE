
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../atoms/app_text.dart';
import '../molecules/search_field.dart';
import 'product_card.dart';

class ProductCatalog extends StatelessWidget {
  final List<Product> products;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<Product> onAddToCart;
  final ValueChanged<Product> onDelete;

  const ProductCatalog({
    super.key,
    required this.products,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onAddToCart,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product.name
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Search Products',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        const SizedBox(height: 8),
        SearchField(
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 16),
        const AppText(
          text: 'Catalog',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        const SizedBox(height: 8),
        Column(
          children: filteredProducts.map((product) {
            return ProductCard(
              product: product,
              onAddToCart: () => onAddToCart(product),
              onDelete: () => onDelete(product),
            );
          }).toList(),
        ),
      ],
    );
  }
}

