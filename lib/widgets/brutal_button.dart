import 'package:flutter/material.dart';

class BrutalButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const BrutalButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = const Color(0xFF6366f1),
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
  });

  @override
  State<BrutalButton> createState() => _BrutalButtonState();
}

class _BrutalButtonState extends State<BrutalButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.onPressed != null
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed!();
            }
          : null,
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(
          _isPressed ? 4.0 : 0.0,
          _isPressed ? 4.0 : 0.0,
          0.0,
        ),
        decoration: BoxDecoration(
          color: widget.onPressed == null ? Colors.grey : widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: Colors.black, width: 3.0),
          boxShadow: _isPressed
              ? []
              : [
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset(6, 6),
                    blurRadius: 0,
                  ),
                ],
        ),
        child: Padding(
          padding: widget.padding,
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
