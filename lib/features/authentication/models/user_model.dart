class UserModel {
  final String? id;
  final String? email;
  final String? userName;

  UserModel({this.id, this.email, this.userName});

  UserModel.fromData(Map<String, dynamic> data)
      : id = data["id"],
        email = data["email"],
        userName = data["userName"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "userName": userName,
    };
  }
}
