import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../screens/flight_listing_screen.dart';

class FlightListingCard extends StatelessWidget {
  final Flight flight;

  const FlightListingCard({
    super.key,
    required this.flight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Stack(
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
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: flight.logoColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        flight.logoText,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        flight.airlineName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 24),

                /// FLIGHT INFO
                Row(
                  children: [
                    Expanded(
                      child: _airportInfo(
                        flight.departureTime,
                        flight.departureCode,
                        flight.departureCity,
                        false,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding:
                          const EdgeInsets.all(
                              8),
                          decoration:
                          const BoxDecoration(
                            shape:
                            BoxShape.circle,
                            color:
                            Color(0xffF4F5F7),
                          ),
                          child: const Icon(
                            Icons.flight,
                            color:
                            Color(0xff2F6BFF),
                            size: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          flight.duration,
                          style:
                          const TextStyle(
                            color:
                            Colors.black54,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: _airportInfo(
                        flight.arrivalTime,
                        flight.arrivalCode,
                        flight.arrivalCity,
                        true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

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

                const SizedBox(height: 20),

                /// PRICE + BUTTON
                Row(
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          "\$${flight.price}",
                          style:
                          const TextStyle(
                            color: Color(
                                0xff2F6BFF),
                            fontSize: 34,
                            fontWeight:
                            FontWeight
                                .w700,
                          ),
                        ),
                        const Text(
                          "/person",
                          style: TextStyle(
                            color:
                            Colors.black54,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.flightDetails);
                        },
                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          Colors.black,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                                30),
                          ),
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 28,
                          ),
                        ),
                        child: const Text(
                          "Select flight",
                          style:
                          TextStyle(
                            color:
                            Colors.white,
                            fontSize: 15,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          /// LEFT CUT
          Positioned(
            left: -16,
            top: 155,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xffF5F5F7),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// RIGHT CUT
          Positioned(
            right: -16,
            top: 155,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xffF5F5F7),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _airportInfo(
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
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          code,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '($city)',
          style: const TextStyle(
            color: Colors.black45,
          ),
        ),
      ],
    );
  }
}