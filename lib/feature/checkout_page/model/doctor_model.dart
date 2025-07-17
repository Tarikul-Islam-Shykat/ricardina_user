// model/doctor_model.dart
class DoctorModel {
  final String id;
  final String name;
  final double hourlyRate;
  final String duration;
  final String? imageUrl;
  final String? specialty;
  final double? rating;
  final int? reviewCount;

  DoctorModel({
    required this.id,
    required this.name,
    required this.hourlyRate,
    required this.duration,
    this.imageUrl,
    this.specialty,
    this.rating,
    this.reviewCount,
  });

  // Factory constructor for creating DoctorModel from JSON
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      hourlyRate: (json['hourlyRate'] ?? json['hourly_rate'] ?? 0.0).toDouble(),
      duration: json['duration']?.toString() ?? '1 hour',
      imageUrl: json['imageUrl'] ?? json['image_url'],
      specialty: json['specialty'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? json['review_count'],
    );
  }

  // Convert DoctorModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hourlyRate': hourlyRate,
      'duration': duration,
      'imageUrl': imageUrl,
      'specialty': specialty,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }

  // Create a copy of DoctorModel with updated fields
  DoctorModel copyWith({
    String? id,
    String? name,
    double? hourlyRate,
    String? duration,
    String? imageUrl,
    String? specialty,
    double? rating,
    int? reviewCount,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
      specialty: specialty ?? this.specialty,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, hourlyRate: $hourlyRate, duration: $duration)';
  }

  // Override equality operators
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DoctorModel &&
        other.id == id &&
        other.name == name &&
        other.hourlyRate == hourlyRate &&
        other.duration == duration &&
        other.imageUrl == imageUrl &&
        other.specialty == specialty &&
        other.rating == rating &&
        other.reviewCount == reviewCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        hourlyRate.hashCode ^
        duration.hashCode ^
        imageUrl.hashCode ^
        specialty.hashCode ^
        rating.hashCode ^
        reviewCount.hashCode;
  }
}
