import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphismButtonWidget extends StatelessWidget {
  const NeumorphismButtonWidget(
      {super.key,
      required this.press,
      required this.color,
      required this.width,
      required this.height,
      required this.radius,
      required this.child,
      required this.isCheck});
  final Function() press;
  final Color color;
  final double width;
  final double height;
  final bool isCheck;
  final double radius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Offset distance =
        isCheck == false ? const Offset(5, 5) : const Offset(10, 15);
    double blur = isCheck == false ? 5.0 : 20.0;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
          boxShadow: [
            BoxShadow(
                offset: -distance,
                blurRadius: blur,
                color: Colors.white,
                inset: isCheck),
            BoxShadow(
                offset: distance,
                blurRadius: blur,
                color: Colors.grey,
                inset: isCheck)
          ]),
      child: TextButton(
          style: TextButton.styleFrom(
              foregroundColor: Colors.indigoAccent,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: press,
          child: child),
    );
  }
}
