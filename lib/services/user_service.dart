import 'dart:convert';

import 'package:espot/models/user_model.dart';

class UserService {
  Future<List<UserModel>> getAllUsers() async {
    try {
      List<UserModel> users = [];
      users.add(UserModel(
        uid: "1",
        name: 'Andi',
        password: '123',
        phone: '087865503231',
        profilePicture:
            'https://glarts.org/wp-content/uploads/2017/10/Charley-Brown-headshot.jpg',
      ));

      users.add(UserModel(
        uid: "2",
        name: 'Rani',
        password: '123',
        phone: '087865503231',
        profilePicture:
            'https://assets-global.website-files.com/5c6f0fe289c368004b71d711/5cb7772b6c8746a0839f0ff6_nicole-bg.jpg',
      ));

      users.add(UserModel(
        uid: "3",
        name: 'Retno',
        password: '123',
        phone: '087865503231',
        profilePicture:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzE_IxEnB9pod4jTIjx95YdEPpmtX_YYcGEJaGX4-y4egrIhgdxOiYdLVkTrSlaUzmyXI&usqp=CAU',
      ));

      users.add(UserModel(
        uid: "4",
        name: 'Ahmad',
        password: '123',
        phone: '087865503231',
        profilePicture:
            'https://www.lse.ac.uk/united-states/Assets/Images/People-images/Chris-Gilson-200x200.jpg',
      ));

      return users;
    } catch (e) {
      rethrow;
    }
  }
}
