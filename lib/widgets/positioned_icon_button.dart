import 'package:flutter/material.dart';

class PositionedIconButton extends StatelessWidget {
  const PositionedIconButton({
    Key? key,
    this.right,
    this.left,
    this.top,
    this.bottom,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  final double? right;
  final double? left;
  final double? top;
  final double? bottom;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      left: left,
      top: top,
      bottom: bottom,
      child: TextButton(
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: 30,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.surface),
          shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(5)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
