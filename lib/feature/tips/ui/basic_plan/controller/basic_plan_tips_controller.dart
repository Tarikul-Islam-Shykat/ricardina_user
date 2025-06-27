import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/common_page/model/health_card_model.dart';

class BasicPlanTipsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  
  final RxBool isLoading = false.obs;
  final RxList<HealthCard> allCards = <HealthCard>[].obs;
  final RxList<HealthCard> filteredCards = <HealthCard>[].obs;
  final RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
      filterCards();
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  
  void filterCards() {
    if (currentTabIndex.value == 0) {
      // Heart tab
      filteredCards.value = allCards.where((card) => card.type == HealthType.heart).toList();
    } else {
      // Blood tab
      filteredCards.value = allCards.where((card) => card.type == HealthType.blood).toList();
    }
  }

  void navigateToDetail(HealthCard card) {
    Get.toNamed('/health-detail', arguments: card);
  }
}