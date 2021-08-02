class UserModel {
  late String name, id, email, image, password;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
  });

  UserModel.login({
    required this.email,
    required this.password,
  });

  UserModel.anotherObj({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    this.id = data["id"];
    this.name = data["name"];
    this.email = data["email"];
    this.image = data["image"];
  }

  static Map<String, dynamic> toJson(UserModel model) => {
        "id": model.id,
        "name": model.name,
        "email": model.email,
        "image": model.image,
      };
}
