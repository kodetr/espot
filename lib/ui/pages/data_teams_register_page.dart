import 'package:espot/models/teams_model.dart';
import 'package:espot/shared/cache_manager.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/ui/pages/data_teams_input_page.dart';
import 'package:espot/ui/pages/data_teams_register_input_page.dart';
import 'package:espot/ui/widgets/data_teams_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DataTeamsRegisterPage extends StatefulWidget with CacheManager {
  const DataTeamsRegisterPage({Key? key}) : super(key: key);

  @override
  State<DataTeamsRegisterPage> createState() => _DataTeamsRegisterPageState();
}

class _DataTeamsRegisterPageState extends State<DataTeamsRegisterPage> {
  final searchController = TextEditingController(text: '');

  TeamsModel? selectedTeams;
  String searchResult = '';
  List<TeamsModel> teamsList = [];

  @override
  void initState() {
    super.initState();
    _fetchTeams();
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

  Future<void> deleteTeams() async {
    if (selectedTeams != null) {
      EasyLoading.show(status: 'loading...');
      String uid = selectedTeams!.uid!;
      // Dapatkan referensi ke node pengguna berdasarkan UID
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child(TEAMS).child(uid);
      // Ambil data pengguna dari Realtime Database
      DatabaseEvent event = await ref.once();
      if (event.snapshot.value != null) {
        // Hapus data pengguna dari Realtime Database
        await ref.remove();
        Navigator.pushNamed(context, '/data-success-delete');
      }
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teams',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/teams-register-input');
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
          Row(
            children: [
              // Text(
              //   'Teams',
              //   style: blackTextStyle.copyWith(
              //     fontSize: 16,
              //     fontWeight: semiBold,
              //   ),
              // ),
              const Spacer(),
              selectedTeams != null
                  ? Row(
                      children: [
                        // GestureDetector(
                        //   child: const Icon(Icons.remove_red_eye),
                        //   onTapUp: (details) {},
                        // ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        widget.getName() == 'Admin'
                            ? GestureDetector(
                                child: const Icon(Icons.edit),
                                onTapUp: (details) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DataTeamsRegisterInputPage(
                                        data: selectedTeams!,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),

                        const SizedBox(
                          width: 20,
                        ),
                        widget.getName() == 'Admin'
                            ? GestureDetector(
                                child: const Icon(Icons.delete),
                                onTapUp: (details) {
                                  EasyLoading.show(status: 'loading...');
                                  deleteTeams();
                                  EasyLoading.dismiss();
                                },
                              )
                            : Container(),
                      ],
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: teamsList.length,
            itemBuilder: (context, index) {
              TeamsModel? dataTeams = teamsList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTeams = dataTeams;
                    print(selectedTeams!.uid);
                  });
                },
                child: DataTeamsItem(
                  dataTeams: dataTeams,
                  isSelected: selectedTeams != null
                      ? selectedTeams!.uid == dataTeams.uid
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
