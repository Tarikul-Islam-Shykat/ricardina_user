// screens/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/checkout_page/controller/checkout_controller.dart';
import 'package:prettyrini/feature/checkout_page/model/doctor_model.dart';

// screens/checkout_screen.dar

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.put(CheckoutController());

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => controller.goBack(),
        ),
        title: headingText(
          text: "Checkout",
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Selected Doctor Section
                  _buildSelectedDoctorSection(controller),

                  SizedBox(height: 24.h),

                  // Date Section
                  _buildDateSection(controller),

                  SizedBox(height: 24.h),

                  // Time Slots Section
                  _buildTimeSlotSection(controller),

                  SizedBox(height: 100.h), // Space for button
                ],
              ),
            ),
          ),

          // Confirm Booking Button
          _buildConfirmButton(controller),
        ],
      ),
    );
  }

  Widget _buildSelectedDoctorSection(CheckoutController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            headingText(
              text: "Selected Doctor",
              color: Colors.black,
            ),
            Icon(
              Icons.keyboard_arrow_up,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Obx(() => _buildDoctorCard(controller.selectedDoctor.value)),
      ],
    );
  }

  Widget _buildDoctorCard(DoctorModel doctor) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Doctor Avatar
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: doctor.imageUrl != null
                  ? Image.network(
                      doctor.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          color: Colors.grey[400],
                          size: 30.sp),
                    )
                  : Icon(Icons.person, color: Colors.grey[400], size: 30.sp),
            ),
          ),

          SizedBox(width: 12.w),

          // Doctor Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingText(
                  text: doctor.name,
                  color: Colors.white,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    normalText(
                      text: '\$${doctor.hourlyRate.toInt()}',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 4.w),
                    smallText(
                      text: '/ ${doctor.duration}',
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Remove Button
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.remove,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(CheckoutController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingText(
          text: "Date",
          color: Colors.black,
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () => controller.selectDate(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => normalText(
                      text: controller.selectedDate.value,
                      color: Colors.black,
                    )),
                Icon(
                  Icons.calendar_today,
                  color: Colors.grey[600],
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotSection(CheckoutController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingText(
          text: "Choose Timeslot",
          color: Colors.black,
        ),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 2.5,
          ),
          itemCount: controller.timeSlots.length,
          itemBuilder: (context, index) {
            final timeSlot = controller.timeSlots[index];

            return Obx(() {
              final isSelected =
                  controller.selectedTimeSlots.contains(timeSlot);

              return GestureDetector(
                onTap: () => controller.toggleTimeSlot(timeSlot),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Center(
                    child: smallText(
                      text: timeSlot,
                      color: isSelected ? Colors.white : Colors.grey[700]!,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildConfirmButton(CheckoutController controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: Obx(() => ElevatedButton(
                onPressed: controller.selectedTimeSlots.isEmpty
                    ? null
                    : () => controller.confirmBooking(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.selectedTimeSlots.isEmpty
                      ? Colors.grey[400]
                      : AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: controller.isLoading.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : headingText(
                        text: "Confirm Booking",
                        color: Colors.white,
                      ),
              )),
        ),
      ),
    );
  }
}
