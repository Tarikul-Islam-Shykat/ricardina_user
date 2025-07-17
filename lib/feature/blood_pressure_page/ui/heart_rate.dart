import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/feature/blood_pressure_page/controller/bloor_pressue.dart';
import 'package:prettyrini/feature/common_page/widget/health_rate_card.dart';

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
            // Obx(() => HeartRateCard(
            //   heading: ""
            //   ,
            //   value: "",
            //   unit:  "",
            //   icon: Icons.abc,
            //   iconColor: Colors.white,
            //   isTimeVisible: false,
            //       heartRate: controller.heartRate.value,
            //       time: controller.measurementTime.value,
            //       onTap: () {
            //         // Handle card tap - maybe show more details
            //         Get.snackbar(
            //           'Heart Rate Details',
            //           'Heart rate: ${controller.heartRate.value} bpm at ${controller.measurementTime.value}',
            //           backgroundColor: AppColors.primaryColor,
            //           colorText: Colors.white,
            //         );
            //       },
            //     )),

            // // Cards List - Changed from ListView.builder to Column
            // Obx(() {
            //   if (controller.isLoading) {
            //     return const Padding(
            //       padding: EdgeInsets.all(50.0),
            //       child: CircularProgressIndicator(
            //         valueColor:
            //             AlwaysStoppedAnimation<Color>(Color(0xFF2C3E50)),
            //       ),
            //     );
            //   }

            //   if (controller.filteredCards.isEmpty) {
            //     return const Padding(
            //       padding: EdgeInsets.all(50.0),
            //       child: Text(
            //         'No health cards found',
            //         style: TextStyle(
            //           fontSize: 18,
            //           color: Colors.grey,
            //         ),
            //       ),
            //     );
            //   }

            //   // Use Column instead of ListView.builder
            //   return Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: Column(
            //       children: controller.filteredCards
            //           .where((card) => card.type.name == "heart")
            //           .map((card) => Padding(
            //                 padding: const EdgeInsets.only(bottom: 16),
            //                 child: HealthCardWidget(
            //                   card: card,
            //                   controller: controller,
            //                 ),
            //               ))
            //           .toList(),
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}
