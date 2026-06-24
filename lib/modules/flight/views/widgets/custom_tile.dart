import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CustomTile({
  required String title,
  required String value,
  required Widget icon,
  VoidCallback? onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12.r),
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                    color: Colors.black, fontSize: 16.sp,fontWeight: FontWeight.w500
                ),
              ),
            ),
            icon,
          ],
        ),
        SizedBox(height: 2.h),
        Divider(
          height: 20.h,
          thickness: 1,
          color: Colors.grey.shade300,
        ),
      ],
    ),
  );
}