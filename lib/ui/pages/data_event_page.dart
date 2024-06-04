import 'package:espot/models/event_model.dart';
import 'package:espot/shared/constant.dart';
import 'package:espot/ui/pages/data_events_input_page.dart';
import 'package:espot/ui/widgets/data_event_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';

class DataEventPage extends StatefulWidget {
  const DataEventPage({Key? key}) : super(key: key);

  @override
  State<DataEventPage> createState() => _DataEventPageState();
}

class _DataEventPageState extends State<DataEventPage> {
  final searchController = TextEditingController(text: '');

  EventModel? selectedEvents;
  String searchResult = '';
  List<EventModel> eventsList = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
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
    }
  }

  Future<void> deleteEvents() async {
    if (selectedEvents != null) {
      String uid = selectedEvents!.uid!;
      // Dapatkan referensi ke node pengguna berdasarkan UID
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child(EVENTS).child(uid);
      // Ambil data pengguna dari Realtime Database
      DatabaseEvent event = await ref.once();
      if (event.snapshot.value != null) {
        // Hapus data pengguna dari Realtime Database
        await ref.remove();
        Navigator.pushNamed(context, '/data-success-delete');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Events',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/event-input');
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
            height: 40,
          ),
          Row(
            children: [
              Text(
                'List Events',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              const Spacer(),
              selectedEvents != null
                  ? Row(
                      children: [
                        GestureDetector(
                          child: const Icon(Icons.edit),
                          onTapUp: (details) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataEventInputPage(
                                  data: selectedEvents!,
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
                            deleteEvents();
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
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: eventsList.length,
            itemBuilder: (context, index) {
              EventModel? dataEvents = eventsList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedEvents = dataEvents;
                    print(selectedEvents!.uid);
                  });
                },
                child: DataEventItem(
                  dataEvent: dataEvents,
                  isSelected: selectedEvents != null
                      ? selectedEvents!.uid == dataEvents.uid
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
