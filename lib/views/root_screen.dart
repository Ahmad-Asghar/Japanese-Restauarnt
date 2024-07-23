import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:japenese_resturant/common/widgets/app_text_widget.dart';
import 'package:japenese_resturant/common/widgets/custom_main_button.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/app_colors.dart';
import '../controller/animations_controller.dart';
import '../controller/design_controller.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class RootScreen extends StatelessWidget {
   RootScreen({super.key});

   AppAnimationController ctrlr= Get.put(AppAnimationController());
   DesignController dctrlr= Get.put(DesignController());
  @override
  Widget build(BuildContext context) {

    return GetBuilder<AppAnimationController>(
      builder: (appAnimationController) {
        return GetBuilder<DesignController>(
            builder: (designController) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
             child: FadeTransition(
               opacity: appAnimationController.isIntroScreen.value ? appAnimationController.showFadeAnimation : appAnimationController.hideFadeAnimation,
               child:appAnimationController.isIntroScreen.value?
               Row(
                 children: [
                   Expanded(
                     child: Container(
                       decoration: BoxDecoration(
                         gradient: LinearGradient(
                           colors: [
                             AppColors.secondaryColor,
                             AppColors.primaryColor,
                           ],
                           begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                         ),
                         borderRadius: BorderRadius.circular(25),
                       ),
                       child: MaterialButton(
                         height: 6.5.h,
                         onPressed: () {
                           appAnimationController.toggleScreen();
                         },
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(25),
                         ),
                         child: CustomTextWidget(
                           title: 'Reserve a table',
                           fontSize: 4.7.w,
                           fontWeight: FontWeight.w600,
                           color: AppColors.whiteColor,
                         ),
                       ),
                     )

                   ),
                 ],
               ):
               Container(
                 height: 6.5.h,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(25),
                   color: AppColors.secondaryColor
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     IconButton(
                         onPressed: (){},
                         icon: Padding(
                           padding: const EdgeInsets.all(4.0),
                           child: Image(
                             color: appAnimationController.currentScreen.value==0?AppColors.primaryColor:AppColors.whiteColor,
                             image: const AssetImage('assets/images/png/noodles.png'),
                           ),
                         )
                     ),
                     IconButton(
                         onPressed: (){
                           appAnimationController.toggleScreen();
                         },
                         icon: Transform.rotate(
                           angle: 3.1,
                           child: Icon(
                             Icons.double_arrow_rounded,
                             size: 8.w,
                             color: appAnimationController.currentScreen.value==1?AppColors.primaryColor:AppColors.whiteColor,
                           ),
                         )),
                     Stack(
                       alignment: Alignment.topRight,
                       children: [
                         IconButton(
                             onPressed: (){
                               appAnimationController.currentScreen.value=2;
                               Get.to(()=> CartScreen(),
                                   transition: Transition.fadeIn,
                                   duration: const Duration(seconds: 1)
                               );
                             }, icon: Icon(Icons.shopping_cart_rounded,size: 6.w,
                           color: appAnimationController.currentScreen.value==2?AppColors.primaryColor:AppColors.whiteColor,
                         )
                         ),

                         AnimatedOpacity(
                           opacity: designController.foodItems
                               .where((item) => item.count > 0)
                               .map((item) => item.count)
                               .fold(0, (previous, current) => previous + current) == 0
                               ? 0.0
                               : 1.0,
                           duration: const Duration(seconds: 1),
                           child: Padding(
                             padding: const EdgeInsets.only(top: 5,right: 5),
                             child: CircleAvatar(
                               backgroundColor: AppColors.whiteColor,
                               radius: 10,
                               child: CircleAvatar(
                                 radius: 8,
                                 backgroundColor: AppColors.secondaryColor,
                                 child:Center(
                                   child: AnimatedFlipCounter(
                                     padding: const EdgeInsets.only(top: 4),
                                     textStyle: GoogleFonts.poppins(
                                         color: AppColors.whiteColor,
                                         fontSize: 3.w,
                                     fontWeight: FontWeight.w600
                                     ),
                                     duration: const Duration(milliseconds: 600),
                                     value:designController.foodItems
                                         .where((item) => item.count > 0)
                                         .map((item) => item.count)
                                         .fold(0, (previous, current) => previous + current),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         )
                       ],
                     ),
                     IconButton(
                         onPressed: (){},
                         icon: Icon(Icons.person_rounded,
                           size: 6.w,
                       color: appAnimationController.currentScreen.value==3?AppColors.primaryColor:AppColors.whiteColor,
                     )),
                   ],
                 ),
               ),
             ),
              ),
              body: Container(
                decoration:  const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/png/back1.png')
                  )
                ),
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: appAnimationController.controller,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            SlideTransition(
                              position: appAnimationController.rightAnimation,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(bottom:12.h,right: 8.w,left: 8.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextWidget(title: 'Best of Japan!',fontSize: 6.w,),
                                            ShaderMask(
                                              shaderCallback: (bounds) {
                                                return LinearGradient(
                                                  colors: [AppColors.primaryColor,AppColors.secondaryColor],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(bounds);
                                              },
                                              child: CustomTextWidget(
                                                title:  'Oishi Sushi',
                                                fontSize: 10.w,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                            CustomTextWidget(title: 'Mouth Watering Combination',fontSize: 4.8.w,),
                                            SizedBox(height: 1.h,),
                                            CustomTextWidget(
                                              title: 'Taste the best food of Japan!\nstraight at your house,\ndelivered within 30 mins instantly',
                                              fontSize: 4.1.w,
                                              color: AppColors.greyTextColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                    // Padding(
                                    //   padding:  EdgeInsets.only(bottom: 5.h),
                                    //   child: ShaderMask(
                                    //     shaderCallback: (bounds) {
                                    //       return LinearGradient(
                                    //         colors: [AppColors.secondaryColor,AppColors.primaryColor],
                                    //         begin: Alignment.topLeft,
                                    //         end: Alignment.bottomRight,
                                    //       ).createShader(bounds);
                                    //     },
                                    //     child: Column(
                                    //           mainAxisSize: MainAxisSize.min,
                                    //           mainAxisAlignment: MainAxisAlignment.center,
                                    //           children: "日本料理屋"
                                    //               .split('')
                                    //               .map((letter) => Text(
                                    //               letter,
                                    //               style: GoogleFonts.poppins(
                                    //                   color: AppColors.whiteColor,
                                    //                   fontSize: 17.w,
                                    //                   fontWeight: FontWeight.w600)))
                                    //               .toList(),
                                    //         ),
                                    //       ),
                                    // ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SlideTransition(
                              position: appAnimationController.leftAnimation,
                              child: SizedBox(
                                height: 70.h,
                                width: 100.w,
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal:7.w)
,                                  child: const Image(
                                    image: AssetImage('assets/images/png/sushi.png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    FadeTransition(
                      opacity: appAnimationController.hideFadeAnimation,
                      child:  HomeScreen(),
                    ),
                    //const HomeScreen(),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}
