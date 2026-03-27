import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Hanya ambil angka
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final int value = int.parse(newText);
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );

    String formatted = formatter.format(value).trim();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class TextFieldCustom extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool? currency;
  const TextFieldCustom({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.keyboardType,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: currency == true ? [CurrencyInputFormatter()] : null,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
      ),
    );
  }
}
