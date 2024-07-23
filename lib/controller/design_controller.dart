import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japenese_resturant/controller/animations_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DesignController extends GetxController {
  ScrollController scrollController = ScrollController();
  var offset = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      offset.value = scrollController.offset;
      update();
    });
  }


  RxInt selectedFoodType = 0.obs;
  RxBool isOrderDelivery = true.obs;
  var foodTypes = <String>[
    "All",
    "Sushi and rolls",
    "Sets",
    "Ramen",
    "Tempura",
    "Sashimi",
    "Udon",
    "Takoyaki",
    "Yakitori",
    "Tonkatsu",
    "Okonomiyaki",
    "Miso Soup"
  ].obs;
  RxDouble rotationAngle = 0.0.obs;
  List<FoodItem>  cartItems =<FoodItem>[].obs;





  void scrollToIndex(int index) {
    double itemWidth = 60.w;
    double paddingRight = 2.w;
    double offset = (index * (itemWidth + paddingRight)).toDouble();

    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void selectFoodType(int index) {
    selectedFoodType.value = index;
    update();
  }

  var foodItems = <FoodItem>[
    FoodItem("Sushi & rolls:\nsushi,\nrolls combo", 0, "assets/images/png/1.png", 25),
    FoodItem("Sets:\nassorted,\ncombinations", 0, "assets/images/png/2.png", 30),
    FoodItem("Ramen:\nnoodles,\nflavorful broth", 0, "assets/images/png/3.png", 20),
    FoodItem("Tempura:\ndeep-fried vegetables", 0, "assets/images/png/4.png", 15),
    FoodItem("Sashimi:\nraw,\nsliced fish", 0, "assets/images/png/5.png", 35),
    FoodItem("Udon:\nthick noodles,\nsavory broth", 0, "assets/images/png/6.png", 22),
    FoodItem("Takoyaki:\noctopus,\nsavory balls", 0, "assets/images/png/7.png", 18),
    FoodItem("Yakitori:\nchicken,\nskewers", 0, "assets/images/png/8.png", 17),
    FoodItem("Tonkatsu:\nbreaded,\nfried pork", 0, "assets/images/png/9.png", 28),
    FoodItem("Okonomiyaki:\nsavory pancake", 0, "assets/images/png/10.png", 23),
  ].obs;

  void updateCount(int index, int newCount) {
    if (index >= 0 && index < foodItems.length) {
      foodItems[index].count = newCount;
      getCartItems();
      update();

    }
  }

  void resetAllCounts() {
    AppAnimationController appAnimationController = Get.put(AppAnimationController());
    for (var item in foodItems) {
      item.count = 0;
    }
    cartItems.clear();
    appAnimationController.currentScreen.value=0;
    appAnimationController.update();
    update();
  }

  void changeDeliveryState(){
    isOrderDelivery.value=!isOrderDelivery.value;
    update();
  }

  void getCartItems(){
    cartItems =  foodItems.where((item) => item.count > 0).toList();
  }

  var reservationTables = <TableBookingModel>[
    TableBookingModel(true, false),
    TableBookingModel(false, false),
    TableBookingModel(false, false),
    TableBookingModel(false, false),
    TableBookingModel(true, false),
    TableBookingModel(false, false),
    TableBookingModel(false, false),
    TableBookingModel(false, false),
    TableBookingModel(false, false),
    TableBookingModel(true, false),
  ].obs;

  void reserveTable(int tableNo){
    if (reservationTables[tableNo].booked && !reservationTables[tableNo].bookedByMe) {

      return;
    }

    reservationTables[tableNo].booked = !reservationTables[tableNo].booked;
    reservationTables[tableNo].bookedByMe = !reservationTables[tableNo].bookedByMe;
    update();

}

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}




class FoodItem {
  String description;
  int count;
  String image;
  int price;

  FoodItem(this.description, this.count, this.image, this.price);
}


class TableBookingModel {
  bool booked;
  bool bookedByMe;

  TableBookingModel(this.booked, this.bookedByMe);
}