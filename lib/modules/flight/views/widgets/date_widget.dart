import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateWidget extends StatelessWidget {
   const DateWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children:  [
        Text(
          'DATE',
          style:
          TextStyle(color: Colors.grey,fontSize: 10.sp),
        ),
        SizedBox(height: 1.h),
        Text(
          'Jan 20, 2025',
          style: TextStyle(
              fontWeight: FontWeight.w500,fontSize: 13.sp
          ),
        )
      ],
    );
  }
}