import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoolTextField extends StatefulWidget {
  const CoolTextField({
    required this.placeholder,
    required this.focusNode,
    this.onDone,
    this.onChanged,
    this.initialValue,
    this.validator,
    this.isPassword = false,
    this.autofillHints,
    this.keyboardType,
    this.errorMessage,
    super.key,
  });

  final FocusNode focusNode;
  final bool isPassword;
  final String placeholder;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final String? initialValue;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final void Function(String)? onDone;
  final void Function(String)? onChanged;

  @override
  State<CoolTextField> createState() => _CoolTextFieldState();
}

class _CoolTextFieldState extends State<CoolTextField> {
  late final TextEditingController controller;
  bool isFocused = false;

  String text = "";
  String? errorMessage;
  bool validateOnChange = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        text = widget.initialValue ?? '';
      });
      controller.addListener(() {
        widget.onChanged?.call(controller.text);
      });
      widget.focusNode.addListener(() {
        setState(() {
          isFocused = widget.focusNode.hasFocus;
        });
      });
    });
  }

  String? validate(String? value) {
    if (widget.validator != null) {
      final res = widget.validator!(value);

      setState(() {
        errorMessage = res;
      });

      return res;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeTextField(
      autocorrect: false,
      focusNode: widget.focusNode,
      controller: controller,
      enableSuggestions: false,
      minFontSize: 12,
      maxFontSize: 80,
      stepGranularity: 4,
      textAlignVertical: TextAlignVertical.center,
      maxLines: 50,
      obscureText: widget.isPassword ? !showPassword : false,
      style: GoogleFonts.pressStart2p(
        fontSize: 80,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
      onEditingComplete: () {
        widget.focusNode.unfocus();
        final res = validate(text);

        if (res != null) {
          setState(() {
            validateOnChange = true;
          });
        }

        if (text != "" && res == null) {
          widget.onDone?.call(text);
        }
      },
      onChanged: (value) {
        if (validateOnChange) {
          validate(value);
        }
        setState(() {
          text = value;
        });
      },
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: widget.placeholder,
        hintStyle: GoogleFonts.pressStart2p(
          fontSize: 80,
          fontWeight: FontWeight.w700,
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
