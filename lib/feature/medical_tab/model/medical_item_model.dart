class MedicalItem {
  final String name;
  final double rating;
  final String description;
  final String imageUrl;
  final String type; // 'hospital', 'pharmacy', 'doctor'

  MedicalItem({
    required this.name,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.type,
  });

  // Optional: Add methods for serialization if needed
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl,
      'type': type,
    };
  }

  factory MedicalItem.fromJson(Map<String, dynamic> json) {
    return MedicalItem(
      name: json['name'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
