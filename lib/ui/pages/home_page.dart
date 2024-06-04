import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:espot/ui/widgets/home_service_item.dart';
import 'package:espot/ui/widgets/home_work_today_item.dart';

class HomePage extends StatefulWidget with CacheManager {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   color: whiteColor,
      //   shape: const CircularNotchedRectangle(),
      //   clipBehavior: Clip.antiAlias,
      //   notchMargin: 6,
      //   elevation: 0,
      //   child: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     backgroundColor: whiteColor,
      //     elevation: 0,
      //     selectedItemColor: redColor,
      //     unselectedItemColor: blackColor,
      //     showSelectedLabels: true,
      //     showUnselectedLabels: true,
      //     selectedLabelStyle: blueTextStyle.copyWith(
      //       fontSize: 10,
      //       fontWeight: medium,
      //     ),
      //     unselectedLabelStyle: blackTextStyle.copyWith(
      //       fontSize: 10,
      //       fontWeight: medium,
      //     ),
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Image.asset(
      //           'assets/ic_overview.png',
      //           width: 20,
      //           color: redColor,
      //         ),
      //         label: 'Overview',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Image.asset(
      //           'assets/ic_teams.png',
      //           width: 22,
      //         ),
      //         label: 'Teams',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Image.asset(
      //           'assets/ic_event.png',
      //           width: 24,
      //         ),
      //         label: 'Event',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Image.asset(
      //           'assets/ic_notif.png',
      //           width: 20,
      //         ),
      //         label: 'Konfirmasi',
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      //   onPressed: () {},
      //   backgroundColor: redColor,
      //   child: Image.asset(
      //     'assets/ic_plus_circle.png',
      //     width: 24,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          buildProfile(context),
          const SizedBox(
            height: 50,
          ),
          // buildUsers(),
          buildServices(context),
          buildWorkToday(),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
      // }

      // return const Center(
      //   child: CircularProgressIndicator(),
      // );
      // },
      // ),
    );
  }

  Widget buildProfile(BuildContext context) {
    // return BlocBuilder<AuthBloc, AuthState>(
    //   builder: (context, state) {
    //     if (state is AuthSuccess) {
    return Container(
      margin: const EdgeInsets.only(
        top: 80,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang,',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                // state.data.name.toString(),
                '${widget.getName()}',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: widget.getPhoto() == null
                      ? const AssetImage(
                          'assets/img_admin.png',
                        )
                      : NetworkImage(widget.getPhoto()!) as ImageProvider,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildServices(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(
      top: 0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Main Menu',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeServiceItem(
              iconUrl: 'assets/ic_user.png',
              title: 'Users',
              onTap: () {
                Navigator.pushNamed(context, '/users');
              },
            ),
            HomeServiceItem(
              iconUrl: 'assets/ic_teams.png',
              title: 'Teams',
              width: 30,
              onTap: () {
                Navigator.pushNamed(context, '/users');
              },
            ),
            HomeServiceItem(
              iconUrl: 'assets/ic_event.png',
              title: 'Event',
              width: 35,
              onTap: () {
                Navigator.pushNamed(context, '/users');
              },
            ),
            HomeServiceItem(
              iconUrl: 'assets/ic_more.png',
              title: 'More',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const MoreDialog(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildWorkToday() {
  return Container(
    margin: const EdgeInsets.only(
      top: 30,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirmation',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(22),
          margin: const EdgeInsets.only(
            top: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: whiteColor,
          ),
          child: const Column(
            children: [
              HomeWorkTodayItem(
                id: 1,
                name: 'Elsa',
                progress: 10,
                thumbnail:
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
              ),
              HomeWorkTodayItem(
                id: 2,
                name: 'Agus',
                progress: 50,
                thumbnail:
                    'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg',
              ),
              HomeWorkTodayItem(
                id: 3,
                name: 'Agus',
                progress: 80,
                thumbnail:
                    'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg',
              ),
              HomeWorkTodayItem(
                id: 4,
                name: 'Elsa',
                progress: 10,
                thumbnail:
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildUsers() {
  return Container(
    margin: const EdgeInsets.only(
      top: 30,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Teams',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    ),
  );
}

Widget buildLatestNews() {
  return Container(
    margin: const EdgeInsets.only(
      top: 30,
      bottom: 50,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest News',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    ),
  );
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      content: Container(
        height: 326,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: lightBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do More Menus',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Wrap(
                spacing: 29,
                runSpacing: 25,
                children: [
                  HomeServiceItem(
                    iconUrl: 'assets/ic_user.png',
                    title: 'Users',
                    onTap: () {
                      Navigator.pushNamed(context, '/users');
                    },
                  ),
                  HomeServiceItem(
                    iconUrl: 'assets/ic_teams.png',
                    title: 'Teams',
                    onTap: () {
                      Navigator.pushNamed(context, '/teams');
                    },
                  ),
                  HomeServiceItem(
                    iconUrl: 'assets/ic_event.png',
                    title: 'Event',
                    onTap: () {
                      Navigator.pushNamed(context, '/event');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
