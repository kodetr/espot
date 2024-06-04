import 'package:espot/shared/constant.dart';
import 'package:espot/ui/pages/data_users_input_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:espot/models/user_model.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/data_users_item.dart';
import 'package:espot/ui/widgets/forms.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataUsersPage extends StatefulWidget {
  const DataUsersPage({Key? key}) : super(key: key);

  @override
  State<DataUsersPage> createState() => _DataUsersPageState();
}

class _DataUsersPageState extends State<DataUsersPage> {
  final searchController = TextEditingController(text: '');

  UserModel? selectedUsers;
  String searchResult = '';
  List<UserModel> usersList = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child(USERS);
    DatabaseEvent event = await usersRef.once();

    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> usersData =
          event.snapshot.value as Map<dynamic, dynamic>;
      List<UserModel> tempUsersList = [];
      usersData.forEach((uid, userData) {
        tempUsersList.add(UserModel.fromMap(userData, uid));
      });

      setState(() {
        usersList = tempUsersList;
      });
    }
  }

  Future<void> deleteUser() async {
    if (selectedUsers != null) {
      String uid = selectedUsers!.uid!;
      // Dapatkan referensi ke node pengguna berdasarkan UID
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child(USERS).child(uid);
      // Ambil data pengguna dari Realtime Database
      DatabaseEvent event = await userRef.once();
      if (event.snapshot.value != null) {
        String email = (event.snapshot.value as Map<dynamic, dynamic>)['email'];
        // Masuk kembali dengan email dan password lama pengguna
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: PASSWORDDEFAULT,
        );

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Hapus data pengguna dari Realtime Database
          await userRef.remove();
          // Hapus pengguna dari Firebase Authentication
          await user.delete();

          Navigator.pushNamed(context, '/data-success-delete');
        }
      }
    }
  }

  Future<void> searchUserByName(String name) async {
    String searchName = name.toLowerCase();

    List<UserModel> foundUsers =
        usersList.where((user) => user.name!.contains(searchName)).toList();

    if (foundUsers.isNotEmpty) {
      setState(() {
        usersList = foundUsers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/user-input');
            },
            icon: const Icon(Icons.add),
            iconSize: 30,
          )
        ],
      ),
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'Search',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          CustomFormField(
            title: 'Rido',
            isShowTitle: false,
            controller: searchController,
            onFieldSubmitted: (p0) {
              if (p0.isEmpty) {
                _fetchUsers();
              } else {
                searchUserByName(p0);
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'List Users',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              const Spacer(),
              selectedUsers != null
                  ? Row(
                      children: [
                        GestureDetector(
                          child: const Icon(Icons.edit),
                          onTapUp: (details) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataUsersInputPage(
                                  dataUser: selectedUsers!,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: const Icon(Icons.delete),
                          onTapUp: (details) {
                            deleteUser();
                          },
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // FutureBuilder<List<UserModel>>(
          //     future: getAllUsers(''),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(child: CircularProgressIndicator());
          //       } else if (snapshot.hasError) {
          //         print(snapshot.error);
          //         return Center(child: Text('Error: ${snapshot.error}'));
          //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //         return const Center(child: Text('No users available'));
          //       } else {
          //         List<UserModel> users = snapshot.data!;
          //         return ListView.builder(
          //           physics: const NeverScrollableScrollPhysics(),
          //           shrinkWrap: true,
          //           itemCount: users.length,
          //           itemBuilder: (context, index) {
          //             UserModel? dataUsers = users[index];
          //             return GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   selectedUsers = dataUsers;
          //                   print(selectedUsers!.uid);
          //                 });
          //               },
          //               child: DataUsersItem(
          //                 dataUser: dataUsers,
          //                 isSelected: selectedUsers != null
          //                     ? selectedUsers!.uid == dataUsers.uid
          //                     : false,
          //               ),
          //             );
          //           },
          //         );
          //       }
          //     }),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: usersList.length,
            itemBuilder: (context, index) {
              UserModel? dataUsers = usersList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedUsers = dataUsers;
                    print(selectedUsers!.uid);
                  });
                },
                child: DataUsersItem(
                  dataUser: dataUsers,
                  isSelected: selectedUsers != null
                      ? selectedUsers!.uid == dataUsers.uid
                      : false,
                ),
              );
            },
          ),

          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
