import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            icon: Icons.home,
            selected: true,
          ),
          _navItem(
            icon: Icons.flight_outlined,
          ),
          _navItem(
            icon: Icons.map_outlined,
          ),
          _navItem(
            icon: Icons.person_outline,
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    bool selected = false,
  }) {
    return Container(
      width: 28.w,
      height: 28.h,
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 18.sp,
        color: selected ? Colors.white : Colors.grey,
      ),
    );
  }
}