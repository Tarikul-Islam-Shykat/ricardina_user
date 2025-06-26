// // app_colors.dart



// // heart_rate_card.dart

// // heart_rate_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HeartRateScreen extends StatelessWidget {
//   final HeartRateController controller = Get.put(HeartRateController());

//   HeartRateScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header with back button and title
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Get.back(),
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.arrow_back_ios,
//                         size: 20,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       'Heartrate',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 36), // Balance the back button
//                 ],
//               ),
//             ),
            
//             // Month navigation
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: () => controller.changeMonth(-1),
//                     icon: const Icon(Icons.chevron_left),
//                   ),
//                   Obx(() => Text(
//                     DateFormat('MMMM yyyy').format(controller.currentMonth.value),
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   )),
//                   IconButton(
//                     onPressed: () => controller.changeMonth(1),
//                     icon: const Icon(Icons.chevron_right),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Date selector
//             Container(
//               height: 80,
//               margin: const EdgeInsets.symmetric(vertical: 20),
//               child: Obx(() => ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 itemCount: controller.monthDates.length,
//                 itemBuilder: (context, index) {
//                   final date = controller.monthDates[index];
//                   final isSelected = controller.selectedDate.value.day == date.day &&
//                       controller.selectedDate.value.month == date.month &&
//                       controller.selectedDate.value.year == date.year;
                  
//                   return GestureDetector(
//                     onTap: () => controller.selectDate(date),
//                     child: Container(
//                       width: 60,
//                       margin: const EdgeInsets.only(right: 12),
//                       decoration: BoxDecoration(
//                         color: isSelected ? AppColors.selectedDateBg : Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             DateFormat('EEE').format(date),
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : AppColors.textSecondary,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             DateFormat('dd').format(date),
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : AppColors.textPrimary,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )),
//             ),
            
//             // Heart rate card
//             Obx(() => HeartRateCard(
//               heartRate: controller.heartRate.value,
//               time: controller.measurementTime.value,
//               onTap: () {
//                 // Handle card tap - maybe show more details
//                 Get.snackbar(
//                   'Heart Rate Details',
//                   'Heart rate: ${controller.heartRate.value} bpm at ${controller.measurementTime.value}',
//                   backgroundColor: AppColors.primaryColor,
//                   colorText: Colors.white,
//                 );
//               },
//             )),
            
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

