class UserModel {
  late String name;
  late int id;

  UserModel({required this.name, required this.id});

  UserModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    id = map['id'];
  }
}
