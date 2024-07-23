import 'package:animate_do/animate_do.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:japenese_resturant/common/widgets/app_text_widget.dart';
import 'package:japenese_resturant/common/widgets/custom_main_button.dart';
import 'package:japenese_resturant/controller/animations_controller.dart';
import 'package:japenese_resturant/views/book_table_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/app_colors.dart';
import '../controller/design_controller.dart';

class CartScreen extends StatelessWidget {
   CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppAnimationController>(
      builder: (appAnimationController) {
        return GetBuilder<DesignController>(
            builder: (designController) {
              return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 designController.isOrderDelivery.value?
                 FadeInUp(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomMainButton(
                              borderRadius: 25,
                              height: 6.4.h,
                                color: AppColors.primaryColor,
                                onTap: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextWidget(
                                        title: 'Order Now ¥',
                                      fontSize: 4.5.w,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.whiteColor,
                                    ),
                                    AnimatedFlipCounter(
                                      duration: const Duration(milliseconds: 800),
                                      value: designController.foodItems.fold(0, (sum, item) => sum + (item.count * item.price)),
                                      textStyle: GoogleFonts.poppins(
                                        fontSize: 6.w,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ):
                 FadeInDown(
                   child: Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 4.w),
                     child: Row(
                       children: [
                         Expanded(
                           child: CustomMainButton(
                               borderRadius: 25,
                               height: 6.4.h,
                               color: AppColors.primaryColor,
                               onTap: (){
                                 Get.to(()=>BookTableScreen(),transition: Transition.fadeIn,duration: Duration(seconds: 1));
                               },
                               child:  CustomTextWidget(
                                 title: 'Book a Table',
                                 fontSize: 4.5.w,
                                 fontWeight: FontWeight.w600,
                                 color: AppColors.whiteColor,
                               ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                  SizedBox(height: 2.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Container(
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
                              onPressed: (){},
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
                                  onPressed: (){}, icon: Icon(Icons.shopping_cart_rounded,size: 6.w,
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
                ],
              ),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration:  BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/png/back1.png')
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.h),
                    FadeInDown(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 4.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.greyTileColor,
                          ),
                          height: 7.h,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 2.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      designController.changeDeliveryState();
                                    },
                                    child: Container(
                                      height: 5.6.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color:designController.isOrderDelivery.value? AppColors.primaryColor:Colors.transparent
                                      ),
                                      child: Center(
                                        child: CustomTextWidget(
                                          title: 'Order Delivery',
                                          color: designController.isOrderDelivery.value?AppColors.whiteColor:AppColors.greyTextColor,
                                          fontSize: 4.4.w,
                                          fontWeight:designController.isOrderDelivery.value? FontWeight.w600:FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      designController.changeDeliveryState();
                                    },
                                    child: Container(
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color:!designController.isOrderDelivery.value? AppColors.primaryColor:Colors.transparent
                                      ),
                                      child: Center(
                                        child: CustomTextWidget(
                                          title: 'In Resturant',
                                          color: !designController.isOrderDelivery.value?AppColors.whiteColor:AppColors.greyTextColor,
                                          fontSize: 4.4.w,
                                          fontWeight:!designController.isOrderDelivery.value? FontWeight.w600:FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Expanded(
                      child:  ListView.builder(
                          padding: EdgeInsets.only(left: 4.w,right: 4.w,bottom: 20.h),
                          itemCount: designController.cartItems.length,
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: FadeInRight(
                                  from: (90)+index*40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:AppColors.greyTileColor,
                                      borderRadius: BorderRadius.circular(15),

                                    ),
                                    height: 17.h,
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
                                      child: Row(
                                        children: [
                                          Image(image: AssetImage(designController.cartItems[index].image),height: 100,),
                                          SizedBox(width: 4.w,),
                                          Container(
                                            constraints: BoxConstraints(maxWidth: 50.w),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CustomTextWidget(
                                                  title: designController.cartItems[index].description.replaceAll('\n', ' '),
                                                  fontSize: 5.w,
                                                ),
                                                SizedBox(height: 1.3.h,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CustomTextWidget(title: '¥',
                                                                fontSize: 6.w,
                                                                fontWeight: FontWeight.w600),
                                                            AnimatedFlipCounter(
                                                              duration: const Duration(milliseconds: 800),
                                                              value: designController.cartItems[index].price*designController.cartItems[index].count,
                                                              textStyle: GoogleFonts.poppins(
                                                                  fontSize: 6.w,
                                                                  fontWeight: FontWeight.w600
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color:AppColors.secondaryColor,
                                                            borderRadius: BorderRadius.circular(25)
                                                        ),
                                                        height: 4.8.h,
                                                        width: 30.w,
                                                        child: Padding(
                                                          padding:  EdgeInsets.symmetric(horizontal: 2.w),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  if(designController.foodItems[index].count!=1){
                                                                    designController.updateCount(index, designController.foodItems[index].count-1);
                                                                  }
                                                                },
                                                                child: CircleAvatar(
                                                                    radius: 12,
                                                                    backgroundColor: AppColors.whiteColor,
                                                                    child: Icon(Icons.remove, size: 5.w,color: AppColors.blackColor,)),
                                                              ),
                                                              AnimatedFlipCounter(
                                                                textStyle: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w600,
                                                                    color:  AppColors.whiteColor,
                                                                    fontSize: 5.w),
                                                                duration: const Duration(milliseconds: 800),
                                                                value: designController.cartItems[index].count,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  designController.updateCount(index, designController.foodItems[index].count+1);
                                                                },
                                                                child: CircleAvatar(
                                                                    radius: 12,
                                                                    backgroundColor: AppColors.whiteColor,
                                                                    child: Icon(Icons.add, size: 5.w,color: AppColors.blackColor)
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            );
                          }
                      ),
                    )
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
