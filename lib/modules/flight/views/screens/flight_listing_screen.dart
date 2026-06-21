import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/flight_controller.dart';


class FlightListingScreen extends GetView<FlightController> {
  const FlightListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flights = [
      Flight(
        airlineName: "Citilink Airline",
        logoColor: const Color(0xffEAF8EE),
        logoText: "Citilink",
        departureTime: "07:47",
        departureCode: "CGK",
        departureCity: "Jakarta",
        arrivalTime: "14:30",
        arrivalCode: "NRT",
        arrivalCity: "Tokyo",
        duration: "7h 15m",
        price: 321,
      ),
      Flight(
        airlineName: "Catty Airline",
        logoColor: const Color(0xffFFF1F1),
        logoText: "Cat Air",
        departureTime: "07:47",
        departureCode: "CGK",
        departureCity: "Jakarta",
        arrivalTime: "14:30",
        arrivalCode: "NRT",
        arrivalCity: "Tokyo",
        duration: "7h 20m",
        price: 321,
      ),
      Flight(
        airlineName: "Bird Indonesia Airline",
        logoColor: const Color(0xffF2F2F2),
        logoText: "Bird",
        departureTime: "07:47",
        departureCode: "CGK",
        departureCity: "Jakarta",
        arrivalTime: "14:30",
        arrivalCode: "NRT",
        arrivalCity: "Tokyo",
        duration: "7h 20m",
        price: 321,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xffDCE8FF),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: const Icon(
          Icons.filter_alt_outlined,
          color: Color(0xff2F6BFF),
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            /// TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _circleButton(Icons.arrow_back_ios_new),
                  const Spacer(),
                  const Text(
                    "Flight result",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  _circleButton(Icons.more_vert),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// FILTER CHIPS
            SizedBox(
              height: 46,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _chip(
                    "Lowest to Highest",
                    selected: true,
                  ),
                  const SizedBox(width: 12),
                  _chip("Preferred airlines"),
                  const SizedBox(width: 12),
                  _chip("Flight type"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// FLIGHT LIST
            Expanded(
              child: ListView.builder(
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  final flight = flights[index];

                  return FlightCard(
                    flight: flight,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _circleButton(IconData icon) {
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

  static Widget _chip(
      String title, {
        bool selected = false,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xff2F6BFF)
            : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color:
          selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  final Flight flight;

  const FlightCard({
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

class Flight {
  final String airlineName;
  final Color logoColor;
  final String logoText;

  final String departureTime;
  final String departureCode;
  final String departureCity;

  final String arrivalTime;
  final String arrivalCode;
  final String arrivalCity;

  final String duration;
  final int price;

  Flight({
    required this.airlineName,
    required this.logoColor,
    required this.logoText,
    required this.departureTime,
    required this.departureCode,
    required this.departureCity,
    required this.arrivalTime,
    required this.arrivalCode,
    required this.arrivalCity,
    required this.duration,
    required this.price,
  });
}