import 'package:flutter/material.dart';

class BrutalCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double borderWidth;
  final double shadowOffset;

  const BrutalCard({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 12.0,
    this.borderWidth = 3.0,
    this.shadowOffset = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.black, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(shadowOffset, shadowOffset),
            blurRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - borderWidth),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
