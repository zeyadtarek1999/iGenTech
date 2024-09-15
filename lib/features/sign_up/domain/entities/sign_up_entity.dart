class User {
  final String fullName;
  final String email;
  final String gender;
  final String birthDate;
  final String password;
  final double latitude;  
  final double longitude; 

  User({
    required this.fullName,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.password,
    required this.latitude,   
    required this.longitude,  
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'birthDate': birthDate,
      'password': password,
      'latitude': latitude,  
      'longitude': longitude, 
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
      gender: json['gender'],
      birthDate: json['birthDate'],
      password: json['password'],
      latitude: json['latitude'],  
      longitude: json['longitude'], 
    );
  }
}
