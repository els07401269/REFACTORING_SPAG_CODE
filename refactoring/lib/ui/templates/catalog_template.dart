
import 'package:flutter/material.dart';

class CatalogTemplate extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget catalog;
  final Widget form;

  const CatalogTemplate({
    super.key,
    required this.appBar,
    required this.catalog,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            catalog,
            const Divider(
              height: 32,
              thickness: 1,
            ),
            const Text(
              'Add New Product',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            form,
          ],
        ),
      ),
    );
  }
}
