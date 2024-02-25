import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.fieldText,
  });

  final String fieldText;

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late FocusNode focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(handleFocusChange);
  }

  void handleFocusChange() {
    if (focusNode.hasFocus != isFocused) {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(handleFocusChange);
    focusNode.dispose();
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
      )
    );
  }
}