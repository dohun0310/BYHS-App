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
    focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus != isFocused) {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: widget.fieldText,
          hintText: isFocused ? null : widget.fieldText,
          border: OutlineInputBorder(),
        ),
      )
    );
  }
}