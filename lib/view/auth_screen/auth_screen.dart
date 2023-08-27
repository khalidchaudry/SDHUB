import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:get/get.dart';
import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../views.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const countryPicker = FlCountryCodePicker();
    return NeumorphicBackground(
      child: GetBuilder<CreateController>(
          init: CreateController(),
          builder: (snapshot) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Image.asset(
                      Images.logo,
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    const TextWidget(
                        title: 'SIGNIN & SIGNUP HERE',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    TextFieldWidget(
                      textInputAction: TextInputAction.done,
                      prefixBool: true,
                      prefix: snapshot.checkAuth == false
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ContainerWidget(
                                  color: NeumorphicColors.embossMaxWhiteColor,
                                  width: size.width * .15,
                                  height: size.height * .1,
                                  borderRadius: 50,
                                  neumorphicBoxShape:
                                      const NeumorphicBoxShape.circle(),
                                  child: Center(
                                    child: TextWidget(
                                        title: snapshot.countryCode,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final pickedCountry = await countryPicker
                                      .showPicker(context: context);
                                  if (pickedCountry != null) {
                                    snapshot.updateCountryInfo(
                                      code: pickedCountry.dialCode,
                                      name: pickedCountry.name.toString(),
                                    );
                                  }
                                },
                                child: ContainerWidget(
                                    color: NeumorphicColors.embossMaxWhiteColor,
                                    width: size.width * .15,
                                    height: size.height * .1,
                                    borderRadius: 50,
                                    neumorphicBoxShape:
                                        const NeumorphicBoxShape.circle(),
                                    child: Center(
                                      child: TextWidget(
                                          title: snapshot.countryCode,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    )),
                              ),
                            ),
                      textInputType: TextInputType.phone,
                      hintText: 'Enter Cell Number',
                      press: () => snapshot.updateAuthValue(),
                      controller: snapshot.numberController,
                      check: snapshot.checkAuth,
                    ),
                    SizedBox(
                      height: size.height * .12,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ContainerWidget(
                          color: NeumorphicColors.background,
                          width: 90,
                          height: 90,
                          borderRadius: 100,
                          neumorphicBoxShape: const NeumorphicBoxShape.circle(),
                          child: TextButton(
                              onPressed: () {
                                if (snapshot.numberController.text.length ==
                                    10) {
                                  Get.to(() => OTPScreen(
                                      number: snapshot.countryCode +
                                          snapshot.numberController.text));
                                  snapshot.verifyPhoneNumber(
                                      phoneController:
                                          snapshot.numberController.text,
                                      countryCode: snapshot.countryCode);
                                } else {
                                  showAlert(
                                      title: 'Warning!',
                                      message: 'Please enter a valid number');
                                }
                              },
                              child: const TextWidget(
                                  title: 'NEXT',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      NeumorphicColors.embossMaxWhiteColor))),
                      SizedBox(
                        width: size.width * .08,
                      ),
                      const TextWidget(
                          title: 'OR',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                      SizedBox(
                        width: size.width * .08,
                      ),
                      ContainerWidget(
                          color: NeumorphicColors.background,
                          width: 90,
                          height: 90,
                          borderRadius: 100,
                          neumorphicBoxShape: const NeumorphicBoxShape.circle(),
                          child: TextButton(
                              onPressed: () => snapshot.googleSigninMethod(),
                              child: Image.asset(
                                Images.google,
                                width: 60,
                                height: 60,
                              ))),
                    ])
                  ],
                ),
              )),
            );
          }),
    );
  }
}
