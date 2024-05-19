import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? minHeight;
  final double? minWidth;
  final Widget? child;
  final String? text;
  var onPressed;
  final OutlinedBorder? shape;
  final double? elevation;
  final double? borderRadius;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? shadowColor;
  final Gradient? gradientColor;
  final BorderRadiusGeometry? gradientBorderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onLongPress;
  bool? disable;

  CustomButton({
    this.height,
    this.width,
    this.minHeight,
    this.minWidth,
    this.child,
    this.text,
    this.onPressed,
    this.shape,
    this.elevation,
    this.borderRadius,
    this.buttonColor,
    this.splashColor,
    this.shadowColor,
    this.gradientColor,
    this.gradientBorderRadius,
    this.padding,
    this.onLongPress,
    this.disable,
    Key? key,
  })  : assert(text != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ElevatedButton.styleFrom();

    return ElevatedButton(
      onPressed: disable != null ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
        elevation: elevation ?? 0,
        backgroundColor: buttonColor,
        foregroundColor: splashColor,
        shadowColor: shadowColor,
        minimumSize: Size(
          minWidth ?? 60,
          minHeight ?? 40,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        alignment: Alignment.center,
        height: height ?? 48,
        width: width ?? 220,
        decoration: buttonColor == null
            ? BoxDecoration(
                borderRadius: gradientBorderRadius ?? BorderRadius.circular(20),
                // gradient: disable != null
                //     ? Colors.red
                //     : gradientColor ?? Colors.green,
              )
            : null,
        child: child ??
            Text(
              text!,
              style: TextStyle(
                color: buttonColor == null ? const Color(0xffffffff) : null,
                //fontWeight: FontStyles.fontWeightSemiBold,
              ),
            ),
      ),
    );
  }
}
