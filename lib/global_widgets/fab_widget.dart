import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class FABWidget extends StatelessWidget {
  const FABWidget({super.key, required this.icon, required this.press});
  final IconData icon;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return NeumorphicFloatingActionButton(
        style: const NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            intensity: 1,
            depth: 20,
            surfaceIntensity: 1,
            color: Colors.indigoAccent,
            shadowLightColor: Colors.transparent,
            shape: NeumorphicShape.convex),
        onPressed: press,
        child: Icon(
          icon,
          color: Colors.white,
        ));
  }
}
