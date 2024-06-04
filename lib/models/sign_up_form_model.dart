class SignUpFormModel {
  final String? name;
  final String? phoneNumber;
  final String? password;
  final String? profilePicture;

  SignUpFormModel({
    this.name,
    this.phoneNumber,
    this.password,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'password': password,
      'profile_picture': profilePicture,
    };
  }

  SignUpFormModel copyWith({
    String? name,
    String? phoneNumber,
    String? password,
    String? profilePicture,
  }) =>
      SignUpFormModel(
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        profilePicture: profilePicture ?? this.profilePicture,
      );
}
