import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:byhsapp/theme.dart';

class CustomTextField extends StatefulWidget {
  final String fieldText;
  final int minVal;
  final int maxVal;
  final Function(String) onTextChanged;

  const CustomTextField({
    super.key,
    required this.fieldText,
    required this.minVal,
    required this.maxVal,
    required this.onTextChanged,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController controller;
  late FocusNode focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = TextEditingController();

    focusNode.addListener(() {
      if (focusNode.hasFocus != isFocused) {
        setState(() {
          isFocused = focusNode.hasFocus;
        });
      }
    });

    controller.addListener(() {
      widget.onTextChanged(controller.text);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        focusNode: focusNode,
        cursorColor: Theme.of(context).extension<AppExtension>()!.colors.text,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: widget.fieldText,
          labelStyle: TextStyle(
            color: Theme.of(context).extension<AppExtension>()!.colors.text,
          ),
          hintText: isFocused ? null : widget.fieldText,
          hintStyle: ThemeTexts.calloutRegular.copyWith(
            color: Theme.of(context).extension<AppExtension>()!.colors.text
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).extension<AppExtension>()!.colors.outline,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).extension<AppExtension>()!.colors.text,
              width: 2,
            ),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          ValueInputFormatter(minVal: widget.minVal, maxVal: widget.maxVal)
        ],
      )
    );
  }
}

class ValueInputFormatter extends TextInputFormatter {
  final int maxVal;
  final int minVal;
  ValueInputFormatter({required this.maxVal, required this.minVal});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      final int value = int.parse(newValue.text);
      if (value > maxVal || value < minVal) {
        return oldValue;
      }
    }
    return newValue;
  }
}