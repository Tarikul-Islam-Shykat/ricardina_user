// medical_screen_tab.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/doctor_details/model/doctor_details_model.dart';
import 'package:prettyrini/feature/doctor_details/ui/doctor_details_page.dart';
import 'package:prettyrini/feature/medical_tab/controller/medical_controller.dart';
import 'package:prettyrini/feature/medical_tab/model/medical_item_model.dart';

class MedicalScreenTab extends StatelessWidget {
  final MedicalController controller = Get.put(MedicalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          SizedBox(height: 20),
          headingText(text: "Medical "),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTab('Hospital', TabType.hospital),
                    _buildTab('Pharmacy', TabType.pharmacy),
                    _buildTab('Doctor', TabType.doctor),
                  ],
                )),
          ),

          // List Section
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.medicalItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.medicalItems[index];
                    return GestureDetector(
                        onTap: () {
                          // if (controller.selectedTab.value.name == "doctor") {
                          //   Get.to(DoctorDetailsPage(
                          //     doctor: DoctorDetailsModel.getSampleDoctor(),
                          //   ));
                          // }
                        },
                        child: _buildItemCard(item));
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, TabType tabType) {
    final isSelected = controller.selectedTab.value == tabType;

    return GestureDetector(
      onTap: () => controller.changeTab(tabType),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: isSelected
              ? Border.all(color: AppColors.primaryColor, width: 1.5)
              : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? AppColors.primaryColor : AppColors.blackColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(MedicalItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconForType(item.type),
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.rating.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'hospital':
        return Icons.local_hospital;
      case 'pharmacy':
        return Icons.local_pharmacy;
      case 'doctor':
        return Icons.person;
      default:
        return Icons.medical_services;
    }
  }
}
