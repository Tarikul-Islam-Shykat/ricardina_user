// Doctor Details Data Model
class DoctorDetailsModel {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String specialty;
  final String location;
  final int experience;
  final int patients;
  final String biography;
  final List<ReviewModel> reviews;
  final double consultationFee;
  final bool isAvailable;
  final List<String> availableTimes;

  DoctorDetailsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.specialty,
    required this.location,
    required this.experience,
    required this.patients,
    required this.biography,
    required this.reviews,
    required this.consultationFee,
    this.isAvailable = true,
    this.availableTimes = const [],
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'specialty': specialty,
      'location': location,
      'experience': experience,
      'patients': patients,
      'biography': biography,
      'reviews': reviews.map((r) => r.toJson()).toList(),
      'consultationFee': consultationFee,
      'isAvailable': isAvailable,
      'availableTimes': availableTimes,
    };
  }

  // Create from JSON
  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      specialty: json['specialty'] ?? '',
      location: json['location'] ?? '',
      experience: json['experience'] ?? 0,
      patients: json['patients'] ?? 0,
      biography: json['biography'] ?? '',
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((r) => ReviewModel.fromJson(r))
              .toList() ??
          [],
      consultationFee: (json['consultationFee'] ?? 0.0).toDouble(),
      isAvailable: json['isAvailable'] ?? true,
      availableTimes: List<String>.from(json['availableTimes'] ?? []),
    );
  }

  // Sample data
  static DoctorDetailsModel getSampleDoctor() {
    return DoctorDetailsModel(
      id: "doc_001",
      name: "Dr. Soman Lee",
      image:
          "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=300&h=300&fit=crop&crop=face",
      rating: 4.9,
      specialty: "Gynecology Specialist",
      location: "Los Angeles, USA",
      experience: 6,
      patients: 1002,
      biography:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor.",
      consultationFee: 30.00,
      isAvailable: true,
      availableTimes: [
        "09:00 AM",
        "10:00 AM",
        "11:00 AM",
        "02:00 PM",
        "03:00 PM",
        "04:00 PM"
      ],
      reviews: [
        ReviewModel(
          id: "rev_001",
          patientName: "Dianne Russell",
          patientImage:
              "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
          rating: 5.0,
          comment:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
          date: "On 23 March",
        ),
        ReviewModel(
          id: "rev_002",
          patientName: "Annette Black",
          patientImage:
              "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face",
          rating: 4.0,
          comment:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
          date: "On 20 March",
        ),
      ],
    );
  }
}

// Review Model
class ReviewModel {
  final String id;
  final String patientName;
  final String patientImage;
  final double rating;
  final String comment;
  final String date;

  ReviewModel({
    required this.id,
    required this.patientName,
    required this.patientImage,
    required this.rating,
    required this.comment,
    required this.date,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'patientImage': patientImage,
      'rating': rating,
      'comment': comment,
      'date': date,
    };
  }

  // Create from JSON
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      patientName: json['patientName'] ?? '',
      patientImage: json['patientImage'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
