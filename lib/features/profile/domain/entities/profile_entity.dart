class UserProfile {
  final String fullName;
  final String email;
  final String gender;
  final String birthDate;
  final double? latitude;
  final double? longitude;

  UserProfile({
    required this.fullName,
    required this.email,
    required this.gender,
    required this.birthDate,
    this.latitude,
    this.longitude,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json['fullName'],
      email: json['email'],
      gender: json['gender'],
      birthDate: json['birthDate'],
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'birthDate': birthDate,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
