import 'package:espot/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';

class HomeWorkTodayItem extends StatelessWidget {
  // final WorkTodayModel worktoday;
  final String? id;
  final String? name;
  final int? progress;
  final String? thumbnail;
  final VoidCallback? onTapAprove;
  final VoidCallback? onTapReject;

  const HomeWorkTodayItem({
    Key? key,
    // required this.worktoday,
    this.id,
    this.name,
    this.progress,
    this.thumbnail,
    this.onTapAprove,
    this.onTapReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          margin: const EdgeInsets.only(bottom: 20, top: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  thumbnail!,
                )),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name!,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  const Spacer(),
                  // Text(
                  //   '$progress% ',
                  //   style: greenTextStyle.copyWith(
                  //     fontWeight: semiBold,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: onTapReject,
                    child: Image.asset('assets/ic_close.png', cacheWidth: 30),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: onTapAprove,
                    child: Image.asset('assets/ic_check.png', cacheWidth: 30),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
