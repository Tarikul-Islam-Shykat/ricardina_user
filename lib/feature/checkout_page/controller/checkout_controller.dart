// controller/checkout_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prettyrini/feature/checkout_page/model/doctor_model.dart';

// controller/checkout_controller.da
class CheckoutController extends GetxController {
  // Observable variables
  var selectedDoctor = DoctorModel(
    id: '1',
    name: 'DR C. DELOITRE',
    hourlyRate: 30.0,
    duration: '1 hour',
    imageUrl: null,
  ).obs;

  var selectedDate = '12-04-2025'.obs;
  var selectedTimeSlots = RxList<String>([]);
  var isLoading = false.obs;

  // Available time slots
  final List<String> timeSlots = [
    '11:00 - 12:00',
    '01:00 - 02:00',
    '02:00 - 03:00',
    '03:00 - 04:00',
    '04:00 - 05:00',
    '06:00 - 07:00',
    '07:00 - 08:00',
    '08:00 - 09:00',
    '09:00 - 10:00',
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize with default doctor if needed
    loadDoctorData();
  }

  void loadDoctorData() {
    // Load doctor data from arguments or API
    final doctorData = Get.arguments;
    if (doctorData != null && doctorData is DoctorModel) {
      selectedDoctor.value = doctorData;
    }
  }

  void goBack() {
    Get.back();
  }

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Get.theme.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      selectedDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
      // Clear selected time slots when date changes
      selectedTimeSlots.clear();
    }
  }

  void toggleTimeSlot(String timeSlot) {
    if (selectedTimeSlots.contains(timeSlot)) {
      selectedTimeSlots.remove(timeSlot);
    } else {
      selectedTimeSlots.add(timeSlot);
    }
  }

  void removeTimeSlot(String timeSlot) {
    selectedTimeSlots.remove(timeSlot);
  }

  void clearAllTimeSlots() {
    selectedTimeSlots.clear();
  }

  void confirmBooking() async {
    if (selectedTimeSlots.isEmpty) {
      _showErrorSnackbar('Please select at least one time slot');
      return;
    }

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Create booking data
      final bookingData = {
        'doctor': selectedDoctor.value.toJson(),
        'date': selectedDate.value,
        'timeSlots': selectedTimeSlots.toList(),
        'totalSlots': selectedTimeSlots.length,
        'totalAmount': _calculateTotalAmount(),
      };

      // Navigate to booking summary or payment screen
      Get.toNamed('/booking-summary', arguments: bookingData);

      _showSuccessSnackbar('Booking confirmed successfully!');
    } catch (e) {
      _showErrorSnackbar('Failed to confirm booking. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  double _calculateTotalAmount() {
    return selectedDoctor.value.hourlyRate * selectedTimeSlots.length;
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  // Getter for formatted selected time slots
  String get selectedTimeSlotsText {
    if (selectedTimeSlots.isEmpty) {
      return 'No time slots selected';
    }
    return selectedTimeSlots.join(', ');
  }

  // Getter for total booking amount
  String get totalAmountText {
    final total = _calculateTotalAmount();
    return '\$${total.toInt()}';
  }

  // Getter for booking summary
  String get bookingSummary {
    return '${selectedTimeSlots.length} slot(s) selected for ${selectedDate.value}';
  }
}
