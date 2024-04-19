// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onTap;
  final String fontFamily;
  final double fontSizes;
  final Color? btnColor;
  final Color? textColor;
  const MyButton({
    Key? key,
    required this.btnName,
    required this.onTap,
    required this.fontFamily,
    required this.fontSizes,
    this.btnColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              btnName,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSizes,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
