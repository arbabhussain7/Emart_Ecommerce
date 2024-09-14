import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widget_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  final dynamic data;
  ItemDetails({super.key, required this.title, this.data});
  final List<Color> listOfColors = [
    blueColor,
    pinkColor,
    orangeColor,
    blackColor
  ];
  @override
  Widget build(BuildContext context) {
    int colorsSize = 0;
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValue();
        return true;
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: lightGrey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                controller.resetValue();
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id);
                    controller.isFav(false);
                  } else {
                    controller.addToWishlist(data.id);
                    controller.isFav(true);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          itemCount: data["p_imgs"].length,
                          height: 350,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_imgs"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      title!.text
                          .size(18)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data["p_rating"]),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "\$${data["p_price"]}"
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(10)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Seller".text.white.make(),
                              5.heightBox,
                              "In House Brand"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(16)
                                  .make()
                            ],
                          )),
                          CircleAvatar(
                            backgroundColor: whiteColor,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(() => ChatScreen(), arguments: [
                              data['p_seller'],
                              data['vendor_id']
                            ]);
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      10.heightBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            data["p_colors"].length,
                            (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Color",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: blackColor),
                                          ),
                                          SizedBox(
                                            height: 24,
                                            width: 250,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 4,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    colorsSize = index;
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 12),
                                                    padding: EdgeInsets.all(2),
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: colorsSize ==
                                                                  index
                                                              ? listOfColors[
                                                                  index]
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                        shape: BoxShape.circle),
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                          color: listOfColors[
                                                              index],
                                                          shape:
                                                              BoxShape.circle),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(
                                                  width: 12,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    VxBox()
                                        .size(10, 10)
                                        .roundedFull
                                        // .color(Color(int.parse(
                                        //         data["p_colors"][index]))
                                        //     .withOpacity(2.0))
                                        .margin(
                                            EdgeInsets.symmetric(horizontal: 4))
                                        .make(),
                                  ],
                                )),
                      )
                          .box
                          .padding(EdgeInsets.all(8))
                          .make()
                          .box
                          .white
                          .shadowSm
                          .make(),
                      // Quality Row

                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Quality".text.color(textfieldGrey).make(),
                          ),
                          Obx(
                            () => Row(children: [
                              IconButton(
                                onPressed: () {
                                  controller.decreaseQuality();
                                  controller.calculateTotalPrice(
                                      int.parse(data["p_price"]));
                                },
                                icon: Icon(Icons.remove),
                              ),
                              controller.quantity.value.text
                                  .size(16)
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .make(),
                              IconButton(
                                onPressed: () {
                                  controller.increaseQuality(
                                      int.parse(data["p_quantity"]));
                                  controller.calculateTotalPrice(
                                      int.parse(data["p_price"]));
                                },
                                icon: Icon(Icons.add),
                              ),
                              10.widthBox,
                              "(${data["p_quantity"]} available)"
                                  .text
                                  .color(textfieldGrey)
                                  .make()
                            ]),
                          )
                        ],
                      ).box.padding(EdgeInsets.all(8)).make(),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Total".text.color(textfieldGrey).make(),
                          ),
                          "\$${controller.totalPrice.value}"
                              .text
                              .color(redColor)
                              .size(16)
                              .fontFamily(bold)
                              .make()
                        ],
                      ).box.padding(EdgeInsets.all(8)).make(),
                      Divider(),
                      //Decription Section....
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      "${data["p_desc"]}".text.color(darkFontGrey).make(),
                      // button section ...

                      10.heightBox,
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemDetailButtonList.length,
                            (index) => ListTile(
                                  title: itemDetailButtonList[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: Icon(Icons.arrow_forward),
                                )),
                      ),
                      20.heightBox,

                      // product to like
                      productsYouMayLike.text
                          .fontFamily(bold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop 4GB/64GB"
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(semibold)
                                          .make(),
                                      10.heightBox,
                                      "\$500"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .roundedSM
                                      .margin(EdgeInsets.all(4))
                                      .padding(EdgeInsets.all(8))
                                      .make()),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: OurButton(
                            color: redColor,
                            onPress: () {
                              controller.addToCart(
                                  img: data['p_imgs'][0],
                                  qty: controller.quantity.value,
                                  sellername: data["p_seller"],
                                  title: data["p_name"],
                                  tprice: controller.totalPrice.value);
                            },
                            textColor: whiteColor,
                            title: "Add to cart"),
                      ),
                    ],
                  ).box.white.shadowSm.make(),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
