class LoginModel {
  final String token;
  final String userId;
  final String? message;

  LoginModel({
    required this.token,
    required this.userId,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    // Handling extraction based on Vikn login response structure
    final data = json['data'] ?? json;
    return LoginModel(
      token: data['access'] ?? data['token'] ?? '',
      userId: data['user_id']?.toString() ?? json['user_id']?.toString() ?? '',
      message: json['message'] ?? '',
    );
  }
}
