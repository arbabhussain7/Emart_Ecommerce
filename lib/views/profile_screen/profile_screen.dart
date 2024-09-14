import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/images.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/consts/strings.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/profile_screen/components/detail_cart.dart';
import 'package:emart_app/views/profile_screen/edit_profile_screen.dart';

import 'package:emart_app/widget_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ).onTap(() {
                        controller.nameController.text = data["name"];
                        Get.to(() => EditProfileScreen(
                              data: data,
                            ));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        data['imageUrl'] == ''
                            ? Image.asset(
                                imgProfile2,
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageUrl'],
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(bold)
                                .white
                                .make(),
                            5.heightBox,
                            "${data["email"]}".text.white.make()
                          ],
                        )),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: whiteColor)),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => LoginScreen());
                            },
                            child:
                                logout.text.white.fontFamily(semibold).make()),
                      ]),
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DetailCarts(
                            count: data["cart_count"],
                            title: "in your cart",
                            width: context.screenWidth / 3.4),
                        DetailCarts(
                            count: data["wishlist_count"],
                            title: "in your wishlist",
                            width: context.screenWidth / 3.4),
                        DetailCarts(
                            count: data["order_count"],
                            title: "your orders",
                            width: context.screenWidth / 3.4)
                      ],
                    ),

                    //Button Sections
                    ListView.separated(
                      itemCount: profileButtonList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: profileButtonList[index]
                              .text
                              .fontFamily(bold)
                              .color(darkFontGrey)
                              .make(),
                          leading: Image.asset(
                            profileButtonIcon[index],
                            width: 22,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: lightGrey,
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .margin(EdgeInsets.all(12))
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .shadowSm
                        .make()
                        .box
                        .color(redColor)
                        .make()
                  ],
                ),
              );
            }
          }),
    ));
  }
}
