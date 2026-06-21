import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/flight_controller.dart';
import '../widgets/half_dotted_circle painter.dart';


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

                      // SEARCH CARD
                      Container(
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
                      )
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
                      return const FlightTicket();
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
                  _DateWidget(),
                  Spacer(),
                  _DateWidget(),
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

class _DateWidget extends StatelessWidget {
  const _DateWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: const [
        Text(
          'DATE',
          style:
          TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 8),
        Text(
          'Jan 20, 2025',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

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