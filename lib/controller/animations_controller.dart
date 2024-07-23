import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppAnimationController extends GetxController with SingleGetTickerProviderMixin {
   late Animation<Offset> leftAnimation;
   late Animation<Offset> rightAnimation;
   late Animation<double> showFadeAnimation;
   late Animation<double> hideFadeAnimation;
   late AnimationController controller;
   var isIntroScreen = true.obs;
   var currentScreen = 0.obs;

   @override
   void onInit() {
      super.onInit();
      controller = AnimationController(
         duration: const Duration(seconds: 1),
         vsync: this,
      );
      leftAnimation = Tween<Offset>(
         begin: Offset.zero,
         end: const Offset(-1.5, 0),
      ).animate(CurvedAnimation(
         parent: controller,
         curve: Curves.easeIn,
      ));

      rightAnimation = Tween<Offset>(
         begin: Offset.zero,
         end: const Offset(1.5, 0),
      ).animate(CurvedAnimation(
         parent: controller,
         curve: Curves.easeIn,
      ));


      showFadeAnimation = Tween<double>(
         begin: 1.0,
         end: 0.0,
      ).animate(CurvedAnimation(
         parent: controller,
         curve: Curves.easeIn,
      ));

      hideFadeAnimation = Tween<double>(
         begin: 0.0,
         end: 1.0,
      ).animate(CurvedAnimation(
         parent: controller,
         curve: Curves.easeIn,
      ));



   }

   void toggleScreen() {
      HomeAnimationController homeController=Get.put(HomeAnimationController());
      isIntroScreen.value = !isIntroScreen.value;
      if (isIntroScreen.value) {
         controller.reverse();
         homeController.homeAnimationController.reverse();
      } else {
         controller.forward();
         homeController.homeAnimationController.forward();
      }
      update();
   }



   @override
   void onClose() {
      controller.dispose();
      super.onClose();
   }
}





class HomeAnimationController extends GetxController with SingleGetTickerProviderMixin {
   late Animation<Offset> homeSlideAnimation;
   late AnimationController homeAnimationController;
   var isSearchingFood=false.obs;
   var showSearchCancel=false.obs;

   @override
   void onInit() {
      super.onInit();
      homeAnimationController = AnimationController(
         duration: const Duration(seconds: 1),
         vsync: this,
      );


      homeSlideAnimation = Tween<Offset>(
         begin: const Offset(1.5, 0),
         end: Offset.zero,
      ).animate(
         CurvedAnimation(
            parent: homeAnimationController,
            curve: Curves.easeInOut,
         ),
      );

   }

   void toggleSearch(){
      isSearchingFood.value=!isSearchingFood.value;
      update();
      Future.delayed(const Duration(milliseconds: 850), () {
         showSearchCancel.value=!showSearchCancel.value;
         update();
      });
   }

   @override
   void onClose() {
      homeAnimationController.dispose();
      super.onClose();
   }
}