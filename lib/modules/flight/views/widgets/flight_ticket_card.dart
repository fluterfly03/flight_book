
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/flight_listing_screen.dart';
import 'half_dotted_circle painter.dart';
import 'info_widget.dart';

class FlightTicketCard extends StatelessWidget {
  final Widget bottomWidget;
  final Widget headerWidget;
  final double cutPosition;
  final double height;
  final double width;
  final Flight flight;
  const FlightTicketCard({super.key,required this.bottomWidget,required this.headerWidget, required this.cutPosition,required this.height, required this.width,required this.flight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
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
              headerWidget,
              SizedBox(height:12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _airportInfo(
                      time: flight.departureTime,
                      code: flight.departureCode,
                      city:flight.departureCity,
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
                      child: _airportInfo(
                        time: flight.departureTime,
                        code: flight.departureCode,
                        city:flight.departureCity,
                        isRight: true,
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 15.h),
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
              SizedBox(height: 15.h),
              bottomWidget
            ],
          ),
        ),
        Positioned(
          left: -14.w,
          top: cutPosition,
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: const Color(0xffF5F5F7),
          ),
        ),
        Positioned(
          right: -14.w,
          top: cutPosition,
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: const Color(0xffF5F5F7),
          ),
        ),
      ],
    );
  }

  Widget _airportInfo({
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