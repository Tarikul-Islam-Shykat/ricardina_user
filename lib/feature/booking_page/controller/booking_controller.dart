// hospital_booking_controller.dart
import 'package:get/get.dart';
import 'package:prettyrini/feature/booking_page/model/booking_model.dart';

enum BookingStatus { ongoing, completed }

class HospitalBookingController extends GetxController {
  var selectedStatus = BookingStatus.ongoing.obs;
  var bookings = <HospitalBooking>[].obs;
  var isLoading = false.obs;

  // Sample data
  final List<HospitalBooking> allBookings = [
    // Ongoing Bookings
    HospitalBooking(
      id: '1',
      hospitalName: 'Johns Hopkins Hospital',
      rating: 4.9,
      description:
          'Cardiology consultation with Dr. Sarah Johnson. Follow-up appointment for heart condition monitoring.',
      imageUrl:
          'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=300',
      status: BookingStatus.ongoing,
      bookingDate: DateTime.now().add(Duration(days: 2)),
      appointmentTime: '10:30 AM',
      doctorName: 'Dr. Sarah Johnson',
      department: 'Cardiology',
    ),
    HospitalBooking(
      id: '2',
      hospitalName: 'Cleveland Clinic',
      rating: 4.8,
      description:
          'Neurology appointment with Dr. Michael Chen for headache assessment and treatment plan.',
      imageUrl:
          'https://images.unsplash.com/photo-1551190822-a9333d879b1f?w=300',
      status: BookingStatus.ongoing,
      bookingDate: DateTime.now().add(Duration(days: 5)),
      appointmentTime: '2:15 PM',
      doctorName: 'Dr. Michael Chen',
      department: 'Neurology',
    ),
    HospitalBooking(
      id: '3',
      hospitalName: 'Mount Sinai Hospital',
      rating: 4.7,
      description:
          'Orthopedic consultation for knee pain evaluation and possible treatment options.',
      imageUrl:
          'https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=300',
      status: BookingStatus.ongoing,
      bookingDate: DateTime.now().add(Duration(days: 7)),
      appointmentTime: '11:00 AM',
      doctorName: 'Dr. James Wilson',
      department: 'Orthopedics',
    ),

    // Completed Bookings
    HospitalBooking(
      id: '4',
      hospitalName: 'Toronto General Hospital',
      rating: 4.6,
      description:
          'General health checkup completed. All tests results normal. Next visit scheduled in 6 months.',
      imageUrl:
          'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=300',
      status: BookingStatus.completed,
      bookingDate: DateTime.now().subtract(Duration(days: 10)),
      appointmentTime: '9:00 AM',
      doctorName: 'Dr. Emily Rodriguez',
      department: 'General Medicine',
    ),
    HospitalBooking(
      id: '5',
      hospitalName: 'Massachusetts General Hospital',
      rating: 4.8,
      description:
          'Dermatology appointment completed. Skin condition treated successfully with prescribed medication.',
      imageUrl:
          'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=300',
      status: BookingStatus.completed,
      bookingDate: DateTime.now().subtract(Duration(days: 15)),
      appointmentTime: '3:30 PM',
      doctorName: 'Dr. Lisa Parker',
      department: 'Dermatology',
    ),
    HospitalBooking(
      id: '6',
      hospitalName: 'Mayo Clinic',
      rating: 4.9,
      description:
          'Endocrinology consultation completed. Diabetes management plan updated with new medications.',
      imageUrl:
          'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=300',
      status: BookingStatus.completed,
      bookingDate: DateTime.now().subtract(Duration(days: 20)),
      appointmentTime: '1:45 PM',
      doctorName: 'Dr. Robert Kim',
      department: 'Endocrinology',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    updateBookingsList();
  }

  void changeStatus(BookingStatus status) {
    selectedStatus.value = status;
    updateBookingsList();
  }

  void updateBookingsList() {
    isLoading.value = true;

    // Simulate loading delay
    Future.delayed(Duration(milliseconds: 300), () {
      bookings.value = allBookings
          .where((booking) => booking.status == selectedStatus.value)
          .toList();
      isLoading.value = false;
    });
  }

  String getFormattedDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final bookingDay = DateTime(date.year, date.month, date.day);

    if (bookingDay == today) {
      return 'Today';
    } else if (bookingDay == today.add(Duration(days: 1))) {
      return 'Tomorrow';
    } else if (bookingDay.isBefore(today)) {
      final difference = today.difference(bookingDay).inDays;
      return '$difference days ago';
    } else {
      final difference = bookingDay.difference(today).inDays;
      return 'In $difference days';
    }
  }
}
