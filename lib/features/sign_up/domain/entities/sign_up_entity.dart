class User {
  final String fullName;
  final String email;
  final String gender;
  final String birthDate;
  final String password;
  final double latitude;  // Added for location
  final double longitude; // Added for location

  User({
    required this.fullName,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.password,
    required this.latitude,   // Added for location
    required this.longitude,  // Added for location
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'birthDate': birthDate,
      'password': password,
      'latitude': latitude,  // Added for location
      'longitude': longitude, // Added for location
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
      gender: json['gender'],
      birthDate: json['birthDate'],
      password: json['password'],
      latitude: json['latitude'],  // Added for location
      longitude: json['longitude'], // Added for location
    );
  }
}
