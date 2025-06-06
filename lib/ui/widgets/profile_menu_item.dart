import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final String? value;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    Key? key,
    required this.iconUrl,
    required this.title,
    this.value = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
        ),
        child: Row(
          children: [
            Image.asset(
              iconUrl,
              width: 20,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    style: blackTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    value!,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: greyTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: regular,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
