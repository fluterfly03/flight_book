import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/flight_controller.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/date_widget.dart';
import '../widgets/flight_ticket_s_card.dart';
import '../widgets/half_dotted_circle painter.dart';
import '../widgets/info_widget.dart';
import '../widgets/search_flight_card.dart';


class PlanTripScreen extends GetView<FlightController> {
  const PlanTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4F87FF),
      bottomNavigationBar: Stack(
        children: [
          const BottomBar(),
          Positioned(
            top: 0,
            left: 24.w,
            child: Container(
              width: 90.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff4F87FF),
                Color(0xffF2F3F7),
                Color(0xffF2F3F7),
                Color(0xffF2F3F7),

              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TOP SECTION
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 25.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 28.h),
                      Row(
                        children: [
                          Text(
                            'Plan your trip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 52.w,
                            width: 52.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 28.h),
                      SearchFlightCard(),
                      // SEARCH CARD

                    ],
                  ),
                ),

                // SAVED TRIPS
                Padding(
                  padding:
                  EdgeInsets.only(left: 24.w,right:24.w,bottom: 10.h),
                  child: Row(
                    children:  [
                      Text(
                        'Saved trips',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'See more',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10.sp,
                        ),
                      )
                    ],
                  ),
                ),


                SizedBox(
                  height: 180.h,
                  child: ListView.separated(
                    padding:
                    EdgeInsets.symmetric(horizontal: 24.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (_, __) =>
                    SizedBox(width: 18.w),
                    itemBuilder: (_, __) {
                      return  FlightTicket(
                        height: 180.h,
                        width: 300.w,
                        cutPosition:100.h ,
                        headerWidget: Text(
                        'Citilink',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),bottomWidget: Row(
                        children: const [
                          Info(
                            title:
                            'DATE',
                            value: 'Jan 20, 2025',
                          ),
                          Spacer(),
                          Info(
                            title:
                            'DATE',
                            value: 'Jan 20, 2025',
                          ),
                        ],
                      ),);
                    },
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }


}





