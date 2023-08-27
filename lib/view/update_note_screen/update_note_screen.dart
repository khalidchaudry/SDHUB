import 'package:get/get.dart';
import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../views.dart';

class UpdateNotesScreen extends StatelessWidget {
  const UpdateNotesScreen(
      {super.key, required this.title, required this.desc, required this.id});
  final String title, desc, id;
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: GetBuilder<UpdateNotesController>(
          init: UpdateNotesController(),
          builder: (snapshot) {
            snapshot.titleController.text = title;
            snapshot.descController.text = desc;
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                  preferredSize: const Size(double.infinity, 80),
                  child: AppbarWidget(
                    action: const [],
                    check: true,
                    title: 'Update Notes',
                    press: () => Get.back(),
                  )),
              body: SafeArea(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                      textInputAction: TextInputAction.next,
                      prefixBool: true,
                      prefix: snapshot.checkTitle == false
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
                                      child: NeumorphicIcon(
                                    Icons.edit,
                                    style: const NeumorphicStyle(
                                        color: Colors.red),
                                  ))),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                onTap: () async {},
                                child: ContainerWidget(
                                    color: NeumorphicColors.embossMaxWhiteColor,
                                    width: size.width * .15,
                                    height: size.height * .1,
                                    borderRadius: 50,
                                    neumorphicBoxShape:
                                        const NeumorphicBoxShape.circle(),
                                    child: Center(
                                      child: NeumorphicIcon(
                                        Icons.edit,
                                        style: const NeumorphicStyle(
                                            color: Colors.green),
                                      ),
                                    )),
                              ),
                            ),
                      textInputType: TextInputType.phone,
                      hintText: 'Write title here',
                      press: () => snapshot.updateTitleValue(),
                      controller: snapshot.titleController,
                      check: snapshot.checkTitle,
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    NeumorphismButtonWidget(
                      press: () {},
                      isCheck: snapshot.checkDesc,
                      color: NeumorphicColors.background,
                      width: size.width,
                      height: 300,
                      radius: 10,
                      child: TextField(
                        onTap: () => snapshot.updateDescValue(),
                        maxLength: 300,
                        maxLines: 10,
                        controller: snapshot.descController,
                        cursorColor: snapshot.checkDesc == false
                            ? Colors.red
                            : Colors.green,
                        cursorWidth: 2,
                        decoration: InputDecoration(
                            fillColor: NeumorphicColors.background,
                            border: InputBorder.none,
                            filled: true,
                            hintText: 'Write description...',
                            hintStyle: TextStyle(
                                color: snapshot.checkDesc == false
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .1,
                    ),
                    snapshot.loading == false
                        ? NeumorphismButtonWidget(
                            press: () {
                              snapshot.loader();
                              snapshot.updateNotes(context: context, id: id);
                            },
                            color: NeumorphicColors.background,
                            width: double.infinity,
                            height: 60,
                            radius: 10,
                            isCheck: false,
                            child: const TextWidget(
                                title: 'UPDATE',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                        : NeumorphismButtonWidget(
                            press: () {},
                            color: NeumorphicColors.background,
                            width: double.infinity,
                            height: 60,
                            radius: 10,
                            isCheck: false,
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.indigoAccent,
                              ),
                            ))
                  ],
                ),
              )),
            );
          }),
    );
  }
}
