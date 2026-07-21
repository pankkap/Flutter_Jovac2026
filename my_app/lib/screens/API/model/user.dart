class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
  });
  // Method-1: Convert json to User and  render on UI
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      website: json["website"],
    );
  }
  // Method-2: Convert User to Json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "website": website,
    };
  }
}
