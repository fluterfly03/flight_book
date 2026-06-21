import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/flight_controller.dart';
import '../widgets/flight_ticket_card.dart';



class FlightListingScreen extends GetView<FlightController> {
  const FlightListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // use flights from controller (populated by FlightApiService.searchFlights)
    // controller is available via GetView
    final flights = controller.flights;

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
              child: Obx(() {
                final list = controller.flights;
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  itemCount: list.length,
                  separatorBuilder: (context, index) => SizedBox(height: 6.h),
                  itemBuilder: (context, index) {
                    final flight = list[index];
                    return FlightTicketCard(
                      flight: flight,
                      height: 200.h,
                      width: 350.w,
                      cutPosition: 120.h,
                      bottomWidget: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${flight.priceAmount}",
                                style: TextStyle(
                                  color: const Color(0xff2F6BFF),
                                  fontSize: 16.h,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "/person",
                                style: TextStyle(
                                  fontSize: 12.h,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 35.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectFlight(flight);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 28),
                              ),
                              child: Text(
                                "Select flight",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.h,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      headerWidget: Row(
                        children: [
                          if (flight.airlineLogo.isNotEmpty)
                            Container(
                              width: 46.h,
                              height: 46.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  flight.airlineLogo,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(color: const Color(0xffEAF8EE)),
                                ),
                              ),
                            )
                          else
                            Container(
                              width: 46.h,
                              height: 46.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xffEAF8EE),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                flight.airlineName.isNotEmpty ? flight.airlineName[0] : '?',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              flight.airlineName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }),
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