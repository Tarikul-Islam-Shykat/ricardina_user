import 'package:get/get.dart';

enum BookingStatus { ongoing, completed }

class BookingController extends GetxController {
  // Current selected tab
  BookingStatus selectedTab = BookingStatus.ongoing;

  // All bookings data with status
  List<BookingItemModel> allBookings = [
    // Ongoing bookings
    BookingItemModel(
      name: "Dianne Russell",
      image:
          "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
      time: "12-04-2025 | 10:20 - 10:30 PM",
      status: BookingStatus.ongoing,
    ),
    BookingItemModel(
      name: "Guy Hawkins",
      image:
          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
      time: "12-04-2025 | 10:20 - 10:30 PM",
      status: BookingStatus.ongoing,
    ),
    BookingItemModel(
      name: "Jenny Wilson",
      image:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face",
      time: "12-04-2025 | 10:20 - 10:30 PM",
      status: BookingStatus.ongoing,
    ),
    BookingItemModel(
      name: "Darlene Robertson",
      image:
          "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?w=150&h=150&fit=crop&crop=face",
      time: "12-04-2025 | 10:20 - 10:30 PM",
      status: BookingStatus.ongoing,
    ),

    // Completed bookings
    BookingItemModel(
      name: "Courtney Henry",
      image:
          "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=150&h=150&fit=crop&crop=face",
      time: "10-04-2025 | 09:15 - 09:45 AM",
      status: BookingStatus.completed,
    ),
    BookingItemModel(
      name: "Ronald Richards",
      image:
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face",
      time: "09-04-2025 | 11:30 - 12:00 PM",
      status: BookingStatus.completed,
    ),
    BookingItemModel(
      name: "Savannah Nguyen",
      image:
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face",
      time: "08-04-2025 | 02:00 - 02:30 PM",
      status: BookingStatus.completed,
    ),
    BookingItemModel(
      name: "Brooklyn Simmons",
      image:
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
      time: "07-04-2025 | 04:15 - 04:45 PM",
      status: BookingStatus.completed,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  // Load bookings data (API calls would go here)
  void loadBookings() {
    print("Loading bookings data...");
    // API call simulation
    // await fetchBookings();
    update();
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
    // Navigate to booking details
    // Get.toNamed('/booking-details', arguments: booking);
  }

  // Mark booking as completed
  void markAsCompleted(BookingItemModel booking) {
    final index = allBookings.indexOf(booking);
    if (index != -1) {
      allBookings[index] = BookingItemModel(
        name: booking.name,
        image: booking.image,
        time: booking.time,
        status: BookingStatus.completed,
      );
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
  void addBooking(
      String name, String image, String time, BookingStatus status) {
    allBookings.insert(
        0,
        BookingItemModel(
          name: name,
          image: image,
          time: time,
          status: status,
        ));
    update();
    print("New booking added: $name");
  }

  // Get booking counts
  int get ongoingCount => getOngoingBookings().length;
  int get completedCount => getCompletedBookings().length;
  int get totalCount => allBookings.length;

  // Refresh bookings
  Future<void> refreshBookings() async {
    print("Refreshing bookings...");
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

// Booking item model
class BookingItemModel {
  final String name;
  final String image;
  final String time;
  final BookingStatus status;

  BookingItemModel({
    required this.name,
    required this.image,
    required this.time,
    required this.status,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'time': time,
      'status': status.name,
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
    );
  }

  // Copy with method for updates
  BookingItemModel copyWith({
    String? name,
    String? image,
    String? time,
    BookingStatus? status,
  }) {
    return BookingItemModel(
      name: name ?? this.name,
      image: image ?? this.image,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }
}
