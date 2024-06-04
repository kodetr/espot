class UserEditFormModel {
  final String? name;
  final String? phoneNumber;
  final String? password;

  UserEditFormModel({
    this.name,
    this.phoneNumber,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}
