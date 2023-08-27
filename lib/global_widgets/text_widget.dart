import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.title,
      required this.fontSize,
      required this.fontWeight,
      required this.color});
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return NeumorphicText(
      title,
      textAlign: TextAlign.justify,
      style: NeumorphicStyle(
          lightSource: LightSource.topLeft,
          shape: NeumorphicShape.convex,
          depth: 2,
          surfaceIntensity: 0.5,
          intensity: 0.8,
          color: color),
      textStyle:
          NeumorphicTextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
