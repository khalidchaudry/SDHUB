import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget(
      {super.key,
      required this.color,
      required this.child,
      required this.width,
      required this.height,
      required this.borderRadius,
      required this.neumorphicBoxShape});
  final Color color;
  final Widget child;
  final double width, height, borderRadius;
  final NeumorphicBoxShape neumorphicBoxShape;
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          lightSource: LightSource.topLeft,
          shape: NeumorphicShape.convex,
          depth: 20,
          surfaceIntensity: 1,
          intensity: 1,
          boxShape: neumorphicBoxShape,
          color: color),
      child: Container(
        width: width,
        height: height,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
        child: child,
      ),
    );
  }
}
