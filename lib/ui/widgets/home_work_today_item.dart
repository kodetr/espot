import 'package:espot/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';

class HomeWorkTodayItem extends StatelessWidget {
  // final WorkTodayModel worktoday;
  final String? id;
  final String? name;
  final int? progress;
  final String? thumbnail;
  final VoidCallback? onTapDetail;
  final VoidCallback? onTapAprove;
  final VoidCallback? onTapReject;

  const HomeWorkTodayItem({
    Key? key,
    // required this.worktoday,
    this.id,
    this.name,
    this.progress,
    this.thumbnail,
    this.onTapDetail,
    this.onTapAprove,
    this.onTapReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTapDetail,
          child: Container(
            width: 45,
            height: 45,
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    thumbnail!,
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      name!,
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  const Spacer(),
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
                  const SizedBox(
                    width: 5,
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
