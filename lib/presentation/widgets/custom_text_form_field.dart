import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(13), gapPadding: 7);
    FocusNode myFocusNode = FocusNode();

    return TextFormField(
      focusNode: myFocusNode,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      style: TextStyle(fontSize: 20, color: colors.tertiary),
      decoration: InputDecoration(
        enabledBorder: border.copyWith(
            borderSide: BorderSide(color: colors.inversePrimary, width: 2)),
        focusedBorder: border.copyWith(
            borderSide: BorderSide(color: colors.primary, width: 5)),
        errorBorder: border.copyWith(
            borderSide:
                BorderSide(color:colors.error)),
        focusedErrorBorder: border.copyWith(
            borderSide:
                BorderSide(color:colors.error)),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        errorText: errorMessage,
        focusColor: colors.primary
        // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
      ),
    );
  }
}
