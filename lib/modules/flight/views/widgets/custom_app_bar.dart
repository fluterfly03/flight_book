import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? trailingWidget;
  const CustomAppBar({super.key,required this.title,this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _circleButton(
          Icons.arrow_back_ios_new,
        ),
        const Spacer(),
         Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        trailingWidget??
        const SizedBox(width: 50),
      ],
    );
  }
  static Widget _circleButton(
      IconData icon,
      ) {
    return GestureDetector(
      onTap: ()=>Get.back(),

      child: Container(
        width: 40.h,
        height: 40.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18.h,
          color: Colors.grey,
        ),
      ),
    );
  }
}
