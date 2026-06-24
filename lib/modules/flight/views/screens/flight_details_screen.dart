import 'package:flight_book/modules/flight/models/flight_model.dart';
import 'package:flight_book/modules/flight/models/flight_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/flight_controller.dart';
import '../widgets/boarding_pass_pdf.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/flight_ticket_card.dart';
import '../widgets/info_widget.dart';
import 'flight_listing_screen.dart';

class FlightDetailsScreen extends GetView<FlightController> {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final flightDetails = controller.selectedFlightDetails.value;
      final selectedFlight = controller.selectedFlight.value;

      // Show loading if details not yet loaded
      if (flightDetails == null || selectedFlight == null) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final flight = flightDetails.data?.flightDetails;
      final passengers = flightDetails.data?.passengers ?? [];
      final booking = flightDetails.data?.bookingInfo;

      return Scaffold(
        appBar:  AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffcddcf9),
        ),
        // backgroundColor: const Color(0xffcddcf9),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffcddcf9),Color(0xffF2F3F7),Color(0xffF2F3F7),Color(0xffF2F3F7)],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Column(
              children: [
                /// APP BAR
                CustomAppBar(title: 'Your flight details',),
                const SizedBox(height: 28),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (flight != null)
                          FlightTicketCard(
                            flight: selectedFlight,
                            height: 200.h,
                            width: 350.w,
                            cutPosition: 120.h,
                            bottomWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Info(
                                    title: 'TERMINAL',
                                    value: flight.terminal),
                                Info(title: 'GATE', value: flight.gate),
                                Info(
                                    title: 'CLASS',
                                    value: flight.classType),
                              ],
                            ),
                            headerWidget: Row(
                              children: [
                                if (flight.airlineLogo.isNotEmpty)
                                  Container(
                                    width: 46.h,
                                    height: 46.h,
                                    padding: EdgeInsets.all(2.h),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xffEAF8EE),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        flight.airlineLogo,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) =>
                                            Container(
                                          color: const Color(0xffEAF8EE),
                                          child: Center(
                                            child: Text(
                                              flight.airlineName.isNotEmpty
                                                  ? flight.airlineName[0]
                                                  : '?',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    width: 46.h,
                                    height: 46.h,
                                    padding: EdgeInsets.all(2.h),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffEAF8EE),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      flight.airlineName.isNotEmpty
                                          ? flight.airlineName[0]
                                          : '?',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    flight.airlineName,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  flight.flightNumber,
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 20),

                        if (passengers.isNotEmpty)
                          PassengerCard(passengers: passengers, barcode: booking?.barcode ?? '')
                        else
                          const SizedBox.shrink(),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 62,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                            onPressed: () async {
                              final details = controller.selectedFlightDetails.value;

                              if (details != null) {
                                await saveBoardingPassPdf(details);
                              }
                            },
                            child: const Text(
                              'Download & Save pass',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PassengerCard extends StatelessWidget {
  final List<Passenger> passengers;
  final String barcode;

  const PassengerCard({super.key, required this.passengers,required this.barcode,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Passengers Info',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
               SizedBox(height: 10.h),
              ...passengers.asMap().entries.map((entry) {
                final index = entry.key;
                final passenger = entry.value;
                return Column(
                  children: [
                    _passenger(passenger.name, 'PASSENGER ${passenger.passengerNumber}',
                        passenger.seat, passenger.profilePicture),
                    if (index < passengers.length - 1)
                      Divider(color: Colors.grey.shade300)
                    else
                      const SizedBox.shrink(),
                  ],
                );
              }).toList(),
               SizedBox(height: 20.h),
              /// BARCODE
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: SvgPicture.string(
                    barcode,
                    width: double.infinity,
                    height: 120.h,
                      fit: BoxFit.fill
                  ),
                ),
              ),
              /// BARCODE
            ],
          ),
        ),

        Positioned(
          left: -16,
          top: 155,
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xffF4F6FA),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: -16,
          top: 155,
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xffF4F6FA),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _passenger(String name, String passenger, String seat, String profilePicture) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(profilePicture),
        onBackgroundImageError: (_, __) {},
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        passenger,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SEAT',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
          ),
          Text(
            seat,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

