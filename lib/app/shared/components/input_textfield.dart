import 'package:flutter/material.dart';

class InputTextfield extends StatefulWidget {
  final String? labelText;
  final IconData icon;
  final TextEditingController controller;
  final bool initialObscureText;

  const InputTextfield({
    super.key,
    this.labelText,
    required this.icon,
    required this.controller,
    required this.initialObscureText,
  });

  @override
  State<InputTextfield> createState() => _InputTextfieldState();
}

class _InputTextfieldState extends State<InputTextfield> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.initialObscureText;
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      maxLines: 1,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintStyle: const TextStyle(color: Colors.white70, fontSize: 14),
        filled: true,
        prefixIcon: Icon(
          widget.icon,
          color: Colors.white70,
        ),
        suffixIcon: widget.initialObscureText
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: toggleObscureText,
              )
            : null,
        fillColor: Colors.blue.withOpacity(.5),
        border: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
