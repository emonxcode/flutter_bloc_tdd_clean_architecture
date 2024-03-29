import 'package:flutter/material.dart';

class BlogField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final int? maxLines;
  final Widget? suffixIcon;
  const BlogField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      this.validator,
      this.prefixIcon,
      this.maxLines,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      maxLines: maxLines,
    );
  }
}
