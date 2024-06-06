import 'package:espot/models/event_model.dart';
import 'package:espot/models/teams_model.dart';
import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/shared/snackbar.dart';
import 'package:espot/shared/theme.dart';
import 'package:espot/ui/widgets/data_event_item.dart';
import 'package:espot/ui/widgets/data_teams_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:espot/ui/widgets/home_service_item.dart';
import 'package:espot/ui/widgets/home_work_today_item.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';

class HomePage extends StatefulWidget with CacheManager {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TeamsModel> teamsList = [];
  List<EventModel> eventsList = [];
  TeamsModel? selectedTeams;
  // RxString name = ''.obs;

  @override
  void initState() {
    // name.value = widget.getName()!;

    _fetchEvents();
    _fetchTeams();
    super.initState();
  }

  Future<void> _fetchTeams() async {
    EasyLoading.show(status: 'loading...');
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child(TEAMS);
    DatabaseEvent event = await usersRef.once();

    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> eventsData =
          event.snapshot.value as Map<dynamic, dynamic>;
      List<TeamsModel> tempList = [];
      eventsData.forEach((uid, data) {
        tempList.add(TeamsModel.fromMap(data, uid));
      });

      setState(() {
        teamsList = tempList;
      });
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }

  Future<void> _fetchEvents() async {
    EasyLoading.show(status: 'loading...');
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child(EVENTS);
    DatabaseEvent event = await usersRef.once();

    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> eventsData =
          event.snapshot.value as Map<dynamic, dynamic>;
      List<EventModel> tempList = [];
      eventsData.forEach((uid, data) {
        tempList.add(EventModel.fromMap(data, uid));
      });

      setState(() {
        eventsList = tempList;
      });
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }

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
          buildServices(context, widget.getName()!),
          buildWorkToday(
            context,
            widget.getName()!,
            eventsList,
            teamsList,
          ),

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
                  image: widget.getPhoto() == ''
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

  Widget buildWorkToday(BuildContext context, String role,
      List<EventModel> eventsList, List<TeamsModel> teamsList) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            role == 'Admin' ? 'Confirmation' : 'Event',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          role == 'Admin'
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(
                    top: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: whiteColor,
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: teamsList.length,
                    itemBuilder: (contextx, index) {
                      TeamsModel? dataTeams = teamsList[index];
                      return dataTeams.verified == 0
                          ? HomeWorkTodayItem(
                              id: dataTeams.uid,
                              name: dataTeams.desc,
                              onTapAprove: () async {
                                try {
                                  EasyLoading.show(status: 'loading...');
                                  String uid = dataTeams.uid!;

                                  DatabaseReference userRef = FirebaseDatabase
                                      .instance
                                      .ref()
                                      .child(TEAMS)
                                      .child(uid);
                                  await userRef.once();
                                  await userRef.update({
                                    'verified': 1,
                                  });
                                  EasyLoading.dismiss();
                                } catch (e) {
                                  print('Error: $e');
                                  EasyLoading.dismiss();
                                  CustomSnackBar.showToast(
                                      context, 'Successfully Approved');
                                }
                                setState(() {
                                  _fetchTeams();
                                });
                              },
                              onTapReject: () async {
                                try {
                                  EasyLoading.show(status: 'loading...');
                                  String uid = dataTeams.uid!;

                                  DatabaseReference userRef = FirebaseDatabase
                                      .instance
                                      .ref()
                                      .child(TEAMS)
                                      .child(uid);
                                  await userRef.once();
                                  await userRef.update({
                                    'verified': 2,
                                  });
                                  EasyLoading.dismiss();
                                  CustomSnackBar.showToast(
                                      context, 'Successfully Reject');
                                } catch (e) {
                                  print('Error: $e');
                                  EasyLoading.dismiss();
                                }
                                setState(() {
                                  _fetchTeams();
                                });
                              },
                              thumbnail: dataTeams.image,
                            )
                          : Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child:
                                  const Center(child: Text('Data is missing')),
                            );
                    },
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: eventsList.length,
                  itemBuilder: (context, index) {
                    EventModel? dataEvents = eventsList[index];
                    return DataEventItem(
                      dataEvent: dataEvents,
                    );
                  },
                ),
        ],
      ),
    );
  }
}

Widget buildServices(BuildContext context, String role) {
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
            role == 'Admin'
                ? HomeServiceItem(
                    iconUrl: 'assets/ic_user.png',
                    title: 'Users',
                    onTap: () {
                      Navigator.pushNamed(context, '/users');
                    },
                  )
                : Container(),
            HomeServiceItem(
              iconUrl: 'assets/ic_teams.png',
              title: 'Teams',
              width: 30,
              onTap: () {
                Navigator.pushNamed(context, '/teams');
              },
            ),
            HomeServiceItem(
              iconUrl: 'assets/ic_event.png',
              title: 'Event',
              width: 35,
              onTap: () {
                Navigator.pushNamed(context, '/event');
              },
            ),
            role != 'Admin'
                ? HomeServiceItem(
                    iconUrl: 'assets/registration.png',
                    title: 'Registration',
                    width: 35,
                    onTap: () {
                      Navigator.pushNamed(context, '/teams-register-input');
                    },
                  )
                : Container(),
            role == 'Admin'
                ? HomeServiceItem(
                    iconUrl: 'assets/ic_more.png',
                    title: 'More',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const MoreDialog(),
                      );
                    },
                  )
                : Container(),
          ],
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
