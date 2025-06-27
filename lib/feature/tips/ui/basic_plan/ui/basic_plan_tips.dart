import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/common_page/controller/health_controller.dart';
import 'package:prettyrini/feature/common_page/widget/widget_card.dart';
import 'package:prettyrini/feature/tips/tips_details_ui.dart';
import 'package:prettyrini/feature/tips/ui/basic_plan/controller/basic_plan_tips_controller.dart';

class BasicPlanTips extends StatelessWidget {
  const BasicPlanTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BasicPlanTipsController controller =
        Get.put(BasicPlanTipsController());
    final HealthController healthController = Get.put(HealthController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        title: const Text(
          'Tips',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: controller.tabController,
              indicator: BoxDecoration(
                color: const Color(0xFF4ECDC4),
                borderRadius: BorderRadius.circular(25),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFF7F8C8D),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'Heart'),
                Tab(text: 'Receipes'),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildTabContent(healthController),
                _buildTabContent(healthController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(HealthController controller) {
    return Obx(() {
      // if (controller.isLoading.value) {
      //   return const Center(
      //     child: CircularProgressIndicator(
      //       valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4ECDC4)),
      //     ),
      //   );
      // }

      if (controller.filteredCards.isEmpty) {
        return const Center(
          child: Text(
            'No health cards found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.filteredCards.length,
        itemBuilder: (context, index) {
          final card = controller.filteredCards[index];
          return GestureDetector(
            onTap: () {
              log("message");
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: HealthCardWidget(
                card: card,
                controller: controller,
              ),
            ),
          );
        },
      );
    });
  }
}
