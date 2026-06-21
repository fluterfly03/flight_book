import 'package:flutter/material.dart';

import 'info_widget.dart';

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
