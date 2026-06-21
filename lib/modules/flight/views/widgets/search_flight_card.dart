import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../routes/app_pages.dart';

class SearchFlightCard extends StatefulWidget {
  const SearchFlightCard({super.key});

  @override
  State<SearchFlightCard> createState() => _SearchFlightCardState();
}

class _SearchFlightCardState extends State<SearchFlightCard> {
  @override
  Widget build(BuildContext context) {
    return     Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffcddcf9),
            Colors.white,
            Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// FROM
          _locationTile(
            label: 'From',
            value: 'Jakarta (CGK)',
          ),

          SizedBox(height: 10.h),

          /// DIVIDER + SWAP BUTTON
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerRight,
            children: [
              Divider(

                thickness: 1,
                color: Colors.grey.shade300,
              ),

              Positioned(
                right: 20.w,
                child: Container(
                  height: 45.w,
                  width: 45.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                        Colors.black.withOpacity(.08),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.swap_vert,
                      color: Color(0xff6B7280),
                    ),
                    onPressed: () {
                      // swap logic
                    },
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// TO
          _locationTile(
            label: 'To',
            value: 'Tokyo (NRT)',
          ),

          Divider(
            height: 20.h,
            thickness: 1,
            color: Colors.grey.shade300,
          ),

          /// DEPARTURE + AMOUNT
          Row(
            children: [
              Expanded(
                child: _infoTile(
                  title: 'Departure',
                  value: 'Tue, 2 Apr',
                  icon: Icons.calendar_today_outlined,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _infoTile(
                  title: 'Amount',
                  value: '3 people',
                  icon: Icons.keyboard_arrow_down,
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          /// BUTTON
          SizedBox(
            width: double.infinity,
            height: 45.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(28.r),
                ),
              ),
              onPressed: () {
                Get.toNamed(Routes.flightResults);
              },
              child: Text(
                'Search flights',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _locationTile({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
          TextStyle(color: Colors.grey, fontSize: 12.sp),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _infoTile({
    required String title,
    required String value,
    required IconData icon,
  })
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
          TextStyle(color: Colors.grey, fontSize: 12.sp),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(icon, size: 16.sp)
          ],
        ),
        Divider(
          height: 20.h,
          thickness: 1,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
