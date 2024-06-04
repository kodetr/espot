import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';

class ProfileMenuAccessItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuAccessItem({
    Key? key,
    required this.iconUrl,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Row(
          children: [
            Image.asset(
              iconUrl,
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: greyTextStyle.copyWith(
                fontSize: 13,
                fontWeight: regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
