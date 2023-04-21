class User {
  User({
    required this.name,
    required this.email,
    required this.picture,
    required this.desc,
  });

  String name;
  String email;
  String picture;
  String desc;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        picture: json["picture"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "picture": picture,
        "desc": desc,
      };
}
