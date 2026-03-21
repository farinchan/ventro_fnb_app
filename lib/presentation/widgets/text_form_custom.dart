import 'package:flutter/material.dart';

class TextFormCustom extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final void Function(String)? onFieldSubmitted;
  final int maxLines;
  final int? minLines;

  const TextFormCustom({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  State<TextFormCustom> createState() => _TextFormCustomState();
}

class _TextFormCustomState extends State<TextFormCustom> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final bool isMultiLine = widget.maxLines > 1 || widget.minLines != null && widget.minLines! > 1;
    final double borderRadius = isMultiLine ? 16 : 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            widget.labelText ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        if (widget.labelText != null) const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          keyboardType: isMultiLine ? TextInputType.multiline : widget.keyboardType,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color(0xFF9A9A9A)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                : widget.suffixIcon,
          ),
          obscureText: _obscure,
          textInputAction: isMultiLine ? TextInputAction.newline : widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
        ),
      ],
    );
  }
}