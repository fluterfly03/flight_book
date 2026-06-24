import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/asset_constants.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
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
            icon: AssetConstants.home,
            selected: true,
          ),
          _navItem(
            icon: AssetConstants.flight,
          ),
          _navItem(
            icon: AssetConstants.map,
          ),
          _navItem(
            icon:  AssetConstants.user,
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required String icon,
    bool selected = false,
  }) {
    return Image.asset(
     icon,
      height: 20.h,
      width: 20.h,
      color: selected ? Color(0xff2A6DED) : Colors.grey,
    );
  }
}