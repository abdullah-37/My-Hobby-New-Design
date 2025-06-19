import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final IconData? suffixIcon;
  final IconData? prefixIcon;

  final bool? obscureText;
  final VoidCallback? onIconTap;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.onIconTap,
    this.keyboardType,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.isRequired = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.height10 / 2),
            child: Row(
              children: [
                Text(
                  labelText!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isRequired
                    ? Text(
                      " *",
                      style: AppStyles.body.copyWith(color: Colors.red),
                    )
                    : Container(),
              ],
            ),
          ),
        ],
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(color: Colors.white),
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          textInputAction:
              nextFocus != null ? TextInputAction.next : TextInputAction.done,
          maxLines: maxLines,
          minLines: minLines,
          inputFormatters: inputFormatters,
          validator: validator,
          onTap: onTap,
          readOnly: readOnly,
          onFieldSubmitted: (_) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          decoration: InputDecoration(
            prefixIcon:
                prefixIcon != null
                    ? IconButton(
                      onPressed: onIconTap,
                      icon: Icon(
                        prefixIcon,
                        color: AppColors.textfieldprefixColor,
                      ),
                    )
                    : null,
            hintText: hintText,
            hintStyle: AppStyles.inputHint,
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
              vertical: Dimensions.height15,
            ),
            filled: true,
            fillColor: AppColors.textfieldcolor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            suffixIcon:
                suffixIcon != null
                    ? IconButton(
                      onPressed: onIconTap,
                      icon: Icon(suffixIcon, color: AppColors.inputHintText),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formatted = '';
    int selectionIndex = newValue.selection.end;

    if (digitsOnly.length >= 4) {
      formatted += digitsOnly.substring(0, 4);
      if (digitsOnly.length >= 5) formatted += '/';
    } else {
      formatted += digitsOnly;
    }

    if (digitsOnly.length >= 6) {
      String month = digitsOnly.substring(4, 6);
      int monthInt = int.parse(month);
      if (monthInt > 12) month = '12';
      formatted += month;
      if (digitsOnly.length >= 7) formatted += '/';
    } else if (digitsOnly.length > 4) {
      formatted += digitsOnly.substring(4);
    }

    if (digitsOnly.length >= 8) {
      String day = digitsOnly.substring(6, 8);
      int dayInt = int.parse(day);
      if (dayInt > 31) day = '31';
      formatted += day;
    } else if (digitsOnly.length > 6) {
      formatted += digitsOnly.substring(6);
    }

    // Handle cursor position
    selectionIndex = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
