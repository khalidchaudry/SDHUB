import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../view/views.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget(
      {super.key,
      required this.title,
      required this.press,
      required this.check,
      required this.action});
  final String title;
  final bool check;
  final List<Widget> action;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
        themeMode: ThemeMode.light,
        theme: const NeumorphicThemeData(
          baseColor: Colors.indigoAccent,
          accentColor: Colors.indigoAccent,
          lightSource: LightSource.topLeft,
          depth: 20,
          intensity: 1,
          buttonStyle: NeumorphicStyle(
              depth: 20,
              intensity: 1,
              surfaceIntensity: 1,
              boxShape: NeumorphicBoxShape.circle()),
          boxShape: NeumorphicBoxShape.circle(),
        ),
        child: NeumorphicAppBar(
            centerTitle: true,
            color: Colors.indigoAccent,
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: action,
            leading: check == false
                ? const SizedBox()
                : FABWidget(
                    icon: Icons.arrow_back,
                    press: press,
                  )));
  }
}
