
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final String label;
  final bool isPassword;
  final Function(String) onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.label,
    required this.isPassword,
    required this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}


class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
      (widget.isPassword == true)
          ? TextInputType.visiblePassword
          : TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon),
        label: Text(widget.label),
        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
      ),
      onChanged: widget.onChanged,
      obscureText: (widget.isPassword == true) ? true : false,
    );
  }
}