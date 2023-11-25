import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TMDBTextField extends StatelessWidget {
  const TMDBTextField(
      {super.key,
      this.hinttext,
      this.controller,
      this.suffixIcon,
      this.suffixIconConstraints,
      this.prefixIcon,
      this.prefixIconConstraints,
      this.errorText,
      this.onChanged,
      this.validator,
      this.focusNode,
      this.onFieldSubmitted,
      this.focusedBorder,
      this.enabledBorder,
      this.keyboardType,
      this.maxLength,
      this.inputFormatters,
      this.contentPadding,
      this.onTap,
       this.enabled,
       required this.readOnly,
      this.autoFocus,
      this.autofillHints,
      this.code,
      this.borderRadius});

  final String? hinttext;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final String? errorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
//   final TextInputType? textInputType;
  final Function(String)? onFieldSubmitted;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onTap;
  final bool? enabled;
  final bool readOnly;
  final bool? autoFocus;
  final Iterable<String>? autofillHints;
  final String? code;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        autofocus: autoFocus ?? false,
        autofillHints: autofillHints,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        onTap: onTap,
        // controller: phoneController,
        enabled: enabled,
        keyboardType: keyboardType ?? TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        maxLength: maxLength,

        readOnly: readOnly,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          counterText: "",
          hintText: hinttext,
          filled: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIconConstraints,
          suffixIconConstraints: suffixIconConstraints,
          errorMaxLines: 3,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: borderRadius ?? BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent)),
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
