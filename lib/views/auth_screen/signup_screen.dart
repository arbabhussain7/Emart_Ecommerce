import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/widget_common/applogo_widget.dart';
import 'package:emart_app/widget_common/bg_widget.dart';
import 'package:emart_app/widget_common/custom_textfield.dart';
import 'package:emart_app/widget_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isChecked = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  CustomTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  CustomTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  CustomTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: true),
                  CustomTextField(
                      hint: passwordHint,
                      title: retypePassword,
                      controller: passwordRetypeController,
                      isPass: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPass.text.make()),
                  ),

                  // OurButton().box.width(context.screenWidth - 50).make()

                  Row(
                    children: [
                      Checkbox(
                          checkColor: redColor,
                          value: isChecked,
                          onChanged: (newValue) {
                            setState(() {
                              isChecked = newValue;
                            });
                          }),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "i agree to the",
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: termAndCond,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: privacyPolicy,
                              style:
                                  TextStyle(fontFamily: bold, color: redColor))
                        ])),
                      ),
                    ],
                  ),
                  5.heightBox,
                  controller.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : OurButton(
                          color: isChecked == true ? redColor : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isChecked != false) {
                              try {
                                controller.isLoading(true);
                                await controller
                                    .signUpMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then(
                                  (value) {
                                    return controller.storeUserData(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  },
                                ).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => LoginScreen());
                                });
                              } catch (e) {
                                auth.signOut();
                                controller.isLoading(false);
                                VxToast.show(context, msg: e.toString());
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: alreadyHaveAccount,
                        style: TextStyle(
                          fontFamily: regular,
                          color: fontGrey,
                        )),
                    TextSpan(
                        text: "&",
                        style: TextStyle(
                          fontFamily: regular,
                          color: fontGrey,
                        )),
                    TextSpan(
                        text: login,
                        style: TextStyle(
                          fontFamily: regular,
                          color: redColor,
                        )),
                  ])).onTap(() {
                    Get.back();
                  })
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
