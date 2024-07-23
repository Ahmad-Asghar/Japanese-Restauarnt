import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:japenese_resturant/common/widgets/app_text_widget.dart';
import 'package:japenese_resturant/controller/design_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/app_colors.dart';
import '../controller/animations_controller.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   DesignController ctrl= Get.put(DesignController());
   HomeAnimationController homectrl= Get.put(HomeAnimationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAnimationController>(
        builder: (homeAnimationController) {
        return GetBuilder<DesignController>(
            builder: (designController) {
            return  Column(
              children: [
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child:
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Row(
                        children: [
                          CustomTextWidget(title: "San Fransisco",fontSize: 5.5.w,fontWeight: FontWeight.w600),
                          Icon(Icons.keyboard_arrow_down_rounded,size: 8.w,)
                        ],
                      ),
                      FadeInRight(
                        from: 300,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              if (!homeAnimationController.isSearchingFood.value) {
                                homeAnimationController.toggleSearch();
                              }
                            },
                            child: AnimatedContainer(
                              curve: Curves.easeIn,
                              width: homeAnimationController.isSearchingFood.value
                                  ? MediaQuery.sizeOf(context).width - 8.w
                                  : 6.4.h,
                              height: 6.4.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: homeAnimationController.isSearchingFood.value
                                      ? AppColors.primaryColor
                                      : AppColors.secondaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                color: homeAnimationController.isSearchingFood.value
                                    ? AppColors.whiteColor
                                    : AppColors.secondaryColor,
                              ),
                              duration: const Duration(seconds: 1),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: homeAnimationController.isSearchingFood.value
                                      ? 3.w
                                      : 3.w,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: 6.w,
                                      color: homeAnimationController.showSearchCancel.value
                                          ? AppColors.primaryColor
                                          : AppColors.whiteColor,
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: TextFormField(
                                        showCursor: homeAnimationController.showSearchCancel.value,
                                        readOnly: !homeAnimationController.isSearchingFood.value,
                                        style: GoogleFonts.poppins(
                                          fontSize: 4.3.w,
                                          color: AppColors.secondaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Ahmad what's craving today!",
                                          hintStyle: GoogleFonts.poppins(
                                            fontSize: 4.1.w,
                                            color: AppColors.greyTextColor.withOpacity(0.7),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          contentPadding: EdgeInsets.only(
                                            bottom:5,
                                            left: 2.w,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    homeAnimationController.showSearchCancel.value
                                        ? Expanded(
                                      flex: 2,
                                      child: IconButton(
                                        onPressed: () {
                                          homeAnimationController.toggleSearch();
                                        },

                                        icon: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Lottie.asset('assets/images/json/cross.json',repeat: false,),
                                        ),
                                      ),
                                    )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.8.h),
                SizedBox(
                  height: 6.h,
                  child: ListView.builder(
                      padding: EdgeInsets.only(left: 4.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: designController.foodTypes.length,
                      itemBuilder: (BuildContext context,int index){
                        return Padding(
                          padding:  EdgeInsets.only(right: 2.3.w),
                          child: InkWell(
                            onTap: (){
                              designController.selectFoodType(index);
                              if(index==0){
                                designController.scrollToIndex(index);
                              }else{
                                designController.scrollToIndex(index-1);
                              }
                            },
                            borderRadius: BorderRadius.circular(25),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 900),
                              decoration: BoxDecoration(
                                  color:designController.selectedFoodType.value==index?AppColors.primaryColor: AppColors.greyTileColor,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 3.5.w),
                                child: Center(
                                    child: CustomTextWidget(
                                      title: designController.foodTypes[index],
                                      fontSize: 4.4.w,
                                      color:designController.selectedFoodType.value==index?AppColors.whiteColor: AppColors.greyTextColor,
                                      fontWeight: designController.selectedFoodType.value==index?FontWeight.w600:FontWeight.w500,
                                    )
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  height: 62.h,
                  child: ListView.builder(
                      controller: designController.scrollController,
                      padding: EdgeInsets.only(left: 4.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: designController.foodItems.length,
                      itemBuilder: (BuildContext context,int index){
                        double offset = 0;
                        final itemOffset = index * 150.0;
                        final scrollOffset = designController.offset.value;
                        offset = (scrollOffset - itemOffset) / 150.0;
                        final angle = (offset * 0.5).clamp(-1, 1) * pi;
                        return Padding(
                          padding:  EdgeInsets.only(right: 2.w),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 11.h,),
                                  Expanded(
                                    child: Container(
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage('assets/images/png/back2.png'),
                                          ),
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 4.w,right: 4.w),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.secondaryColor,
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                              height: 3.7.h,
                                              width: 18.w,
                                              child: Center(
                                                child: CustomTextWidget(
                                                  title: 'New',
                                                  color: AppColors.whiteColor,
                                                  fontSize: 4.6.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 1.5.h,),
                                            CustomTextWidget(
                                              textAlign: TextAlign.start,
                                              title: designController.foodItems[index].description,
                                              fontSize:8.w,
                                              color:AppColors.whiteColor,
                                            ),
                                            SizedBox(height: 2.h,),
                                            GestureDetector(
                                              onTap: (){
                                                if(designController.foodItems[index].count==0){
                                                  designController.updateCount(index, designController.foodItems[index].count+1);
                                                }
                                              },
                                              child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 1000),
                                                  decoration: BoxDecoration(
                                                      color:designController.foodItems[index].count==0? AppColors.whiteColor:AppColors.secondaryColor,
                                                      borderRadius: BorderRadius.circular(25)
                                                  ),
                                                  height: 5.3.h,
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      designController.foodItems[index].count==0?const SizedBox(): IconButton(
                                                        onPressed: () {
                                                          designController.updateCount(index, designController.foodItems[index].count-1);
                                                        },
                                                        icon: CircleAvatar(
                                                            backgroundColor: AppColors.whiteColor,
                                                            child: Icon(Icons.remove, size: 5.w,color: AppColors.blackColor,)),
                                                      ),
                                                      Row(
                                                        children: [
                                                          designController.foodItems[index].count==0?
                                                          CustomTextWidget(title: "¥",
                                                              fontWeight: FontWeight.w600,
                                                              color: designController.foodItems[index].count==0?AppColors.blackColor: AppColors.secondaryColor,
                                                              fontSize: 5.3.w):const SizedBox(),
                                                          AnimatedFlipCounter(
                                                            textStyle: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w600,
                                                                color: designController.foodItems[index].count==0?AppColors.blackColor: AppColors.whiteColor,
                                                                fontSize: 5.3.w),
                                                            duration: const Duration(milliseconds: 600),
                                                            value: designController.foodItems[index].count==0?designController.foodItems[index].price:designController.foodItems[index].count,
                                                          ),
                                                        ],
                                                      ),
                                                      designController.foodItems[index].count==0?const SizedBox():
                                                      IconButton(
                                                        onPressed: () {
                                                          designController.updateCount(index, designController.foodItems[index].count+1);
                                                        },
                                                        icon: CircleAvatar(
                                                            backgroundColor: AppColors.whiteColor,
                                                            child: Icon(Icons.add, size: 5.w,color: AppColors.blackColor,)),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                            SizedBox(height: 2.h,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.lightSecondaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  width: 53.w,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: const Offset(0, -5),
                                          ),
                                        ],
                                      ),
                                      child: Transform.rotate(
                                        angle:angle,
                                        child: Image(
                                          image: AssetImage(
                                            designController.foodItems[index].image,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )

                        ],
                          ),
                        );
                      }
                  ),
                ),
                // Padding(
                //   padding:  EdgeInsets.only(top: 5,right: 15.w,left: 15.w),
                //   child: Image(image: AssetImage('assets/images/png/chopstick2.png')),
                // )


              ],
            );
          }
        );
      }
    );
  }
}




class CircularCropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Create a path for the circular shape
    path.addArc(
      Rect.fromCircle(center: center, radius: radius),
      1.1,
      1.3 * 3.14,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
