import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/flight_controller.dart';

class FlightDetailsScreen extends GetView<FlightController> {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flight = controller.selectedFlight.value;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F3F6),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_back, size: 20.sp, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Your flight details',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 44.w),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: [
                    // Flight card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    flight?.airline.split(' ').first ?? 'Air',
                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      flight?.airline ?? 'No Flight Selected',
                                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text('ID3242113', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                  ],
                                ),
                              ),
                              // empty placeholder for right align
                              SizedBox(width: 8.w),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          // Times row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(flight?.departureTime ?? '01:30 AM', style: TextStyle(fontSize: 12.sp, color: Color(0xFF1A73E8), fontWeight: FontWeight.w700)),
                                  SizedBox(height: 6.h),
                                  Text('${flight?.departureAirport ?? 'CGK'} (${flight?.from ?? 'Jakarta'})', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.flight, size: 20.sp, color: Colors.blue[200]),
                                  SizedBox(height: 6.h),
                                  Text(flight?.duration ?? '7h 15m', style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(flight?.arrivalTime ?? '01:30 AM', style: TextStyle(fontSize: 12.sp, color: Color(0xFF1A73E8), fontWeight: FontWeight.w700)),
                                  SizedBox(height: 6.h),
                                  Text('${flight?.arrivalAirport ?? 'NRT'} (${flight?.to ?? 'Tokyo'})', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),
                          Divider(color: Colors.grey[200]),
                          SizedBox(height: 8.h),

                          // Terminal / Gate / Class
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('TERMINAL', style: TextStyle(fontSize: 10.sp, color: Colors.grey[600])),
                                  SizedBox(height: 6.h),
                                  Text('2A', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('GATE', style: TextStyle(fontSize: 10.sp, color: Colors.grey[600])),
                                  SizedBox(height: 6.h),
                                  Text('19', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Class', style: TextStyle(fontSize: 10.sp, color: Colors.grey[600])),
                                  SizedBox(height: 6.h),
                                  Text('Economy', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Passengers info card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Passengers Info', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                          SizedBox(height: 12.h),
                          // Passenger 1
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(radius: 20.r, backgroundImage: NetworkImage('https://via.placeholder.com/48')),
                            title: Text('Mr. Budiarti Rohman', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('PASSENGER 1', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                            trailing: Text('3A', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                          Divider(),
                          // Passenger 2
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(radius: 20.r, backgroundImage: NetworkImage('https://via.placeholder.com/48')),
                            title: Text('Mrs. Samantha William', style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('PASSENGER 2', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                            trailing: Text('3B', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Barcode / pass
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                      child: Column(
                        children: [
                          // simple barcode placeholder
                          Container(
                            height: 72.h,
                            color: Colors.white,
                            child: CustomPaint(
                              size: Size(double.infinity, 72.h),
                              painter: _BarcodePainter(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.h),
                    // Download button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                        ),
                        child: Text('Download & Save pass', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final gap = 4.0;
    double x = 0;
    // draw simple barcode-like stripes
    while (x < size.width) {
      final w = (x % 3 == 0) ? 6.0 : 2.0;
      canvas.drawRect(Rect.fromLTWH(x, 0, w, size.height), paint);
      x += w + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

