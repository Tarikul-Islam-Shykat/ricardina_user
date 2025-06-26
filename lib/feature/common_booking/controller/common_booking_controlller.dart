import 'package:get/get.dart';

enum BookingStatus { ongoing, completed }

enum BookingType { pharmacy, hospital, doctor }

class CommonBookingUiController extends GetxController {
  // Current selected tab
  BookingStatus selectedTab = BookingStatus.ongoing;

  // Booking type - set this when initializing the controller
  BookingType bookingType = BookingType.doctor;

  // All bookings data with status
  List<BookingItemModel> allBookings = [];

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  // Initialize controller with specific booking type
  void initializeWithType(BookingType type) {
    bookingType = type;
    loadBookings();
  }

  // Load bookings data based on type
  void loadBookings() {
    print("Loading ${bookingType.name} bookings data...");

    switch (bookingType) {
      case BookingType.doctor:
        allBookings = _getDoctorBookings();
        break;
      case BookingType.pharmacy:
        allBookings = _getPharmacyBookings();
        break;
      case BookingType.hospital:
        allBookings = _getHospitalBookings();
        break;
    }

    update();
  }

  // Doctor bookings data
  List<BookingItemModel> _getDoctorBookings() {
    return [
      // Ongoing doctor appointments
      BookingItemModel(
        name: "Dr. Dianne Russell",
        image:
            "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
        time: "12-04-2025 | 10:20 - 10:30 PM",
        status: BookingStatus.ongoing,
        rating: 4.8,
        specialty: "Cardiologist",
      ),
      BookingItemModel(
        name: "Dr. Guy Hawkins",
        image:
            "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
        time: "12-04-2025 | 10:20 - 10:30 PM",
        status: BookingStatus.ongoing,
        rating: 4.6,
        specialty: "Neurologist",
      ),
      BookingItemModel(
        name: "Dr. Jenny Wilson",
        image:
            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face",
        time: "12-04-2025 | 10:20 - 10:30 PM",
        status: BookingStatus.ongoing,
        rating: 4.9,
        specialty: "Pediatrician",
      ),

      // Completed doctor appointments
      BookingItemModel(
        name: "Dr. Courtney Henry",
        image:
            "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=150&h=150&fit=crop&crop=face",
        time: "10-04-2025 | 09:15 - 09:45 AM",
        status: BookingStatus.completed,
        rating: 4.7,
        specialty: "Dermatologist",
      ),
      BookingItemModel(
        name: "Dr. Ronald Richards",
        image:
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face",
        time: "09-04-2025 | 11:30 - 12:00 PM",
        status: BookingStatus.completed,
        rating: 4.5,
        specialty: "Orthopedic",
      ),
    ];
  }

  // Pharmacy bookings data
  List<BookingItemModel> _getPharmacyBookings() {
    return [
      // Ongoing pharmacy orders
      BookingItemModel(
        name: "MediCare Pharmacy",
        image:
            "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=150&h=150&fit=crop",
        time: "12-04-2025 | Order #12345",
        status: BookingStatus.ongoing,
        rating: 4.3,
        specialty: "Prescription Ready",
      ),
      BookingItemModel(
        name: "HealthPlus Pharmacy",
        image:
            "https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=150&h=150&fit=crop",
        time: "12-04-2025 | Order #12346",
        status: BookingStatus.ongoing,
        rating: 4.1,
        specialty: "Processing Order",
      ),

      // Completed pharmacy orders
      BookingItemModel(
        name: "City Pharmacy",
        image:
            "https://images.unsplash.com/photo-1631549916768-4119b2e5f926?w=150&h=150&fit=crop",
        time: "10-04-2025 | Order #12340",
        status: BookingStatus.completed,
        rating: 4.6,
        specialty: "Order Delivered",
      ),
      BookingItemModel(
        name: "Quick Meds Pharmacy",
        image:
            "https://images.unsplash.com/photo-1576602976047-174e57a47881?w=150&h=150&fit=crop",
        time: "09-04-2025 | Order #12339",
        status: BookingStatus.completed,
        rating: 4.4,
        specialty: "Order Delivered",
      ),
    ];
  }

  // Hospital bookings data
  List<BookingItemModel> _getHospitalBookings() {
    return [
      // Ongoing hospital appointments
      BookingItemModel(
        name: "City General Hospital",
        image:
            "https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=150&h=150&fit=crop",
        time: "12-04-2025 | 10:20 - 10:30 PM",
        status: BookingStatus.ongoing,
        rating: 4.5,
        specialty: "Emergency Room",
      ),
      BookingItemModel(
        name: "Metro Health Center",
        image:
            "https://images.unsplash.com/photo-1538108149393-fbbd81895907?w=150&h=150&fit=crop",
        time: "12-04-2025 | 11:00 - 11:30 AM",
        status: BookingStatus.ongoing,
        rating: 4.2,
        specialty: "Radiology Dept",
      ),

      // Completed hospital visits
      BookingItemModel(
        name: "Central Medical Hospital",
        image:
            "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=150&h=150&fit=crop",
        time: "10-04-2025 | 09:15 - 09:45 AM",
        status: BookingStatus.completed,
        rating: 4.8,
        specialty: "Surgery Dept",
      ),
      BookingItemModel(
        name: "Regional Health Hospital",
        image:
            "https://images.unsplash.com/photo-1586773860418-d37222d8fce3?w=150&h=150&fit=crop",
        time: "09-04-2025 | 11:30 - 12:00 PM",
        status: BookingStatus.completed,
        rating: 4.3,
        specialty: "Cardiology Dept",
      ),
    ];
  }

