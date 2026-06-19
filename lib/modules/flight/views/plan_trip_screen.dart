import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/flight_controller.dart';
import 'widgets/trip_card.dart';

class PlanTripScreen extends GetView<FlightController> {
  const PlanTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient background
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5B86F8), Color(0xFF4A73E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and profile avatar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Plan your trip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        radius: 24.r,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: const NetworkImage(
                          'https://via.placeholder.com/48',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Search card
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.95),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 20.r,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // From field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Obx(
                              () => Text(
                                controller.from.value,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // Swap button
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: controller.swapLocations,
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF5B86F8),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.swap_vert,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // To field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Obx(
                              () => Text(
                                controller.to.value,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // Departure and people row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Departure',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  'Tue, 2 Apr',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Obx(
                                  () => Text(
                                    '${controller.people.value} people',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        // Search button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.searchFlights,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                            ),
                            child: Text(
                              'Search flights',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Saved trips section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Saved trips',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'See more',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF5B86F8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.flights.length,
                        itemBuilder: (context, index) {
                          final flight = controller.flights[index];
                          return TripCard(
                            flight: flight,
                            onTap: () => controller.selectFlight(flight),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
            boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  blurRadius: 16.r,
                  offset: const Offset(0, -4),
                ),
              ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on, size: 24.sp),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flight, size: 24.sp),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hotel, size: 24.sp),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 24.sp),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
