import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/profile_menu_item.dart';

class DataUsersDetailPage extends StatelessWidget {
  const DataUsersDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'User Detail',
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 22,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          //   image: state.data.profilePicture == null
                          //       ? const AssetImage(
                          //           'assets/img_profile.png',
                          //         )
                          //       : NetworkImage(state.data.profilePicture!)
                          //           as ImageProvider,
                          // ),
                          image: AssetImage(
                        'assets/img_profile.png',
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Tanwir',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const ProfileMenuItem(
                      iconUrl: 'assets/ic_email.png',
                      title: 'Email',
                      value: 'admin@gmail.com'),
                  const ProfileMenuItem(
                      iconUrl: 'assets/ic_phone.png',
                      title: 'Nomor Ponsel',
                      value: '087865503234'),
                  CustomFilledButton(
                    title: 'Edit User',
                    onPressed: () {
                      Navigator.pushNamed(context, '/user-input');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DataUsersItem(
                      //       dataUser: selectedUsers!,
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
