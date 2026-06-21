
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'date_widget.dart';
import 'half_dotted_circle painter.dart';

class FlightTicket extends StatelessWidget {
  const FlightTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300.w,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 25,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            children: [
              Text(
                'Citilink',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _timeColumn(
                      time: '07:47',
                      code: 'CGK',
                      city: 'Jakarta',
                      isRight: false,
                    ),
                  ),


                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40.w,
                        height: 35.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: Size(40.w, 40.w),
                              painter: HalfDottedCirclePainter(),
                            ),
                            Image.asset(
                              'assets/images/airplane.png',height: 20.h,color: const Color(0xff2F6BFF),
                            )
                          ],
                        ),
                      ),


                      Text(
                        '7h 15m',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Expanded(

                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _timeColumn(
                        time: '14:30',
                        code: 'NRT',
                        city: 'Tokyo',
                        isRight: true,
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 13.h),
              /// DOTTED LINE
              LayoutBuilder(
                builder: (_, constraints) {
                  return Row(
                    children: List.generate(
                      (constraints.maxWidth /
                          8)
                          .floor(),
                          (index) => Expanded(
                        child: Container(
                          margin:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 2,
                          ),
                          height: 1,
                          color: Colors.grey
                              .shade300,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 13.h),
              Row(
                children: const [
                  DateWidget(),
                  Spacer(),
                  DateWidget(),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: -14.w,
          top: 95.h,
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: const Color(0xffF5F5F7),
          ),
        ),
        Positioned(
          right: -14.w,
          top: 95.h,
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: const Color(0xffF5F5F7),
          ),
        ),
      ],
    );
  }

  Widget _timeColumn({
    required String time,
    required String code,
    required String city,
    required bool isRight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
        Text(
          time,
          style: TextStyle(
            color: const Color(0xff2F6BFF),
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              code,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            SizedBox(width: 4.w),

            Text(
              '($city)',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}