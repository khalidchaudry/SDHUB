import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../views.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.number});
  final String number;
  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();
    const focusedBorderColor = Colors.green;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Colors.purple;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
    );

    return GetBuilder<CreateController>(
        init: CreateController(),
        builder: (snapshot) {
          return Scaffold(
            body: SafeArea(
                child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .1,
                    ),
                    Image.asset(
                      Images.verify,
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    TextWidget(
                        title:
                            'We sent an OTP to your $number, you can check your inbox',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Pinput(
                      controller: pinController,
                      focusNode: focusNode,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      validator: (value) {
                        return value == pinController.text
                            ? null
                            : 'incorrect Pin';
                      },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) => snapshot.signInWithPhoneNumber(
                          otpController: pinController.text),
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      length: 6,
                      onSubmitted: (value) => snapshot.signInWithPhoneNumber(
                          otpController: pinController.text),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Didn't receive code?",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        TextButton(
                            onPressed: () => snapshot.verifyPhoneNumber(
                                phoneController:
                                    snapshot.numberController.text.toString(),
                                countryCode: snapshot.countryCode.toString()),
                            child: const Text(
                              'Resend',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: size.height * .09,
                    ),
                    ContainerWidget(
                        color: NeumorphicColors.background,
                        width: 90,
                        height: 90,
                        borderRadius: 100,
                        neumorphicBoxShape: const NeumorphicBoxShape.circle(),
                        child: TextButton(
                            onPressed: () {
                              if (pinController.text.isNotEmpty) {
                                focusNode.unfocus();
                                formKey.currentState!.validate();
                                snapshot.signInWithPhoneNumber(
                                    otpController: pinController.text);
                              }
                            },
                            child: NeumorphicIcon(
                              Icons.arrow_forward,
                              size: 30,
                              style: const NeumorphicStyle(
                                color: Colors.black,
                              ),
                            ))),
                  ],
                ),
              ),
            )),
          );
        });
  }
}
