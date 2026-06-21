import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/flight_controller.dart';

class FlightDetailsScreen extends GetView<FlightController> {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Column(
            children: [
              /// APP BAR
              Row(
                children: [
                  _circleButton(
                    Icons.arrow_back_ios_new,
                  ),
                  const Spacer(),
                  const Text(
                    'Your flight details',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 50),
                ],
              ),

              const SizedBox(height: 28),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const FlightInfoCard(),

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

  static Widget _circleButton(
      IconData icon,
      ) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 22,
      ),
    );
  }
}

class FlightInfoCard extends StatelessWidget {
  const FlightInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              /// AIRLINE
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration:
                    const BoxDecoration(
                      color: Color(0xffEAF8EE),
                      shape: BoxShape.circle,
                    ),
                    alignment:
                    Alignment.center,
                    child: const Text(
                      'Citilink',
                      style: TextStyle(
                        color:
                        Colors.green,
                        fontSize: 10,
                        fontWeight:
                        FontWeight
                            .w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Citilink Airline',
                      style: TextStyle(
                        fontSize: 20,
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
              ),

              const SizedBox(height: 24),

              /// FLIGHT INFO
              Row(
                children: [
                  Expanded(
                    child:
                    _airportWidget(
                      '01:30 AM',
                      'CGK',
                      'Jakarta',
                      false,
                    ),
                  ),

                  Column(
                    children: [
                      Container(
                        padding:
                        const EdgeInsets
                            .all(8),
                        decoration:
                        const BoxDecoration(
                          color: Color(
                              0xffF4F5F7),
                          shape:
                          BoxShape
                              .circle,
                        ),
                        child:
                        const Icon(
                          Icons.flight,
                          color: Color(
                              0xff2F6BFF),
                          size: 18,
                        ),
                      ),
                      const SizedBox(
                          height: 8),
                      const Text(
                        '7h 15m',
                        style:
                        TextStyle(
                          color:
                          Colors
                              .black54,
                        ),
                      )
                    ],
                  ),

                  Expanded(
                    child:
                    _airportWidget(
                      '01:30 AM',
                      'NRT',
                      'Tokyo',
                      true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Divider(
                color:
                Colors.grey.shade300,
              ),

              const SizedBox(height: 20),

              /// TERMINAL
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: const [
                  _Info(
                    title:
                    'TERMINAL',
                    value: '2A',
                  ),
                  _Info(
                    title: 'GATE',
                    value: '19',
                  ),
                  _Info(
                    title: 'Class',
                    value:
                    'Economy',
                  ),
                ],
              )
            ],
          ),
        ),

        /// CUTS
        Positioned(
          left: -16,
          top: 175,
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
          top: 175,
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

  Widget _airportWidget(
      String time,
      String code,
      String city,
      bool end,
      ) {
    return Column(
      crossAxisAlignment: end
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: const TextStyle(
            color: Color(0xff2F6BFF),
            fontWeight:
            FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          code,
          style: const TextStyle(
            fontSize: 22,
            fontWeight:
            FontWeight.w700,
          ),
        ),
        Text(
          '($city)',
          style: const TextStyle(
            color: Colors.black45,
          ),
        )
      ],
    );
  }
}

class _Info extends StatelessWidget {
  final String title;
  final String value;

  const _Info({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color:
            Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight:
            FontWeight.w700,
          ),
        )
      ],
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

