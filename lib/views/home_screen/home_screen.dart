import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/views/home_screen/components/features_button.dart';
import 'package:emart_app/widget_common/home_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            height: 60,
            alignment: Alignment.center,
            color: lightGrey,
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                          itemCount: slidersList.length,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            );
                          })
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .margin(EdgeInsets.symmetric(horizontal: 18))
                      .make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => HomeButton(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 2.5,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todaydeal : flashsale)),
                  ),
                  10.heightBox,
                  VxSwiper.builder(
                          itemCount: slidersList.length,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              secondSlidersList[index],
                              fit: BoxFit.fill,
                            );
                          })
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .margin(EdgeInsets.symmetric(horizontal: 8))
                      .make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => HomeButton(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? topcategories
                                : index == 1
                                    ? brand
                                    : topsellers)),
                  ),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featurecategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  FeatureButton(
                                      icon: featuresImages1[index],
                                      title: featureTitle1[index]),
                                  10.heightBox,
                                  FeatureButton(
                                      icon: featuresImages2[index],
                                      title: featureTitle2[index])
                                ],
                              )).toList(),
                    ),
                  ),
                  //feature Product
                  20.heightBox,
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuresProduct.text.white
                            .fontFamily(bold)
                            .size(18)
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
                        )
                      ],
                    ),
                  ),
                  // Third Swiper ....
                  20.heightBox,
                  VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: secondSlidersList.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              secondSlidersList[index],
                              fit: BoxFit.fill,
                            );
                          })
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .margin(EdgeInsets.symmetric(horizontal: 8))
                      .make(),

                  // All Products Section ....
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 300),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgP5,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            Spacer(),
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
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .padding(EdgeInsets.all(12))
                            .white
                            .roundedSM
                            .make();
                      })
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
