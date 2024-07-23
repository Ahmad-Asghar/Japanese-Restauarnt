import 'package:animate_do/animate_do.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:japenese_resturant/common/widgets/app_text_widget.dart';
import 'package:japenese_resturant/views/home_screen.dart';
import 'package:japenese_resturant/views/root_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/app_colors.dart';
import '../common/widgets/custom_main_button.dart';
import '../controller/design_controller.dart';

class BookTableScreen extends StatelessWidget {
  const BookTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DesignController>(
      builder: (designController) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: FadeInUp(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.greyTextColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4)
                        ),
                        height: 2.5.h,
                        width: 2.5.h,
                      ),
                      const SizedBox(width: 5),
                      CustomTextWidget(title: "Reserved"),
                      const SizedBox(width: 7),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff88bdad),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        height: 2.5.h,
                        width: 2.5.h,
                      ),
                      const SizedBox(width: 5),
                      CustomTextWidget(title: "Available"),
                      const SizedBox(width: 7),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        height: 2.5.h,
                        width: 2.5.h,
                      ),
                      const SizedBox(width: 5),
                      CustomTextWidget(title: "My Reservation"),
              
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  Row(
                    children: [
                      Expanded(
                        child: CustomMainButton(
                            borderRadius: 25,
                            height: 6.4.h,
                            color: AppColors.primaryColor,
                            onTap: (){
                              confirmBookDialogue(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextWidget(
                                  title: 'Reserve',
                                  fontSize: 5.w,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColor,
                                ),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration:  const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/png/back1.png')
                )
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeInRight(
                        from: 200,
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 6.h,
                            width: 6.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryColor
                            ),
                            child: Icon(Icons.arrow_back_rounded,color: AppColors.whiteColor,),
                          ),
                        ),
                      ),
                      FadeInRight(
                        from: 200,
                        child: CustomTextWidget(
                          title: 'Book Table',
                          color: AppColors.secondaryColor,
                          fontSize: 5.6.w,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10.w,)
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: designController.reservationTables.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:  3,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 15
                        ),
                        itemBuilder: (BuildContext context,int index){
                          return FadeInLeft(
                            from:  (70)+index*40,
                            child: GestureDetector(
                              onTap: () => designController.reserveTable(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 800),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image(
                                      image:  const AssetImage('assets/images/png/table.png'),
                                      color: designController.reservationTables[index].booked==true&&
                                          designController.reservationTables[index].bookedByMe==true? AppColors.primaryColor:
                                      designController.reservationTables[index].booked==false?const Color(0xff88bdad).withOpacity(0.7):
                                      AppColors.greyTextColor.withOpacity(0.5),
                                    ),
                                    CustomTextWidget(title: (index+1).toString(),color: AppColors.whiteColor,fontWeight: FontWeight.bold,fontSize: 4.6.w,)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        ),
                  )
                ],


              ),
            ),
          ),
        );
      }
    );
  }
}



