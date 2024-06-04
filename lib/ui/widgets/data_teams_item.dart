import 'package:espot/models/event_model.dart';
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
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? redColor : whiteColor,
          width: 2,
        ),
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
    );
  }
}
