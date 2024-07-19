import 'package:chat_call_app/utils/colors.dart';

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  bool loading;
  RoundButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            color: AppColor.buttonColor,
            //shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColor.whiteColor,
                )
              : Text(
                  title,
                  style: TextStyle(color: AppColor.whiteColor),
                ),
        ),
      ),
    );
  }
}
