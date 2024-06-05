import 'package:espot/models/teams_model.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';

class DataTeamsItem extends StatelessWidget {
  final TeamsModel dataTeams;
  final bool isSelected;

  const DataTeamsItem({
    Key? key,
    required this.dataTeams,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: 155,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? redColor : whiteColor,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              // vertical: 5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataTeams.image != null
                    ? Container(
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                dataTeams.image!,
                              )),
                        ),
                      )
                    : Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/image_not.jpeg',
                              )),
                        ),
                      ),
                const SizedBox(
                  height: 23,
                ),
                Center(
                  child: DataTable(
                    clipBehavior: Clip.hardEdge,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Player ID',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Player Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('Player 1')),
                          DataCell(Text('${dataTeams.player1}')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('Player 2')),
                          DataCell(Text('${dataTeams.player2}')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('Player 3')),
                          DataCell(Text('${dataTeams.player3}')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('Player 4')),
                          DataCell(Text('${dataTeams.player4}')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('Player 5')),
                          DataCell(Text('${dataTeams.player5}')),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Description',
                    style: blackTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: medium,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    dataTeams.desc!,
                    style: blackTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: regular,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
              ],
            ),
          ),
          dataTeams.verified != 0
              ? dataTeams.verified == 1
                  ? Positioned(
                      left: 300,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Image.asset('assets/ic_check.png'),
                      ),
                    )
                  : dataTeams.verified == 2
                      ? Positioned(
                          left: 300,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Image.asset('assets/ic_close.png'),
                          ),
                        )
                      : Container()
              : Container()
        ],
      ),
    );
  }
}
