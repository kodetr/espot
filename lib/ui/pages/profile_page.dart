import 'package:espot/shared/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:espot/models/sign_up_form_model.dart';
import 'package:espot/models/user_model.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/pages/profile_edit_page.dart';
import 'package:espot/ui/pages/profile_edit_password_page.dart';
import 'package:espot/ui/pages/profile_edit_photo_page.dart';
import 'package:espot/ui/widgets/buttons.dart';
import 'package:espot/ui/widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget with CacheManager {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Profile',
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileEditPhotoPage(
                            data: SignUpFormModel(
                              name: '${getName()}',
                              phoneNumber: '${getPHONE()}',
                              password: '',
                              profilePicture: '',
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: getPhoto() == ''
                              ? const AssetImage(
                                  'assets/img_admin.png',
                                )
                              : NetworkImage(getPhoto()!) as ImageProvider,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: whiteColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check_circle,
                              color: greenColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${getName()}',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ProfileMenuItem(
                      iconUrl: 'assets/ic_email.png',
                      title: 'Email',
                      value: '${getEmail()}'),
                  ProfileMenuItem(
                      iconUrl: 'assets/ic_phone.png',
                      title: 'Nomor Ponsel',
                      value: '${getPHONE()}'),
                  getName() != 'Admin'
                      ? ProfileMenuItem(
                          iconUrl: 'assets/ic_edit_profile.png',
                          title: 'Edit Profile',
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileEditPage(
                                  data: UserModel(
                                    uid: "1",
                                    name: '',
                                    phone: '',
                                    password: '',
                                    profilePicture: '',
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                  getName() != 'Admin'
                      ? ProfileMenuItem(
                          iconUrl: 'assets/ic_password.png',
                          title: 'Ganti Password',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileEditPasswordPage(
                                  data: UserModel(
                                    uid: "1",
                                    password: '123',
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                  ProfileMenuItem(
                    iconUrl: 'assets/ic_logout.png',
                    title: 'Log Out',
                    onTap: () async {
                      await removeAll();
                      Navigator.pushNamed(context, '/sign-in');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextButton(
              title: 'Report a Problem',
              onPressed: () {},
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ));
  }
}
