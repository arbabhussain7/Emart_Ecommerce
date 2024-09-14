import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/widget_common/bg_widget.dart';
import 'package:emart_app/widget_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;
  CategoryDetail({super.key, this.title});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(Scaffold(
        appBar: AppBar(title: title!.text.fontFamily(bold).white.make()),
        body: StreamBuilder(
            stream: FirestoreServices.getProducts(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicatior(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: "No product found".text.color(darkFontGrey).make());
              } else {
                var data = snapshot.data!.docs;
                return Container(
                  padding: EdgeInsets.all(13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                              controller.subcat.length,
                              (index) => "${controller.subcat[index]}"
                                  .text
                                  .size(12)
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .makeCentered()
                                  .box
                                  .rounded
                                  .size(120, 60)
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .white
                                  .make()),
                        ),
                      ),
                      20.heightBox,
                      Expanded(
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 250,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 200,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                    "${data[index]['p_name']}"
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .make(),
                                    10.heightBox,
                                    "\$${data[index]['p_price']}"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make()
                                  ],
                                )
                                    .box
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .padding(EdgeInsets.all(12))
                                    .white
                                    .outerShadowSm
                                    .roundedSM
                                    .make()
                                    .onTap(() {
                                  controller.checkIfFav(data[index]);
                                  Get.to(() => ItemDetails(
                                        title: "${data[index]["p_name"]}",
                                        data: data[index],
                                      ));
                                });
                              }))
                    ],
                  ),
                );
              }
            })));
  }
}
