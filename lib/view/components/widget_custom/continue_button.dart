import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:snaplink_app/main.dart';

import '../theme/colors.dart';
import '../theme/style.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final Color? borderColor;
  final Color? color;
  final TextStyle? style;
  final Widget? icon;
  final Color? textColor;

  CustomButton({
    this.text,
    this.onPressed,
    this.borderColor,
    this.color,
    this.style,
    this.icon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: color ?? mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        icon: icon ?? SizedBox.shrink(),
        onPressed: onPressed as void Function()?,
        label: Text(
          text ?? "continueText".tr(),
          style: style ??
              Theme
                  .of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: textColor ?? secondaryColor),
        ),
      ),
    );
  }
}
