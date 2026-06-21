import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info extends StatelessWidget {
  final String title;
  final String value;

  const Info({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children:  [
        Text(
          title,
          style:
          TextStyle(color: Colors.grey,fontSize: 10.sp),
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.w500,fontSize: 13.sp
          ),
        )
      ],
    );
  }
}