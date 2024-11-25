class UserData {
  final String email;
  final String password;

  UserData({required this.email, required this.password});

  factory UserData.fromMap(Map<String, dynamic> res) {
    return UserData(
      email: res["email"] as String,
      password: res["password"] as String,
    );
  }

  Map<String, Object> toMap() {
    return {"email": email, "password": password};
  }
}