void confirmBookDialogue(BuildContext context){
  RxInt noOfGuests = 1.obs;
  RxInt selectedDate = 10.obs;
  RxInt selectedTime = 20.obs;
  showModalBottomSheet(
      context: context, builder: (context){

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
        image: DecorationImage(
          image: AssetImage('assets/images/png/back1.png'),
            fit: BoxFit.cover
        )
      ),
      height: 50.h,
      width: double.infinity,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h,),
            FadeInRight(from :100,child: CustomTextWidget(title: "No. of Guests",fontWeight: FontWeight.w600,fontSize: 5.5.w,)),
            SizedBox(height: 1.h,),
            FadeInRight(
              from :150,
              child: Container(
                  decoration: BoxDecoration(
                      color:AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  height: 4.8.h,
                  width: 40.w,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                           if(noOfGuests.value!=1){
                             noOfGuests.value =noOfGuests.value-1;
                           }
                          },
                          child: CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.whiteColor,
                              child: Icon(Icons.remove, size: 5.w,color: AppColors.blackColor,)),
                        ),
                        Obx(()=> AnimatedFlipCounter(
                            textStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color:  AppColors.whiteColor,
                                fontSize: 5.w),
                            duration: const Duration(milliseconds: 800),
                            value: noOfGuests.value,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            noOfGuests.value =noOfGuests.value+1;
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
            ),
            SizedBox(height: 1.h,),
            FadeInRight(from :200,child: CustomTextWidget(title: "Date",fontWeight: FontWeight.w600,fontSize: 5.5.w,)),
            SizedBox(height: 1.h,),
            FadeInRight(
              from: 250,
              child: SizedBox(
                height: 7.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context,int index){
                      return Padding(
                        padding:  EdgeInsets.only(right: 2.3.w),
                        child: InkWell(
                          onTap: (){
                            selectedDate.value=index;
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Obx(()=> AnimatedContainer(
                              duration: const Duration(milliseconds: 900),
                              decoration: BoxDecoration(
                                  color:selectedDate.value==index?AppColors.primaryColor: AppColors.greyTileColor,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 3.5.w),
                                child: Center(
                                    child: CustomTextWidget(
                                      title: "${DateTime.now().day+index} July",
                                      fontSize: 4.4.w,
                                      color:selectedDate.value==index?AppColors.whiteColor: AppColors.greyTextColor,
                                      fontWeight: selectedDate.value==index?FontWeight.w600:FontWeight.w500,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            FadeInRight(from :300,child: CustomTextWidget(title: "Time",fontWeight: FontWeight.w600,fontSize: 5.5.w,)),
            SizedBox(height: 1.h,),
            FadeInRight(
              from: 350,
              child: SizedBox(
                height: 7.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context,int index){
                      return Padding(
                        padding:  EdgeInsets.only(right: 2.3.w),
                        child: InkWell(
                          onTap: (){
                            selectedTime.value=index;
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Obx(()=> AnimatedContainer(
                            duration: const Duration(milliseconds: 900),
                            decoration: BoxDecoration(
                                color:selectedTime.value==index?AppColors.primaryColor: AppColors.greyTileColor,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 3.5.w),
                              child: Center(
                                  child: CustomTextWidget(
                                    title: "${(DateTime.now().hour + index) % 12 == 0 ? 12 : (DateTime.now().hour + index) % 12} ${DateTime.now().hour + index >= 12 ? 'PM' : 'AM'}",
                                    fontSize: 4.4.w,
                                    color:selectedTime.value==index?AppColors.whiteColor: AppColors.greyTextColor,
                                    fontWeight: selectedTime.value==index?FontWeight.w600:FontWeight.w500,
                                  )
                              ),
                            ),
                          ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            FadeInRight(
              from: 400,
              child: Row(
                children: [
                  Expanded(
                    child: CustomMainButton(
                        borderRadius: 25,
                        height: 6.4.h,
                        color: AppColors.primaryColor,
                        onTap: (){
                          Navigator.pop(context);
                          orderPlacedDialogue(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextWidget(
                              title: 'Confirm',
                              fontSize: 5.w,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),

        ],),
      ),
    );
  });


}



void orderPlacedDialogue(BuildContext context){
  showModalBottomSheet(
    isScrollControlled: true,
      context: context, builder: (context){
    return Container(
      height: 60.h,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
          image: DecorationImage(
              image: AssetImage('assets/images/png/back1.png'),
              fit: BoxFit.cover
          )
      ),
      width: double.infinity,
      child: GetBuilder<DesignController>(
        builder: (designController) {
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeInUp(
                  from: 100,
                    child: SizedBox(
                        height: 30.h,
                        child: Lottie.asset('assets/images/json/suhsi.json'))
                ),
                FadeInUp(from :100,child: CustomTextWidget(title: "Order Placed!",fontWeight: FontWeight.w600,fontSize: 7.w,)),
                SizedBox(height: 1.h,),
                FadeInUp(
                  from :200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(title: "No. of Guests : 3",fontSize: 5.5.w,color: AppColors.greyTextColor,),
                          SizedBox(height: 0.5.h,),
                          CustomTextWidget(title: "Table No : 6",fontSize: 5.5.w,color: AppColors.greyTextColor,),
                          SizedBox(height: 0.5.h,),
                          CustomTextWidget(title: "Total Amount : ¥${designController.foodItems.fold(0, (sum, item) => sum + (item.count * item.price))}",fontSize: 5.5.w,color: AppColors.greyTextColor,),
                          SizedBox(height: 0.5.h,),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(
                            height: 90,
                            width: 90,
                            image:  const AssetImage('assets/images/png/table.png'),
                            color: AppColors.primaryColor,
                          ),
                          CustomTextWidget(title: '6',color: AppColors.whiteColor,fontWeight: FontWeight.bold,fontSize: 4.6.w,)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
                FadeInUp(
                  from: 300,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomMainButton(
                            borderRadius: 25,
                            height: 6.4.h,
                            color: AppColors.secondaryColor,
                            onTap: (){
                              //Get.offAll(()=>RootScreen());
                              designController.resetAllCounts();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              designController.resetAllCounts();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextWidget(
                                  title: 'Back to Home',
                                  fontSize: 5.w,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColor,
                                ),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
              ],
            ),
          );
        }
      ),
    );
  });


}