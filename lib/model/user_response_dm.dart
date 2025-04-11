class UserResponseDm {
  final int id;
  final String name;
  final String email;

  UserResponseDm({
    required this.id,
    required this.name,
    required this.email,
  });

  static UserResponseDm fromJson(Map<String, dynamic> json) {
    return UserResponseDm(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
