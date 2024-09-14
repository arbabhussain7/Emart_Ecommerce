import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/images.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widget_common/bg_widget.dart';
import 'package:emart_app/widget_common/custom_textfield.dart';
import 'package:emart_app/widget_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              OurButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              Divider(),
              20.heightBox,
              CustomTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false),
              CustomTextField(
                  controller: controller.oldPassController,
                  hint: passwordHint,
                  title: oldPass,
                  isPass: true),
              20.heightBox,
              CustomTextField(
                  controller: controller.newPassController,
                  hint: passwordHint,
                  title: newPass,
                  isPass: true),
              20.heightBox,
              controller.isLoading(false)
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: OurButton(
                          color: redColor,
                          onPress: () async {
                            controller.isLoading(true);

                            // if image is not selected
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            // if password not match in old password

                            if (data['password'] ==
                                controller.oldPassController.text) {
                              await controller.changeAuthPassword(
                                  email: data["email"],
                                  password: controller.oldPassController.text,
                                  newPassword:
                                      controller.newPassController.text);

                              await controller.uploadProfileImage();
                              await controller.updateProfile(
                                  imageUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: controller.newPassController.text);
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context,
                                  msg: "Password con't match");
                              controller.isLoading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .shadowSm
              .white
              .padding(EdgeInsets.all(16))
              .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
