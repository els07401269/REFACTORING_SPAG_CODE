
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../organism/product_catalog.dart';
import '../organism/product_form.dart';
import '../templates/catalog_template.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Wireless Mouse',
      price: 599.0,
      category: 'Electronics',
      icon: Icons.mouse,
    ),
    Product(
      id: 2,
      name: 'Mechanical Keyboard',
      price: 2499.0,
      category: 'Electronics',
      icon: Icons.keyboard,
    ),
    Product(
      id: 3,
      name: 'Ceramic Mug',
      price: 149.0,
      category: 'Home',
      icon: Icons.coffee,
    ),
    Product(
      id: 4,
      name: 'Notebook',
      price: 79.0,
      category: 'Office',
      icon: Icons.book,
    ),
    Product(
      id: 5,
      name: 'Desk Lamp',
      price: 899.0,
      category: 'Home',
      icon: Icons.lightbulb,
    ),
    Product(
      id: 6,
      name: 'Backpack',
      price: 1299.0,
      category: 'Accessories',
      icon: Icons.backpack,
    ),
    Product(
      id: 7,
      name: 'Water Bottle',
      price: 299.0,
      category: 'Accessories',
      icon: Icons.local_drink,
    ),
  ];

  String _searchQuery = '';
  int _nextId = 8;

  void _deleteProduct(Product product) {
    setState(() {
      _products.removeWhere(
        (item) => item.id == product.id,
      );
    });
  }

  void _addToCart(Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added ${product.name} to cart',
        ),
      ),
    );
  }

  bool _addNewProduct(ProductDraft draft) {
    final newProduct = Product(
      id: _nextId,
      name: draft.name,
      price: draft.price,
      category: draft.category,
      icon: Icons.inventory_2,
      description: draft.description,
    );

    setState(() {
      _products.add(newProduct);
      _nextId++;
      _searchQuery = '';
    });

    return true;
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Messy Catalog',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.indigo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CatalogTemplate(
      appBar: _buildAppBar(),
      catalog: ProductCatalog(
        products: _products,
        searchQuery: _searchQuery,
        onSearchChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        onAddToCart: _addToCart,
        onDelete: _deleteProduct,
      ),
      form: ProductForm(
        onSubmit: _addNewProduct,
      ),
    );
  }
}