  // Change tab and filter data
  void changeTab(BookingStatus status) {
    selectedTab = status;
    print("Tab changed to: ${status.name}");
    update(); // Update UI
  }

  // Get filtered bookings based on selected tab
  List<BookingItemModel> getFilteredBookings() {
    return allBookings
        .where((booking) => booking.status == selectedTab)
        .toList();
  }

  // Get ongoing bookings
  List<BookingItemModel> getOngoingBookings() {
    return allBookings
        .where((booking) => booking.status == BookingStatus.ongoing)
        .toList();
  }

  // Get completed bookings
  List<BookingItemModel> getCompletedBookings() {
    return allBookings
        .where((booking) => booking.status == BookingStatus.completed)
        .toList();
  }

  // Handle booking item tap
  void onBookingTap(BookingItemModel booking) {
    print("Booking tapped: ${booking.name} - Status: ${booking.status.name}");
    // Navigate to booking details based on type
    switch (bookingType) {
      case BookingType.doctor:
        // Get.toNamed('/doctor-details', arguments: booking);
        break;
      case BookingType.pharmacy:
        // Get.toNamed('/pharmacy-details', arguments: booking);
        break;
      case BookingType.hospital:
        // Get.toNamed('/hospital-details', arguments: booking);
        break;
    }
  }

  // Mark booking as completed
  void markAsCompleted(BookingItemModel booking) {
    final index = allBookings.indexOf(booking);
    if (index != -1) {
      allBookings[index] = booking.copyWith(status: BookingStatus.completed);
      update();
      print("Booking marked as completed: ${booking.name}");
    }
  }

  // Cancel booking (remove from list)
  void cancelBooking(BookingItemModel booking) {
    allBookings.remove(booking);
    update();
    print("Booking cancelled: ${booking.name}");
  }

  // Add new booking
  void addBooking({
    required String name,
    required String image,
    required String time,
    required BookingStatus status,
    double rating = 0.0,
    String? specialty,
  }) {
    allBookings.insert(
        0,
        BookingItemModel(
          name: name,
          image: image,
          time: time,
          status: status,
          rating: rating,
          specialty: specialty,
        ));
    update();
    print("New booking added: $name");
  }

  // Get booking counts
  int get ongoingCount => getOngoingBookings().length;
  int get completedCount => getCompletedBookings().length;
  int get totalCount => allBookings.length;

  // Get booking type display name
  String get bookingTypeDisplayName {
    switch (bookingType) {
      case BookingType.doctor:
        return "Doctor Appointments";
      case BookingType.pharmacy:
        return "Pharmacy Orders";
      case BookingType.hospital:
        return "Hospital Visits";
    }
  }

  // Get tab names based on booking type
  String get ongoingTabName {
    switch (bookingType) {
      case BookingType.doctor:
        return "Upcoming";
      case BookingType.pharmacy:
        return "Processing";
      case BookingType.hospital:
        return "Scheduled";
    }
  }

  String get completedTabName {
    switch (bookingType) {
      case BookingType.doctor:
        return "Completed";
      case BookingType.pharmacy:
        return "Delivered";
      case BookingType.hospital:
        return "Visited";
    }
  }

  // Refresh bookings
  Future<void> refreshBookings() async {
    print("Refreshing ${bookingType.name} bookings...");
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call
    loadBookings();
  }

  // Search bookings by name
  List<BookingItemModel> searchBookings(String query) {
    if (query.isEmpty) return getFilteredBookings();

    return getFilteredBookings()
        .where((booking) =>
            booking.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

// Enhanced Booking item model with rating
class BookingItemModel {
  final String name;
  final String image;
  final String time;
  final BookingStatus status;
  final double rating;
  final String? specialty;

  BookingItemModel({
    required this.name,
    required this.image,
    required this.time,
    required this.status,
    this.rating = 0.0,
    this.specialty,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'time': time,
      'status': status.name,
      'rating': rating,
      'specialty': specialty,
    };
  }

  // Create from JSON
  factory BookingItemModel.fromJson(Map<String, dynamic> json) {
    return BookingItemModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      time: json['time'] ?? '',
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.ongoing,
      ),
      rating: (json['rating'] ?? 0.0).toDouble(),
      specialty: json['specialty'],
    );
  }

  // Copy with method for updates
  BookingItemModel copyWith({
    String? name,
    String? image,
    String? time,
    BookingStatus? status,
    double? rating,
    String? specialty,
  }) {
    return BookingItemModel(
      name: name ?? this.name,
      image: image ?? this.image,
      time: time ?? this.time,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      specialty: specialty ?? this.specialty,
    );
  }
}
