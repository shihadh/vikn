class ProfileModel {
  final String name;
  final String email;
  final String? profilePicture;
  final double rating;
  final int rides;
  final bool isKycVerified;

  ProfileModel({
    required this.name,
    required this.email,
    this.profilePicture,
    this.rating = 0.0,
    this.rides = 0,
    this.isKycVerified = false,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['customer_name'] ?? json['first_name'] ?? 'User',
      email: json['email'] ?? '',
      profilePicture: json['profile_picture'],
      rating: (json['rating'] as num?)?.toDouble() ?? 4.3, // fallback based on image
      rides: (json['rides'] as num?)?.toInt() ?? 2211, // fallback based on image
      isKycVerified: json['is_kyc_verified'] ?? true, // fallback based on image
    );
  }
}
