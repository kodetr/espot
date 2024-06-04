import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';

class DataUsersAccessItem extends StatelessWidget {
  final bool? isChecked;
  final String title;
  final Function(bool?)? onIsChecked;

  const DataUsersAccessItem({
    Key? key,
    this.isChecked,
    required this.title,
    this.onIsChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.red,
          checkColor: Colors.white,
          value: isChecked ?? false,
          onChanged: onIsChecked,
        ),
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
      ],
    );
  }
}
