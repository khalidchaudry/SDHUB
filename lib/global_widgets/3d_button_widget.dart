import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.press, required this.title});
  final Function() press;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: NeumorphicButton(
        style: const NeumorphicStyle(
            intensity: .6,
            surfaceIntensity: .3,
            depth: 20,
            shape: NeumorphicShape.convex),
        onPressed: press,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
