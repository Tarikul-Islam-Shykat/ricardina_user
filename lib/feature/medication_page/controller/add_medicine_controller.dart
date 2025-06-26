import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMedicineController extends GetxController {
  // Text controllers
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController dailyDoseController = TextEditingController();

  // Observable variables
  final RxList<TimeOfDay> doseTimes = <TimeOfDay>[
    const TimeOfDay(hour: 13, minute: 0), // Default to 1:00 PM
  ].obs;

  final RxString selectedFrequency = 'Daily'.obs;

  final List<String> frequencies = [
    'Daily',
    'Weekly',
    'Monthly',
    'As needed',
  ];

  @override
  void onInit() {
    super.onInit();
    // Set default values
    medicineNameController.text = 'Atorvastatin - 20 mg';
    dailyDoseController.text = '02';
  }

  @override
  void onClose() {
    medicineNameController.dispose();
    dailyDoseController.dispose();
    super.onClose();
  }

  // Add new time slot
  void addTime() {
    doseTimes.add(const TimeOfDay(hour: 13, minute: 0));
  }

  // Remove time slot
  void removeTime(int index) {
    if (doseTimes.length > 1) {
      doseTimes.removeAt(index);
    }
  }

  // Select time using time picker
  Future<void> selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: doseTimes[index],
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != doseTimes[index]) {
      doseTimes[index] = picked;
    }
  }

  // Format time for display
  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '${hour == 0 ? 12 : hour}:$minute $period';
  }

  // Save medicine data
  void saveMedicine() {
    final medicineData = {
      'name': medicineNameController.text,
      'dailyDose': dailyDoseController.text,
      'times': doseTimes.map((time) => formatTime(time)).toList(),
      'frequency': selectedFrequency.value,
    };

    // Here you would typically save to your database or state management
    print('Saving medicine: $medicineData');

    Get.snackbar(
      'Success',
      'Medicine added successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );

    // Reset form
    resetForm();
  }

  // Reset form to default values
  void resetForm() {
    medicineNameController.clear();
    dailyDoseController.clear();
    doseTimes.value = [const TimeOfDay(hour: 13, minute: 0)];
    selectedFrequency.value = 'Daily';
  }
}
