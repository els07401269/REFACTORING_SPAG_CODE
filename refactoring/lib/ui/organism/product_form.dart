
import 'package:flutter/material.dart';

import '../atoms/app_button.dart';
import '../atoms/app_dropdown_field.dart';
import '../atoms/app_text_field.dart';

class ProductDraft {
  final String name;
  final double price;
  final String category;
  final String description;

  const ProductDraft({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
  });
}

class ProductForm extends StatefulWidget {
  final bool Function(ProductDraft draft) onSubmit;

  const ProductForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _priceController =
      TextEditingController();

  final TextEditingController _descriptionController =
      TextEditingController();

  String _selectedCategory = 'Electronics';

  final List<String> _categories = [
    'Electronics',
    'Home',
    'Office',
    'Accessories',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final draft = ProductDraft(
      name: _nameController.text,
      price: double.parse(_priceController.text),
      category: _selectedCategory,
      description: _descriptionController.text,
    );

    final wasAdded = widget.onSubmit(draft);

    if (wasAdded && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${draft.name} added to catalog!',
          ),
          backgroundColor: Colors.green,
        ),
      );

      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();

      setState(() {
        _selectedCategory = 'Electronics';
      });
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name is required';
    }

    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }

    final parsed = double.tryParse(value);

    if (parsed == null) {
      return 'Price must be a number';
    }

    if (parsed <= 0) {
      return 'Price must be greater than zero';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: _nameController,
            labelText: 'Product Name',
            validator: _validateName,
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: _priceController,
            labelText: 'Price',
            keyboardType: TextInputType.number,
            validator: _validatePrice,
          ),
          const SizedBox(height: 12),
          AppDropdownField(
            value: _selectedCategory,
            items: _categories,
            labelText: 'Category',
            onChanged: (value) {
              setState(() {
                _selectedCategory = value ?? 'Electronics';
              });
            },
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: _descriptionController,
            labelText: 'Description',
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: 'Submit Product',
              onPressed: _submit,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

