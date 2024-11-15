import 'package:flutter/material.dart';

import '../theme/colors.dart';

class ProfilePageButton extends StatelessWidget {
  final String? text;
  final Function onTap;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;

  ProfilePageButton(
      {this.text,
      required this.onTap,
      this.color,
      this.textColor,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        width: width ?? 84.0,
        height: height ?? 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? backgroundColor,
            borderRadius: BorderRadius.circular(5.0)),
        child: Text(
          text!,
          style: TextStyle(
              fontSize: 12,
              color: textColor ?? mainColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
