import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/common_page/controller/health_controller.dart';
import 'package:prettyrini/feature/common_page/model/health_card_model.dart';
import 'package:prettyrini/feature/common_page/ui/health_ui.dart';
import 'package:prettyrini/feature/common_page/widget/health_rate_card.dart';
import 'package:prettyrini/feature/common_page/widget/widget_card.dart';
import 'package:prettyrini/feature/notification/ui/notification_page_ui.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HealthCardsScreenState();
}

class _HealthCardsScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    final HealthController controller = Get.put(HealthController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildHeader(),
            ),
            SizedBox(
              height: 2,
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(text: "Overview"),
                  smallText(text: "See All", color: AppColors.primaryColor)
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: HeartRateCard(
                  heartRate: controller.heartRate.value,
                  time: controller.measurementTime.value,
                  heading: "Heartrate",
                  value: "120",
                  icon: Icons.favorite,
                  iconColor: Colors.white,
                  unit: "bpm",
                  isTimeVisible: false,
                  onTap: () {
                    // Handle card tap - maybe show more details
                    Get.to(() => HealthCardsScreen(
                          healthType: HealthType.heart,
                          heading: "My Heart Health",
                        ));
                  },
                )),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: HeartRateCard(
                  heartRate: controller.heartRate.value,
                  time: controller.measurementTime.value,
                  heading: "Bloor Pressure",
                  value: "140/90",
                  icon: Icons.favorite,
                  iconColor: AppColors.primaryColor,
                  unit: "mmh",
                  textColor: Colors.black,
                  cardColor: Colors.white,
                  isTimeVisible: false,
                  onTap: () {
                    // Handle card tap - maybe show more details
                    Get.to(() => HealthCardsScreen(
                          healthType: HealthType.blood,
                          heading: "Blood Pressure Monitor",
                        ));

                    // Get.snackbar(
                    //   'Heart Rate Details',
                    //   'Heart rate: ${controller.heartRate.value} bpm at ${controller.measurementTime.value}',
                    //   backgroundColor: AppColors.primaryColor,
                    //   colorText: Colors.white,
                    // );
                  },
                )),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: HeartRateCard(
                  heartRate: controller.heartRate.value,
                  time: controller.measurementTime.value,
                  heading: "Water",
                  value: "1400",
                  icon: Icons.favorite,
                  iconColor: AppColors.primaryColor,
                  unit: "ml",
                  textColor: Colors.black,
                  cardColor: Colors.white,
                  isTimeVisible: false,
                  onTap: () {
                    // Handle card tap - maybe show more details
                    Get.to(() => HealthCardsScreen(
                          heading: "Daily Water Tracker",
                          healthType: HealthType.water,
                        ));
                  },
                )),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: HeartRateCard(
                  heartRate: controller.heartRate.value,
                  time: controller.measurementTime.value,
                  heading: "Steps",
                  value: "1400",
                  icon: Icons.favorite,
                  iconColor: AppColors.primaryColor,
                  unit: "mmh",
                  textColor: Colors.black,
                  cardColor: Colors.white,
                  isTimeVisible: false,
                  onTap: () {
                    // Handle card tap - maybe show more details
                    Get.to(() => HealthCardsScreen(
                          healthType: HealthType.step,
                          heading: "Daily Steps Tracker",
                        ));
                  },
                )),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: HeartRateCard(
                  heartRate: controller.heartRate.value,
                  time: controller.measurementTime.value,
                  heading: "Weight",
                  value: "50.5",
                  icon: Icons.favorite,
                  iconColor: AppColors.primaryColor,
                  unit: "kg",
                  textColor: Colors.black,
                  cardColor: Colors.white,
                  isTimeVisible: false,
                  onTap: () {
                    // Handle card tap - maybe show more details
                    Get.to(() => HealthCardsScreen(
                          healthType: HealthType.weight,
                          heading: "My Heart Health",
                        ));
                  },
                )),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(text: "Health Tips"),
                  smallText(text: "See All", color: AppColors.primaryColor)
                ],
              ),
            ),
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

  Widget _buildHeader() {
    return Row(
      children: [
        // Profile Image
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: const DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // Welcome Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              smallText(
                text: "Welcome back,",
                color: Colors.grey[600]!,
              ),
              SizedBox(height: 2.h),
              headingText(
                text: "Darrell Steward",
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),

        // Notification Icon
        GestureDetector(
          onTap: () {
            Get.to(NotificationScreen());
          },
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.grey[700],
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
