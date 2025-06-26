import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/doctor_details/model/doctor_details_model.dart';

class DoctorDetailsPage extends StatelessWidget {
  final DoctorDetailsModel? doctor;

  const DoctorDetailsPage({Key? key, this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctorData = doctor ?? DoctorDetailsModel.getSampleDoctor();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // Custom App Bar with Doctor Header
          _buildDoctorHeader(doctorData),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Stats Section
                  _buildStatsSection(doctorData),

                  SizedBox(height: 24.h),

                  // Biography Section
                  _buildBiographySection(doctorData),

                  SizedBox(height: 24.h),

                  // Reviews Section
                  _buildReviewsSection(doctorData),

                  SizedBox(height: 100.h), // Space for bottom buttons
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButtons(doctorData),
    );
  }

  Widget _buildDoctorHeader(DoctorDetailsModel doctor) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(Get.context!).padding.top + 10.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFE8F5F4),
            const Color(0xFFF0F9F8),
          ],
        ),
      ),
      child: Column(
        children: [
          // App Bar
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20.sp,
                ),
                onPressed: () => Get.back(),
              ),
              Expanded(
                child: Center(
                  child: headingText(
                    text: "Doctor Details",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 40.w), // Balance the back button
            ],
          ),

          SizedBox(height: 20.h),

          // Doctor Info
          Row(
            children: [
              // Doctor Image
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  image: DecorationImage(
                    image: NetworkImage(doctor.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: headingText(
                            text: doctor.name,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00B4A6),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 12.sp,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                doctor.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    normalText(
                      text: doctor.specialty,
                      color: const Color(0xFF00B4A6),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4.w),
                        smallText(
                          text: doctor.location,
                          color: Colors.grey[600]!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(DoctorDetailsModel doctor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.access_time,
              value: "${doctor.experience} Years",
              label: "Experience",
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: _buildStatCard(
              icon: Icons.people_outline,
              value: "${doctor.patients}+",
              label: "Patients",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF00B4A6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF00B4A6),
              size: 20.sp,
            ),
          ),
          SizedBox(height: 8.h),
          normalText(
            text: value,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 2.h),
          smallText(
            text: label,
            color: Colors.grey[600]!,
          ),
        ],
      ),
    );
  }

  Widget _buildBiographySection(DoctorDetailsModel doctor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingText(
            text: "Biography",
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
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
            child: normalText(
              text: doctor.biography,
              color: Colors.grey[700]!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(DoctorDetailsModel doctor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingText(
            text: "What People Say's",
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12.h),
          ...doctor.reviews.map((review) => _buildReviewCard(review)).toList(),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Patient Image
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(review.patientImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Patient Name and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    normalText(
                      text: review.patientName,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 2.h),
                    smallText(
                      text: review.date,
                      color: Colors.grey[500]!,
                    ),
                  ],
                ),
              ),

              // Rating
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: TextStyle(
                        color: Colors.amber[700],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Review Comment
          normalText(
            text: review.comment,
            color: Colors.grey[700]!,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(DoctorDetailsModel doctor) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Doctor Fee Button
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5F4),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFF00B4A6),
                  width: 1.w,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  smallText(
                    text: "Doctor Fee",
                    color: const Color(0xFF00B4A6),
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 2.h),
                  normalText(
                    text: "\$${doctor.consultationFee.toStringAsFixed(2)}",
                    color: const Color(0xFF00B4A6),
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Instant Visit Button
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                // Handle instant visit booking
                Get.snackbar(
                  "Booking Confirmed",
                  "Your appointment with ${doctor.name} has been booked!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF00B4A6),
                  colorText: Colors.white,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B4A6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: normalText(
                    text: "Instant Visit",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
// Usage Examples for Doctor Details Page

// Example 1: Navigate from booking list
class BookingListUsage {
  void onDoctorBookingTap(BookingItemModel booking) {
    // Create doctor details from booking data
    final doctorDetails = DoctorDetailsModel(
      id: "doc_${booking.name.hashCode}",
      name: booking.name,
      image: booking.image,
      rating: booking.rating,
      specialty: booking.specialty ?? "General Physician",
      location: "Your City, Country",
      experience: 5,
      patients: 800,
      biography: "Experienced ${booking.specialty ?? 'doctor'} with a passion for providing excellent healthcare services to patients.",
      consultationFee: 35.00,
      reviews: [
        ReviewModel(
          id: "rev_1",
          patientName: "John Doe",
          patientImage: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
          rating: 5.0,
          comment: "Excellent doctor with great bedside manner.",
          date: "2 days ago",
        ),
      ],
    );

    Get.to(() => DoctorDetailsPage(doctor: doctorDetails));
  }
}

// Example 2: Navigate with sample data
class SampleDataUsage {
  void navigateToSampleDoctor() {
    Get.to(() => DoctorDetailsPage()); // Uses sample data automatically
  }

  void navigateWithCustomDoctor() {
    final customDoctor = DoctorDetailsModel(
      id: "doc_custom",
      name: "Dr. Sarah Johnson",
      image: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=300&h=300&fit=crop&crop=face",
      rating: 4.7,
      specialty: "Cardiologist",
      location: "New York, USA",
      experience: 8,
      patients: 1500,
      biography: "Board-certified cardiologist with extensive experience in treating heart conditions and preventive cardiac care.",
      consultationFee: 50.00,
      reviews: [
        ReviewModel(
          id: "rev_custom_1",
          patientName: "Emily Chen",
          patientImage: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
          rating: 5.0,
          comment: "Dr. Johnson is amazing! She explained everything clearly and made me feel comfortable.",
          date: "1 week ago",
        ),
        ReviewModel(
          id: "rev_custom_2",
          patientName: "Michael Brown",
          patientImage: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
          rating: 4.5,
          comment: "Very professional and knowledgeable. Highly recommend!",
          date: "2 weeks ago",
        ),
      ],
    );

    Get.to(() => DoctorDetailsPage(doctor: customDoctor));
  }
}

// Example 3: Update booking controller to navigate to doctor details
class UpdatedCommonBookingUiController extends GetxController {
  // ... existing code ...

  // Enhanced onBookingTap to navigate to doctor details
  @override
  void onBookingTap(BookingItemModel booking) {
    print("Booking tapped: ${booking.name} - Status: ${booking.status.name}");
    
    switch (bookingType) {
      case BookingType.doctor:
        _navigateToDoctorDetails(booking);
        break;
      case BookingType.pharmacy:
        // Navigate to pharmacy details
        break;
      case BookingType.hospital:
        // Navigate to hospital details
        break;
    }
  }

  void _navigateToDoctorDetails(BookingItemModel booking) {
    final doctorDetails = DoctorDetailsModel(
      id: "doc_${booking.name.hashCode}",
      name: booking.name,
      image: booking.image,
      rating: booking.rating,
      specialty: booking.specialty ?? "General Physician",
      location: "Medical Center, Your City",
      experience: (booking.rating * 2).round(), // Example calculation
      patients: (booking.rating * 200).round(), // Example calculation
      biography: "Experienced ${booking.specialty ?? 'medical professional'} dedicated to providing comprehensive healthcare services with a focus on patient comfort and care excellence.",
      consultationFee: _calculateConsultationFee(booking.specialty),
      reviews: _generateSampleReviews(booking),
    );

    Get.to(() => DoctorDetailsPage(doctor: doctorDetails));
  }

  double _calculateConsultationFee(String? specialty) {
    switch (specialty?.toLowerCase()) {
      case 'cardiologist':
        return 60.00;
      case 'neurologist':
        return 70.00;
      case 'dermatologist':
        return 45.00;
      case 'pediatrician':
        return 40.00;
      case 'orthopedic':
        return 55.00;
      default:
        return 35.00;
    }
  }

  List<ReviewModel> _generateSampleReviews(BookingItemModel booking) {
    final sampleReviews = [
      ReviewModel(
        id: "rev_1",
        patientName: "Alice Cooper",
        patientImage: "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
        rating: 5.0,
        comment: "Excellent care and very professional approach. Highly recommended!",
        date: "3 days ago",
      ),
      ReviewModel(
        id: "rev_2",
        patientName: "Robert Wilson",
        patientImage: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
        rating: 4.5,
        comment: "Great experience, doctor was very thorough in examination.",
        date: "1 week ago",
      ),
      ReviewModel(
        id: "rev_3",
        patientName: "Maria Garcia",
        patientImage: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face",
        rating: booking.rating,
        comment: "Very satisfied with the treatment and explanation provided.",
        date: "2 weeks ago",
      ),
    ];

    return sampleReviews.take(2).toList(); // Return 2 reviews
  }
}

// Example 4: Route configuration
class DoctorDetailsRoutes {
  static void setupRoutes() {
    Get.addPages([
      GetPage(
        name: '/doctor-details',
        page: () => DoctorDetailsPage(),
        arguments: null, // Doctor data passed as arguments
      ),
      GetPage(
        name: '/doctor-details/:id',
        page: () => DoctorDetailsPage(),
        // Can fetch doctor by ID from arguments
      ),
    ]);
  }

  static void navigateWithId(String doctorId) {
    Get.toNamed('/doctor-details/$doctorId');
  }

  static void navigateWithDoctor(DoctorDetailsModel doctor) {
    Get.toNamed('/doctor-details', arguments: doctor);
  }
}

// Example 5: Integration with existing booking UI
extension BookingUIExtension on CommonStatusUi {
  // This would be added to your existing CommonStatusUi class
  void navigateToDoctorDetails(BookingItemModel booking) {
    if (bookingType == BookingType.doctor) {
      final controller = Get.find<CommonBookingUiController>();
      controller.onBookingTap(booking); // This will now navigate to doctor details
    }
  }
}
*/
