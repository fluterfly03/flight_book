import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/flight_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/flight_ticket_card.dart';
import '../widgets/flight_ticket_s_card.dart';
import '../widgets/info_widget.dart';

class FlightDetailsScreen extends GetView<FlightController> {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcddcf9),
      body: SafeArea(
        child: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffcddcf9),
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Column(
            children: [
              /// APP BAR

              CustomAppBarr(),
              const SizedBox(height: 28),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FlightTicket(
                        height:200.h,
                        width: 350.w,
                        cutPosition:120.h ,
                        bottomWidget: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: const [
                          Info(
                            title:
                            'TERMINAL',
                            value: '2A',
                          ),
                          Info(
                            title: 'GATE',
                            value: '19',
                          ),
                          Info(
                            title: 'Class',
                            value:
                            'Economy',
                          ),
                        ],
                      ),
                        headerWidget: Row(
                          children: [
                            Container(
                              width: 45.h,
                              height: 45.h,
                              decoration:
                              const BoxDecoration(
                                color: Color(0xffEAF8EE),
                                shape: BoxShape.circle,
                              ),
                              alignment:
                              Alignment.center,
                              child:  Text(
                                'Citilink',
                                style: TextStyle(
                                  color:
                                  Colors.green,
                                  fontSize: 9.sp,
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                             Expanded(
                              child: Text(
                                'Citilink Airline',
                                style: TextStyle(
                                  fontSize:18.sp,
                                  fontWeight:
                                  FontWeight
                                      .w600,
                                ),
                              ),
                            ),
                            Text(
                              'ID3242113',
                              style: TextStyle(
                                color:
                                Colors.grey[500],
                              ),
                            )
                          ],
                        ),),

                      const SizedBox(height: 20),

                      const PassengerCard(),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 62,
                        child: ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.black,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(35),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Download & Save pass',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}





class PassengerCard extends StatelessWidget {
  const PassengerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding:
          const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(
                30),
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            children: [
              const Text(
                'Passengers Info',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
              const SizedBox(
                  height: 20),

              _passenger(
                'Mr. Budiarti Rohman',
                'PASSENGER 1',
                '3A',
              ),

              Divider(
                color:
                Colors.grey.shade300,
              ),

              _passenger(
                'Mrs. Samantha William',
                'PASSENGER 2',
                '3B',
              ),

              const SizedBox(
                  height: 30),

              /// BARCODE
              SizedBox(
                height: 70,
                child:
                CustomPaint(
                  painter:
                  BarcodePainter(),
                  size: const Size(
                    double.infinity,
                    70,
                  ),
                ),
              )
            ],
          ),
        ),

        Positioned(
          left: -16,
          top: 155,
          child: Container(
            width: 32,
            height: 32,
            decoration:
            const BoxDecoration(
              color:
              Color(0xffF4F6FA),
              shape:
              BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: -16,
          top: 155,
          child: Container(
            width: 32,
            height: 32,
            decoration:
            const BoxDecoration(
              color:
              Color(0xffF4F6FA),
              shape:
              BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _passenger(
      String name,
      String passenger,
      String seat,
      ) {
    return ListTile(
      contentPadding:
      EdgeInsets.zero,
      leading:
      const CircleAvatar(
        radius: 24,
        backgroundImage:
        NetworkImage(
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight:
          FontWeight.w600,
        ),
      ),
      subtitle: Text(
        passenger,
        style: TextStyle(
          color:
          Colors.grey.shade500,
          fontSize: 12,
        ),
      ),
      trailing: Column(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        children: [
          Text(
            'SEAT',
            style: TextStyle(
              color:
              Colors.grey
                  .shade500,
              fontSize: 11,
            ),
          ),
          Text(
            seat,
            style:
            const TextStyle(
              fontSize: 18,
              fontWeight:
              FontWeight
                  .w700,
            ),
          ),
        ],
      ),
    );
  }
}

class BarcodePainter
    extends CustomPainter {
  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {
    final paint = Paint()
      ..color = Colors.black;

    double x = 0;

    while (x < size.width) {
      final width =
      (x % 3 == 0)
          ? 4.0
          : 2.0;

      canvas.drawRect(
        Rect.fromLTWH(
          x,
          0,
          width,
          size.height,
        ),
        paint,
      );

      x += width + 3;
    }
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter
      oldDelegate) =>
      false;
}

