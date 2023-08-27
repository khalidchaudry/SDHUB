import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../utils/utils.dart';
import '../view/views.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefix,
    required this.prefixBool,
    required this.press,
    required this.check,
    required this.textInputType,
    required this.textInputAction,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool prefixBool, check;
  final Widget prefix;
  final TextInputAction textInputAction;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return NeumorphismButtonWidget(
      press: () {},
      isCheck: check,
      color: NeumorphicColors.background,
      width: size.width,
      height: 65,
      radius: 10,
      child: TextField(
        onTap: press,
        controller: controller,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        cursorColor: check == false ? Colors.red : Colors.green,
        cursorWidth: 2,
        decoration: InputDecoration(
            fillColor: NeumorphicColors.background,
            border: InputBorder.none,
            filled: check,
            prefixIcon: prefixBool == true ? prefix : const SizedBox(),
            hintText: hintText,
            hintStyle: TextStyle(
                color: check == false ? Colors.red : Colors.green,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
