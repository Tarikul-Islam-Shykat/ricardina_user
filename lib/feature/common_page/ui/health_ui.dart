import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/feature/common_page/controller/health_controller.dart';
import 'package:prettyrini/feature/common_page/widget/health_rate_card.dart';
import 'package:prettyrini/feature/common_page/widget/widget_card.dart';
import 'package:prettyrini/feature/common_page/model/health_card_model.dart';

class HealthCardsScreen extends StatefulWidget {
  final HealthType? healthType;
  final String? heading;

  const HealthCardsScreen({
    Key? key,
    this.healthType,
    this.heading,
  }) : super(key: key);

  @override
  State<HealthCardsScreen> createState() => _HealthCardsScreenState();
}

class _HealthCardsScreenState extends State<HealthCardsScreen> {
  late HealthController controller;
  late String pageHeading;
  late HealthType selectedHealthType;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HealthController());

    // Set default values or use passed parameters
    selectedHealthType = widget.healthType ?? HealthType.heart;
    pageHeading = widget.heading ?? _getDefaultHeading(selectedHealthType);
  }

  String _getDefaultHeading(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return 'Heart Rate';
      case HealthType.blood:
        return 'Blood Pressure';
      case HealthType.water:
        return 'Hydration';
      case HealthType.step:
        return 'Step Counter';
      case HealthType.weight:
        return 'Weight Management';
      case HealthType.health:
        return 'Overall Health';
      default:
        return 'Health Monitor';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),

            // Header with dynamic heading
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      pageHeading,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            // Month navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => controller.changeMonth(-1),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Obx(() => Text(
                        DateFormat('MMMM yyyy')
                            .format(controller.currentMonth.value),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      )),
                  IconButton(
                    onPressed: () => controller.changeMonth(1),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),

            // Date selector
            Obx(
              () => Container(
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.monthDates.length,
                  itemBuilder: (context, index) {
                    final date = controller.monthDates[index];
                    final isSelected =
                        controller.selectedDate.value.day == date.day &&
                            controller.selectedDate.value.month == date.month &&
                            controller.selectedDate.value.year == date.year;

                    return GestureDetector(
                      onTap: () {
                        controller.selectDate(date);
                        setState(() {});
                      },
                      child: Container(
                        width: 60,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEE').format(date),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DateFormat('dd').format(date),
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Dynamic health metric card based on selected type
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeartRateCard(
                    heartRate: controller.heartRate.value,
                    time: controller.measurementTime.value,
                    heading: "Today's ${pageHeading}",
                    value: _getMetricValue(selectedHealthType),
                    icon: controller.getTypeIcon(selectedHealthType),
                    iconColor: Colors.white,
                    unit: _getMetricUnit(selectedHealthType),
                    isTimeVisible: true,
                    onTap: () {
                      Get.snackbar(
                        '${pageHeading} Details',
                        '${pageHeading}: ${_getMetricValue(selectedHealthType)} ${_getMetricUnit(selectedHealthType)} at ${controller.measurementTime.value}',
                        backgroundColor:
                            controller.getTypeColor(selectedHealthType),
                        colorText: Colors.white,
                      );
                    },
                  ),
                )),

            // Filtered Cards List based on selected health type
            Obx(() {
              if (controller.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF2C3E50)),
                  ),
                );
              }

              final filteredCards = controller.filteredCards
                  .where((card) => card.type == selectedHealthType)
                  .toList();

              if (filteredCards.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    'No ${pageHeading.toLowerCase()} cards found',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: filteredCards
                      .map((card) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: HealthCardWidget(
                              card: card,
                              controller: controller,
                            ),
                          ))
                      .toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getMetricValue(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return "120";
      case HealthType.blood:
        return "120/80";
      case HealthType.water:
        return "2.5";
      case HealthType.step:
        return "8,542";
      case HealthType.weight:
        return "70.2";
      case HealthType.health:
        return "85";
      default:
        return "120";
    }
  }

  String _getMetricUnit(HealthType type) {
    switch (type) {
      case HealthType.heart:
        return "bpm";
      case HealthType.blood:
        return "mmHg";
      case HealthType.water:
        return "L";
      case HealthType.step:
        return "steps";
      case HealthType.weight:
        return "kg";
      case HealthType.health:
        return "%";
      default:
        return "bpm";
    }
  }
}
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/feature/common_page/controller/health_controller.dart';
import 'package:prettyrini/feature/common_page/widget/health_rate_card.dart';
import 'package:prettyrini/feature/common_page/widget/widget_card.dart';



class HealthCardsScreen extends StatefulWidget {
  const HealthCardsScreen({Key? key}) : super(key: key);

  @override
  State<HealthCardsScreen> createState() => _HealthCardsScreenState();
}

class _HealthCardsScreenState extends State<HealthCardsScreen> {
  @override
  Widget build(BuildContext context) {
    final HealthController controller = Get.put(HealthController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Heartrate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 36), // Balance the back button
                ],
              ),
            ),

            // Month navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => controller.changeMonth(-1),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Obx(() => Text(
                        DateFormat('MMMM yyyy')
                            .format(controller.currentMonth.value),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      )),
                  IconButton(
                    onPressed: () => controller.changeMonth(1),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),

            // Date selector
            Obx(
              () => Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.monthDates.length,
                    itemBuilder: (context, index) {
                      final date = controller.monthDates[index];
                      final isSelected = controller.selectedDate.value.day ==
                              date.day &&
                          controller.selectedDate.value.month == date.month &&
                          controller.selectedDate.value.year == date.year;

                      return GestureDetector(
                        onTap: () {
                          controller.selectDate(date);
                          setState(() {});
                        },
                        child: Container(
                          width: 60,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('EEE').format(date),
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade100,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat('dd').format(date),
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),

            // Heart rate card
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeartRateCard(
                    heartRate: controller.heartRate.value,
                    time: controller.measurementTime.value,
                    heading: "Todays Heartrate",
                    value: "120",
                    icon: Icons.favorite,
                    iconColor: Colors.white,
                    unit: "bpm",
                    isTimeVisible: true,
                    onTap: () {
                      // Handle card tap - maybe show more details
                      Get.snackbar(
                        'Heart Rate Details',
                        'Heart rate: ${controller.heartRate.value} bpm at ${controller.measurementTime.value}',
                        backgroundColor: AppColors.primaryColor,
                        colorText: Colors.white,
                      );
                    },
                  ),
                )),

            // Cards List - Changed from ListView.builder to Column
            Obx(() {
              if (controller.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF2C3E50)),
                  ),
                );
              }

              if (controller.filteredCards.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Text(
                    'No health cards found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              // Use Column instead of ListView.builder
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: controller.filteredCards
                      .where((card) => card.type.name == "heart")
                      .map((card) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: HealthCardWidget(
                              card: card,
                              controller: controller,
                            ),
                          ))
                      .toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

*/
