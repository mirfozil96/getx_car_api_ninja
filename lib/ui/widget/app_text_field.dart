import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_color.dart';
import '../utils/app_typography.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.icon,
    this.autoFocus,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.formKey,
    this.onChanged,
    this.withClearButton = true,
  });

  final TextEditingController? controller;
  final String hintText;
  final String? icon;
  final bool? autoFocus;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final GlobalKey<FormState>? formKey;
  final ValueChanged<String>? onChanged;
  final bool withClearButton;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController controller =
      widget.controller ?? TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: controller,
        style: AppTypography.bodyParagraph1,
        autofocus: widget.autoFocus ?? false,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography.bodyMediumRegular.copyWith(fontSize: 15),
          fillColor: AppColor.basic95,
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          prefixIcon: widget.icon == null
              ? null
              : SizedBox(
                  width: 25,
                  height: 25,
                  child: Center(
                    widthFactor: 0,
                    child: SvgPicture.asset(
                      widget.icon!,
                      width: 25,
                    ),
                  ),
                ),
          suffixIcon: widget.withClearButton && controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.text = '';
                    widget.onChanged?.call('');
                  },
                  child: const SizedBox(
                    width: 18,
                    height: 18,
                    child: Center(
                      widthFactor: 0,
                      child: Icon(Icons.clear),
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(244),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(244),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(244),
            borderSide: const BorderSide(
              color: AppColor.error30,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(244),
            borderSide: const BorderSide(
              color: AppColor.error30,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(244),
            borderSide: const BorderSide(color: AppColor.primary60),
          ),
        ),
      ),
    );
  }
}
