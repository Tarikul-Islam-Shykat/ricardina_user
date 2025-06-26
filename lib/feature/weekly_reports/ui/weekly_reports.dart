import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/common_page/controller/health_controller.dart';
import 'package:prettyrini/feature/common_page/widget/health_rate_card.dart';

import 'package:prettyrini/feature/medication_page/widget/bottom_sheet_page.dart';

class WeeklyReportsPage extends StatefulWidget {
  const WeeklyReportsPage({Key? key}) : super(key: key);

  @override
  State<WeeklyReportsPage> createState() => _WeeklyReportsPageState();
}

class _WeeklyReportsPageState extends State<WeeklyReportsPage> {
  @override
  Widget build(BuildContext context) {
    final HealthController controller = Get.put(HealthController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            headingText(text: "Weekly Reports"),

            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeartRateCard(
                    heartRate: controller.heartRate.value,
                    time: controller.measurementTime.value,
                    heading: "Today Heartrate",
                    value: "120",
                    icon: Icons.medication,
                    iconColor: Colors.white,
                    unit: "bpm",
                    isTimeVisible: true,
                    onTap: () {
                      Get.snackbar(
                        'Medication Details',
                        'Atorvastatin 20mg - 2 times daily',
                        backgroundColor: AppColors.primaryColor,
                        colorText: Colors.white,
                      );
                    },
                  ),
                )),

            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeartRateCard(
                    heartRate: controller.heartRate.value,
                    time: controller.measurementTime.value,
                    heading: "Today Blood Pressure",
                    value: "141/90",
                    icon: Icons.water_drop,
                    iconColor: AppColors.primaryColor,
                    unit: " mmh",
                    isTimeVisible: true,
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      Get.snackbar(
                        'Medication Details',
                        'Metformin 500mg - 1 time daily',
                        backgroundColor: AppColors.primaryColor,
                        colorText: Colors.white,
                      );
                    },
                  ),
                )),
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeartRateCard(
                    heartRate: controller.heartRate.value,
                    time: controller.measurementTime.value,
                    heading: "Today Water Level",
                    value: "1400",
                    icon: Icons.water_drop_outlined,
                    iconColor: AppColors.primaryColor,
                    unit: " ml",
                    isTimeVisible: true,
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      Get.snackbar(
                        'Medication Details',
                        'Metformin 500mg - 1 time daily',
                        backgroundColor: AppColors.primaryColor,
                        colorText: Colors.white,
                      );
                    },
                  ),
                )),

            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeartRateCard(
                    heartRate: controller.heartRate.value,
                    time: controller.measurementTime.value,
                    heading: "Today Steps",
                    value: "1400",
                    icon: Icons.airline_seat_legroom_normal,
                    iconColor: AppColors.primaryColor,
                    unit: " steps",
                    isTimeVisible: true,
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      Get.snackbar(
                        'Medication Details',
                        'Metformin 500mg - 1 time daily',
                        backgroundColor: AppColors.primaryColor,
                        colorText: Colors.white,
                      );
                    },
                  ),
                )),

            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeartRateCard(
                    heartRate: controller.heartRate.value,
                    time: controller.measurementTime.value,
                    heading: "Today Weight",
                    value: "65.5",
                    icon: Icons.monitor_weight,
                    iconColor: AppColors.primaryColor,
                    unit: " kg",
                    isTimeVisible: true,
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      Get.snackbar(
                        'Medication Details',
                        'Metformin 500mg - 1 time daily',
                        backgroundColor: AppColors.primaryColor,
                        colorText: Colors.white,
                      );
                    },
                  ),
                )),

            const SizedBox(height: 100), // Space for FAB
          ],
        ),
      ),
    );
  }
}
