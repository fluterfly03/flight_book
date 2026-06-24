import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/flight_controller.dart';
import '../../models/airport_model.dart';
import '../../resources/asset_constants.dart';
import 'custom_tile.dart';

class SearchFlightCard extends StatefulWidget {
  const SearchFlightCard({super.key});

  @override
  State<SearchFlightCard> createState() => _SearchFlightCardState();
}

class _SearchFlightCardState extends State<SearchFlightCard> {
  final FlightController controller =
  Get.put(FlightController());
  @override
  Widget build(BuildContext context) {
    return     Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffcddcf9),
            Colors.white,
            Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// FROM
          Obx(
                () => _airportField(
              label: 'From',
              selected: controller.from1.value,
              airports: controller.fromAirports,
              onSelected: controller.setFrom,
            ),
          ),


          /// DIVIDER + SWAP BUTTON
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerRight,
            children: [
              Divider(

                thickness: 1,
                color: Colors.grey.shade300,
              ),

              Positioned(
                right: 20.w,
                child: Container(
                  height: 40.w,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                        Colors.black.withOpacity(.08),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:  Image.asset(
                      AssetConstants.swap,
                      color: Color(0xff6B7280),
                      height: 15.h,
                      width: 15.h,
                    ),
                    onPressed:controller.swapLocations,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// TO
          Obx(
                () => _airportField(
              label: 'To',
              selected: controller.to1.value,
              airports: controller.toAirports,
              onSelected: controller.setTo,
            ),
          ),

          Divider(
            height: 5.h,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 15.h),
          /// DEPARTURE + AMOUNT
          Row(
            children: [
              Obx(
    ()=>Expanded(
                  child: CustomTile(
                    title: 'Departure',
                    value: DateFormat(
                      'EEE, d MMM',
                    ).format(controller.departureDate.value),
                    icon: Image.asset(
                      AssetConstants.calendar,
                      color: Color(0xff6B7280),
                      height: 15.h,
                      width: 15.h,
                    ),
                    onTap: () =>
                        controller.pickDepartureDate(context),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Obx(()=>
                 Expanded(
                  child: CustomTile(
                    title: 'Amount',
                    value:
                    '${controller.passengerCount.value} ${controller.passengerCount.value == 1 ? 'person' : 'people'}',
                    icon: Icon(
                        Icons.keyboard_arrow_down,color: Color(0xff6B7280),
                      size: 20.h,
                      ),
                    onTap: controller.openPassengerSelector,


                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          /// BUTTON
          SizedBox(
            width: double.infinity,
            height: 45.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(28.r),
                ),
              ),
              onPressed: () {
                controller.selectedAircraftType.value='';
                controller.selectedAirlines.value='';
                controller.searchFlights();
              },
              child: Text(
                'Search flights',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _airportField({
    required String label,
    required Airport? selected,
    required List<Airport> airports,
    required Function(Airport) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10.sp,
          ),
        ),
        Autocomplete<Airport>(
          initialValue: TextEditingValue(
            text: selected?.display ?? '',
          ),
          displayStringForOption: (airport) =>
          airport.display,
          optionsBuilder: (textEditingValue) {
            final query =
            textEditingValue.text.toLowerCase();

            if (query.isEmpty) {
              return airports;
            }

            return airports.where(
                  (airport) =>
              airport.city
                  .toLowerCase()
                  .contains(query) ||
                  airport.airportCode
                      .toLowerCase()
                      .contains(query),
            );
          },
          onSelected: onSelected,
          fieldViewBuilder: (
              context,
              textController,
              focusNode,
              onFieldSubmitted,
              ) {
            textController.text =
                selected?.display ?? '';

            return TextField(
              controller: textController,
              style: TextStyle(color: Colors.black, fontSize: 16.sp,fontWeight: FontWeight.w500),
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Search airport',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 1.h,
                ),
              ),
            );
          },
          optionsViewBuilder:
              (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius:
                BorderRadius.circular(16.r),
                child: Container(
                  width: 320.w,
                  constraints: BoxConstraints(
                    maxHeight: 250.h,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final airport =
                      options.elementAt(index);

                      return ListTile(
                        title: Text(
                          airport.display,
                        ),
                        subtitle: Text(
                          '${airport.flightCount} flights',
                        ),
                        onTap: () =>
                            onSelected(airport),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }


}
