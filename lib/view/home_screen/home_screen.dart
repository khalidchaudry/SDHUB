import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:sdhub/controllers/home_controller.dart';
import 'package:sdhub/global_widgets/global_widgets.dart';
import 'package:sdhub/view/create_note_screen/create_note_screen.dart';
import 'package:sdhub/view/update_note_screen/update_note_screen.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 80),
                child: AppbarWidget(
                  check: false,
                  action: [
                    FABWidget(
                        icon: Icons.logout, press: () => controller.logout()),
                  ],
                  title: 'SDHUB',
                  press: () {},
                )),
            floatingActionButton: FABWidget(
                icon: Icons.add,
                press: () => Get.to(() => const CreateNotesScreen())),
            body: !controller.emailList.contains(auth.currentUser!.email)
                ? StreamBuilder(
                    stream: firestore
                        .collection('myNotes')
                        .where('uEmail', isEqualTo: auth.currentUser!.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.docs.isNotEmpty
                            ? GridView.builder(
                                padding: const EdgeInsets.all(10),
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: size.height * .15,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemBuilder: (_, index) {
                                  var data = snapshot.data!.docs[index];
                                  return NeumorphismButtonWidget(
                                      press: () {
                                        Get.back();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                backgroundColor:
                                                    Colors.indigoAccent,
                                                children: [
                                                  ButtonBar(
                                                    alignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      FABWidget(
                                                          icon: Icons.edit,
                                                          press: () {
                                                            Get.back();
                                                            Get.to(
                                                              () =>
                                                                  UpdateNotesScreen(
                                                                title: data[
                                                                    'title'],
                                                                id: data.id,
                                                                desc: data[
                                                                    'desc'],
                                                              ),
                                                            );
                                                          }),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FABWidget(
                                                          icon: CupertinoIcons
                                                              .delete,
                                                          press: () {
                                                            Get.back();
                                                            Get.defaultDialog(
                                                                middleText:
                                                                    'Sure!, you want to delete?',
                                                                onCancel: () {},
                                                                onConfirm: () =>
                                                                    controller.deleteNote(
                                                                        id: data
                                                                            .id));
                                                          }),
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      color: NeumorphicColors.background,
                                      width: double.infinity,
                                      height: size.height * .3,
                                      radius: 10,
                                      isCheck: false,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                              title: data['title'],
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          SizedBox(
                                            height: size.height * .01,
                                          ),
                                          TextWidget(
                                              title: data['desc'],
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blueGrey),
                                          SizedBox(
                                            height: size.height * .01,
                                          ),
                                          TextWidget(
                                              title: data['createDate'],
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blueGrey),
                                        ],
                                      ));
                                })
                            : Center(
                                child: Image.asset(Images.noData),
                              );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.purple,
                          ),
                        );
                      }
                    })
                : StreamBuilder(
                    stream: firestore
                        .collection('myNotes')
                        .where('uNumber',
                            isEqualTo: auth.currentUser!.phoneNumber)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.docs.isNotEmpty
                            ? GridView.builder(
                                padding: const EdgeInsets.all(10),
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemBuilder: (_, index) {
                                  var data = snapshot.data!.docs[index];
                                  return NeumorphismButtonWidget(
                                      press: () {
                                        Get.back();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                children: [
                                                  ButtonBar(
                                                    alignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      FABWidget(
                                                          icon: Icons.edit,
                                                          press: () {
                                                            Get.back();
                                                            Get.to(
                                                              () =>
                                                                  UpdateNotesScreen(
                                                                title: data[
                                                                    'title'],
                                                                id: data.id,
                                                                desc: data[
                                                                    'desc'],
                                                              ),
                                                            );
                                                          }),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FABWidget(
                                                          icon: CupertinoIcons
                                                              .delete,
                                                          press: () {
                                                            Get.back();
                                                            Get.defaultDialog(
                                                                middleText:
                                                                    'Sure!, you want to delete?',
                                                                onCancel: () {},
                                                                onConfirm: () =>
                                                                    controller.deleteNote(
                                                                        id: data
                                                                            .id));
                                                          }),
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      color: NeumorphicColors.background,
                                      width: double.infinity,
                                      height: size.height * .3,
                                      radius: 10,
                                      isCheck: false,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                              title: data['title'],
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          TextWidget(
                                              title: data['desc'],
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blueGrey),
                                          TextWidget(
                                              title: data['createDate'],
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blueGrey),
                                        ],
                                      ));
                                })
                            : Center(
                                child: Image.asset(Images.noData),
                              );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.purple,
                          ),
                        );
                      }
                    }),
          );
        });
  }
}
