import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController conText;
  final String labText;
  final Color? labelColor;
  final Widget? ic;
  final Widget? Buttic;
  final bool obscureText;
  final String? Function(String?)? Validator;


  const CustomTextForm({
    required this.conText,
    required this.labText,
    this.labelColor,
    this.ic,
    this.Buttic,
    this.obscureText = false,
    required this.Validator,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: conText,
        obscureText: obscureText,
        validator: Validator,
        decoration: InputDecoration(
          labelText: labText,
          labelStyle: TextStyle(
              color: labelColor
          ),
          prefixIcon: ic,
          suffixIcon: Buttic,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 58, 110, 153),
                  width: 4
              )
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 58, 110, 153),
                  width: 4
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 58, 110, 153),
                  width: 4
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 58, 110, 153),
                  width: 4
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 58, 110, 153),
                  width: 4
              )
          ),
        ),
      ),
    );
  }
}
