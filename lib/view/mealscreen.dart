import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroidmedic/controller/mealcontroller.dart';
import 'package:iroidmedic/core/color.dart';
import 'package:iroidmedic/main.dart';

class Mealscreen extends StatelessWidget {
  const Mealscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MealController());
    return Scaffold(
      backgroundColor: Colorsdata.bgcolor,
      body: Center(
        child: Column(
          children: [
            _widgetappbar(),
            _widgetlogo(controller: controller),
            SizedBox(
              height: MyApp.h * .02,
            ),
            CircleAvatar(
              backgroundColor: Colorsdata.maincolor,
              radius: MyApp.h * .008,
            ),
            SizedBox(
              height: MyApp.h * .02,
            ),
            _widgetmainlist(controller: controller),
          ],
        ),
      ),
    );
  }

  _widgetappbar() {
    return Container(
      height: MyApp.h * .15,
      width: MyApp.w,
      decoration: BoxDecoration(color: Colorsdata.maincolor),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: MyApp.h * .02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Text(
                "PROTEINIUM",
                style:
                    TextStyle(color: Colorsdata.textwhitecolor, fontSize: 20),
              ),
              Spacer(),
              Icon(
                Icons.notifications,
                color: Colorsdata.textwhitecolor,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  _widgetlogo({required MealController controller}) {
    return Obx(
      () => Container(
        width: MyApp.w,
        height: MyApp.h * .2,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: controller.dataloading.value
                    ? AssetImage("assets/images/bgimg.jpeg")
                    : NetworkImage(
                        "${controller.mealmodel?.data.banners[0].image}"))),
        child: controller.dataloading.value
            ? Center(
                child: Image.asset(
                    height: MyApp.h * .2,
                    width: MyApp.w * .5,
                    "assets/images/logo.png"),
              )
            : SizedBox.shrink(),
      ),
    );
  }

  _widgetmainlist({required MealController controller}) {
    return Expanded(
      child: Obx(
        () => controller.dataloading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Colorsdata.maincolor,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    controller.mealmodel?.data.mealCategories.length ?? 0,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MyApp.h * .02, horizontal: MyApp.w * .05),
                      child: Obx(() {
                        bool isExpanded =
                            controller.expandedIndexes.contains(index);
                        return Stack(
                          children: [
                            if (isExpanded)
                              Padding(
                                padding: EdgeInsets.only(top: MyApp.h * .12),
                                child: Container(
                                  width: MyApp.w,
                                  padding: EdgeInsets.all(MyApp.h * .02),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(MyApp.h * .01),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colorsdata.containershadow,
                                          blurRadius: 5,
                                          offset: Offset(0, 3))
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: MyApp.h * .02,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller.mealmodel?.data.mealCategories[index].mealPlans?.length??0,
                                        itemBuilder: (context, dindex) =>
                                            _buildMealRow(
                                                "${controller.mealmodel?.data.mealCategories[index].mealPlans?[dindex].name}",
                                                "${controller.mealmodel?.data.mealCategories[index].mealPlans?[dindex].shortDescription}"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: MyApp.w,
                              height: MyApp.h * .18,
                              child: Stack(
                                children: [
                                  Container(
                                    height: MyApp.h * .15,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colorsdata.containershadow,
                                              blurRadius: 5,
                                              offset: Offset(0, 5))
                                        ],
                                        borderRadius: BorderRadius.circular(
                                            MyApp.h * .01),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${controller.mealmodel?.data.mealCategories[index].image}"))),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: MyApp.h * .05,
                                        width: MyApp.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  MyApp.h * .01),
                                              bottomLeft: Radius.circular(
                                                  MyApp.h * .01)),
                                          color: Colorsdata.containerblack,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(MyApp.h * .01),
                                          child: Text(
                                            "${controller.mealmodel?.data.mealCategories[index].name}",
                                            style: TextStyle(
                                                color:
                                                    Colorsdata.textwhitecolor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: MyApp.h * .01,
                                    right: MyApp.w * .06,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isExpanded) {
                                          controller.expandedIndexes
                                              .remove(index);
                                        } else {
                                          controller.expandedIndexes.add(index);
                                        }
                                      },
                                      child: Container(
                                        height: MyApp.h * .05,
                                        width: MyApp.h * .05,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colorsdata.textwhitecolor,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colorsdata
                                                      .containershadow,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 5))
                                            ]),
                                        child: Icon(isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    )),
      ),
    );
  }

  Widget _buildMealRow(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MyApp.h * .005),
      child: Row(
        children: [
          Icon(Icons.restaurant_menu, color: Colorsdata.maincolor),
          SizedBox(width: MyApp.w * .03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
