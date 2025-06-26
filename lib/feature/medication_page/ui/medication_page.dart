import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/common_page/controller/health_controller.dart';
import 'package:prettyrini/feature/common_page/widget/health_rate_card.dart';

import 'package:prettyrini/feature/medication_page/widget/bottom_sheet_page.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  State<MedicationPage> createState() => _HealthCardsScreenState();
}

class _HealthCardsScreenState extends State<MedicationPage> {
  void _showAddMedicineBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddMedicineBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HealthController controller = Get.put(HealthController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            headingText(text: "Medications"),

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

            // Medication cards
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeartRateCard(
                    heartRate: controller.heartRate.value,
                    time: controller.measurementTime.value,
                    heading: "Atorvastatin - 20 MG",
                    value: "02",
                    icon: Icons.medication,
                    iconColor: Colors.white,
                    unit: " Times Daily",
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
                    heading: "Metformin - 500 MG",
                    value: "01",
                    icon: Icons.medication,
                    iconColor: AppColors.primaryColor,
                    unit: " Times Daily",
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
                    heading: "Clopidogrel - 75 MG",
                    value: "01",
                    icon: Icons.medication,
                    iconColor: AppColors.primaryColor,
                    unit: " Times Daily",
                    isTimeVisible: true,
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      Get.snackbar(
                        'Medication Details',
                        'Clopidogrel 75mg - 1 time daily',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMedicineBottomSheet,
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
