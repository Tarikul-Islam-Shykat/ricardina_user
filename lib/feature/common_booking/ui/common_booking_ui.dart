import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/common_booking/controller/common_booking_controlller.dart';

class CommonStatusUi extends StatelessWidget {
  final BookingType bookingType;

  const CommonStatusUi({
    Key? key,
    this.bookingType = BookingType.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonBookingUiController>(
      init: CommonBookingUiController()..initializeWithType(bookingType),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F9FA),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20.sp,
            ),
            onPressed: () => Get.back(),
          ),
          title: headingText(
            text: controller.bookingTypeDisplayName,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),

            // Tab Section
            _buildTabSection(controller),

            SizedBox(height: 20.h),

            Expanded(
              child: _buildBookingsList(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSection(CommonBookingUiController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              text: controller.ongoingTabName,
              isSelected: controller.selectedTab == BookingStatus.ongoing,
              onTap: () => controller.changeTab(BookingStatus.ongoing),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: _buildTabButton(
              text: controller.completedTabName,
              isSelected: controller.selectedTab == BookingStatus.completed,
              onTap: () => controller.changeTab(BookingStatus.completed),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF00B4A6) : Colors.grey[300]!,
            width: 2.w,
          ),
        ),
        child: Center(
          child: normalText(
            text: text,
            color: isSelected ? const Color(0xFF00B4A6) : Colors.grey[600]!,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingsList(CommonBookingUiController controller) {
    final bookings = controller.getFilteredBookings();

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getEmptyIcon(controller.bookingType),
              size: 60.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            normalText(
              text:
                  "No ${controller.selectedTab.name} ${controller.bookingType.name}",
              color: Colors.grey[500]!,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () => controller.onBookingTap(booking),
            child: Row(
              children: [
                // Profile/Service Image
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: NetworkImage(booking.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // Name, Time, and Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      normalText(
                        text: booking.name,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 4.h),
                      if (booking.specialty != null) ...[
                        smallText(
                          text: booking.specialty!,
                          color: const Color(0xFF00B4A6),
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 2.h),
                      ],
                      smallText(
                        text: booking.time,
                        color: Colors.grey[500]!,
                      ),
                    ],
                  ),
                ),

                // Rating Section
                if (booking.rating > 0) ...[
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16.sp,
                          ),
                          SizedBox(width: 2.w),
                          smallText(
                            text: booking.rating.toStringAsFixed(1),
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              _getStatusColor(booking.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: smallText(
                          text: _getStatusText(
                              booking.status, controller.bookingType),
                          color: _getStatusColor(booking.status),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getEmptyIcon(BookingType type) {
    switch (type) {
      case BookingType.doctor:
        return Icons.medical_services_outlined;
      case BookingType.pharmacy:
        return Icons.local_pharmacy_outlined;
      case BookingType.hospital:
        return Icons.local_hospital_outlined;
    }
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.ongoing:
        return Colors.orange;
      case BookingStatus.completed:
        return Colors.green;
    }
  }

  String _getStatusText(BookingStatus status, BookingType type) {
    if (status == BookingStatus.ongoing) {
      switch (type) {
        case BookingType.doctor:
          return "Upcoming";
        case BookingType.pharmacy:
          return "Processing";
        case BookingType.hospital:
          return "Scheduled";
      }
    } else {
      switch (type) {
        case BookingType.doctor:
          return "Completed";
        case BookingType.pharmacy:
          return "Delivered";
        case BookingType.hospital:
          return "Visited";
      }
    }
  }
}


/*
common usage  
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Example of how to use the updated booking system

class BookingNavigationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Types")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Navigate to Doctor Bookings
            _buildNavigationCard(
              title: "Doctor Appointments",
              subtitle: "View and manage your doctor appointments",
              icon: Icons.medical_services,
              color: Colors.blue,
              onTap: () {
                Get.to(() => CommonStatusUi(bookingType: BookingType.doctor));
              },
            ),

            SizedBox(height: 16),

            // Navigate to Pharmacy Bookings
            _buildNavigationCard(
              title: "Pharmacy Orders",
              subtitle: "Track your medicine orders and prescriptions",
              icon: Icons.local_pharmacy,
              color: Colors.green,
              onTap: () {
                Get.to(() => CommonStatusUi(bookingType: BookingType.pharmacy));
              },
            ),

            SizedBox(height: 16),

            // Navigate to Hospital Bookings
            _buildNavigationCard(
              title: "Hospital Visits",
              subtitle: "Manage your hospital appointments and visits",
              icon: Icons.local_hospital,
              color: Colors.red,
              onTap: () {
                Get.to(() => CommonStatusUi(bookingType: BookingType.hospital));
              },
            ),

            SizedBox(height: 32),

            // Example of programmatically adding bookings
            ElevatedButton(
              onPressed: _demonstrateAddingBookings,
              child: Text("Demo: Add Sample Bookings"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
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
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _demonstrateAddingBookings() {
    // Example: Add a new doctor appointment
    final doctorController = Get.find<CommonBookingUiController>();
    if (doctorController.bookingType == BookingType.doctor) {
      doctorController.addBooking(
        name: "Dr. New Doctor",
        image: "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150&h=150&fit=crop&crop=face",
        time: "15-04-2025 | 02:00 - 02:30 PM",
        status: BookingStatus.ongoing,
        rating: 4.9,
        specialty: "General Physician",
      );
    }

    Get.snackbar(
      "Success",
      "Sample booking added successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

// Alternative usage: Direct controller initialization
class DirectControllerUsage {
  void demonstrateDirectUsage() {
    // Method 1: Initialize controller with type
    final doctorController = Get.put(CommonBookingUiController());
    doctorController.initializeWithType(BookingType.doctor);

    // Method 2: Create separate controllers for each type
    final pharmacyController = Get.put(
      CommonBookingUiController(),
      tag: 'pharmacy',
    );
    pharmacyController.initializeWithType(BookingType.pharmacy);

    final hospitalController = Get.put(
      CommonBookingUiController(),
      tag: 'hospital',
    );
    hospitalController.initializeWithType(BookingType.hospital);

    // Now you can use them independently
    print("Doctor bookings: ${doctorController.totalCount}");
    print("Pharmacy orders: ${pharmacyController.totalCount}");
    print("Hospital visits: ${hospitalController.totalCount}");
  }

  void demonstrateBookingOperations() {
    final controller = Get.find<CommonBookingUiController>();

    // Add a new booking
    controller.addBooking(
      name: "Emergency Appointment",
      image: "https://example.com/image.jpg",
      time: "Today | 03:00 - 03:30 PM",
      status: BookingStatus.ongoing,
      rating: 0.0, // No rating yet for new booking
      specialty: "Emergency",
    );

    // Mark a booking as completed
    final bookings = controller.getOngoingBookings();
    if (bookings.isNotEmpty) {
      controller.markAsCompleted(bookings.first);
    }

    // Search bookings
    final searchResults = controller.searchBookings("Dr");
    print("Found ${searchResults.length} bookings with 'Dr'");

    // Get bookings by status
    final ongoing = controller.getOngoingBookings();
    final completed = controller.getCompletedBookings();
    
    print("Ongoing: ${ongoing.length}, Completed: ${completed.length}");
  }
}

// Example: Using in different routes
class RouteExamples {
  static void setupRoutes() {
    Get.addPages([
      GetPage(
        name: '/doctor-bookings',
        page: () => CommonStatusUi(bookingType: BookingType.doctor),
      ),
      GetPage(
        name: '/pharmacy-orders',
        page: () => CommonStatusUi(bookingType: BookingType.pharmacy),
      ),
      GetPage(
        name: '/hospital-visits',
        page: () => CommonStatusUi(bookingType: BookingType

*/