// hospital_booking_model.dart
import 'package:prettyrini/feature/booking_page/controller/booking_controller.dart';

class HospitalBooking {
  final String id;
  final String hospitalName;
  final double rating;
  final String description;
  final String imageUrl;
  final BookingStatus status;
  final DateTime bookingDate;
  final String appointmentTime;
  final String doctorName;
  final String department;

  HospitalBooking({
    required this.id,
    required this.hospitalName,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.bookingDate,
    required this.appointmentTime,
    required this.doctorName,
    required this.department,
  });

  // JSON serialization methods
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hospitalName': hospitalName,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl,
      'status': status.toString().split('.').last,
      'bookingDate': bookingDate.toIso8601String(),
      'appointmentTime': appointmentTime,
      'doctorName': doctorName,
      'department': department,
    };
  }

  factory HospitalBooking.fromJson(Map<String, dynamic> json) {
    return HospitalBooking(
      id: json['id'] ?? '',
      hospitalName: json['hospitalName'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      status: BookingStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => BookingStatus.ongoing,
      ),
      bookingDate: DateTime.parse(
          json['bookingDate'] ?? DateTime.now().toIso8601String()),
      appointmentTime: json['appointmentTime'] ?? '',
      doctorName: json['doctorName'] ?? '',
      department: json['department'] ?? '',
    );
  }
}
