
import 'package:flutter/material.dart';

class AppDropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final String labelText;
  final ValueChanged<String?> onChanged;

  const AppDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

