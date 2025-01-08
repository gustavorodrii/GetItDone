import 'package:flutter/material.dart';

class InputTextfield extends StatelessWidget {
  final String? labelText;
  final IconData icon;
  final TextEditingController controller;

  const InputTextfield({
    super.key,
    this.labelText,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
        filled: true,
        prefixIcon: Icon(
          icon,
        ),
        // ignore: deprecated_member_use
        fillColor: Colors.grey[200]?.withOpacity(0.5),
        border: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
      ),
    );
  }
}
