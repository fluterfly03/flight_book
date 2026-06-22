import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/flight_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/flight_ticket_card.dart';

class FlightListingScreen extends GetView<FlightController> {
  const FlightListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcddcf9),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xffDCE8FF),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.filter_alt_outlined,
          color: Color(0xff2F6BFF),
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffcddcf9),
                Color(0xffF2F3F7),
                Color(0xffF2F3F7),
                Color(0xffF2F3F7),
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),

          child: Column(
            children: [
              SizedBox(height: 10.h),

              /// TOP BAR
              CustomAppBar(
                title: "Flight result",
                trailingWidget: _circleButton(Icons.more_vert),
              ),
              SizedBox(height: 20.h),

              /// FILTER CHIPS
              SizedBox(
                height: 35.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                      controller.isPriceLowToHigh.value = !controller.isPriceLowToHigh.value;
                      controller.searchFlights();},
                      child: Obx(() {
                        return _chip(
                          "Lowest to Highest",
                          selected: controller.isPriceLowToHigh.value,
                        );
                      }),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => controller.openAirlinesSelector(),
                      child: Obx(() {
                        final selected = controller.selectedAirlines.value;
                        return _chip(
                          selected.isNotEmpty ? selected : "Preferred airlines",
                          selected: selected.isNotEmpty,
                          onClear: selected.isNotEmpty
                              ? () {
                                  controller.selectedAirlines.value = '';
                                  controller.searchFlights();
                                }
                              : null,
                        );
                      }),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => controller.openAircraftTypeSelector(),
                      child: Obx(() {
                        final selected = controller.selectedAircraftType.value;
                        return _chip(
                          selected.isNotEmpty ? selected : "Flight type",
                          selected: selected.isNotEmpty,
                          onClear: selected.isNotEmpty
                              ? () {
                                  controller.selectedAircraftType.value = '';
                                  controller.searchFlights();
                                }
                              : null,
                        );
                      }),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.h),

              /// FLIGHT LIST
              Expanded(
                child: Obx(() {
                  final list = controller.flights;
                  return ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (context, index) => SizedBox(height: 6.h),
                    itemBuilder: (context, index) {
                      final flight = list[index];
                      return FlightTicketCard(
                        flight: flight,
                        height: 210.h,
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
                                ),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 28,
                                  ),
                                ),
                                child: Text(
                                  "Select flight",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        headerWidget: Row(
                          children: [
                            if (flight.airlineLogo.isNotEmpty)
                              Container(
                                width: 48.h,
                                height: 48.h,
                                padding: EdgeInsets.all(2.h),
                                decoration: const BoxDecoration(
                                  color: Color(0xffF2F3F7),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    flight.airlineLogo,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: const Color(0xffEAF8EE),
                                    ),
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: 48.h,
                                height: 48.h,
                                padding: EdgeInsets.all(2.h),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xffEAF8EE),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  flight.airlineName.isNotEmpty
                                      ? flight.airlineName[0]
                                      : '?',
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
                            ),
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
      ),
    );
  }

  static Widget _circleButton(IconData icon) {
    return Container(
      width: 40.h,
      height: 40.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18.h, color: Colors.grey),
    );
  }

  static Widget _chip(
    String title, {
    bool selected = false,
    VoidCallback? onClear,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: selected ? const Color(0xff2F6BFF) : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
          if (selected) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onClear,

              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}
