import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/flight_controller.dart';

class FlightResultScreen extends GetView<FlightController> {
  const FlightResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F3F6),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_back, size: 20.sp),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Text(
                    'Flight result',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.more_vert, size: 20.sp),
                  ),
                ],
              ),
            ),

            // Chips / filters row
            SizedBox(
              height: 56.h,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 4.w),
                  _buildChip('Lowest to Highest', selected: true),
                  SizedBox(width: 8.w),
                  _buildChip('Preferred airlines'),
                  SizedBox(width: 8.w),
                  _buildChip('Flight type'),
                ],
              ),
            ),

            // Results list
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.only(bottom: 24.h, top: 8.h),
                  itemCount: controller.flights.length,
                  itemBuilder: (context, index) {
                    final f = controller.flights[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.04),
                              blurRadius: 10.r,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Content
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Airline row
                                  Row(
                                    children: [
                                      // Placeholder logo circle
                                      Container(
                                        width: 40.w,
                                        height: 40.w,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            f.airline.split(' ').first,
                                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Text(
                                          f.airline,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),

                                  // Flight times row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(f.departureTime, style: TextStyle(fontSize: 14.sp, color: Color(0xFF1A73E8), fontWeight: FontWeight.w600)),
                                          SizedBox(height: 4.h),
                                          Text('${f.departureAirport} (${f.from})', style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
                                        ],
                                      ),
                                      // center icon and duration
                                      Column(
                                        children: [
                                          Icon(Icons.flight, size: 20.sp, color: Colors.blue[200]),
                                          SizedBox(height: 6.h),
                                          Text(f.duration, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(f.arrivalTime, style: TextStyle(fontSize: 14.sp, color: Color(0xFF1A73E8), fontWeight: FontWeight.w600)),
                                          SizedBox(height: 4.h),
                                          Text('${f.arrivalAirport} (${f.to})', style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                ],
                              ),
                            ),

                            Divider(height: 1, color: Colors.grey[200]),

                            // Price and action
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('\$${f.price.toStringAsFixed(0)}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Color(0xFF1A73E8))),
                                      SizedBox(height: 4.h),
                                      Text('/person', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () => controller.selectFlight(f),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                                    ),
                                    child: Text('Select flight', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // optional floating filter
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFDDE8FF),
        child: Icon(Icons.tune, color: Colors.blueAccent),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildChip(String label, {bool selected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF2F6BFF) : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: selected ? [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 6.r)] : null,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
