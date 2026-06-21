import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarr extends StatelessWidget {
  const CustomAppBarr({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _circleButton(
          Icons.arrow_back_ios_new,
        ),
        const Spacer(),
         Text(
          'Your flight details',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        const SizedBox(width: 50),
      ],
    );
  }
  static Widget _circleButton(
      IconData icon,
      ) {
    return Container(
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
    );
  }
}
