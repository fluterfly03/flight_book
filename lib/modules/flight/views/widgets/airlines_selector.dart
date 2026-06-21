import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/flight_controller.dart';

class AirlineSelector extends StatefulWidget {
  const AirlineSelector({super.key});

  @override
  State<AirlineSelector> createState() =>
      _AirlineSelectorState();
}

class _AirlineSelectorState
    extends State<AirlineSelector> {
  final FlightController controller = Get.find();
  final ScrollController _scrollController =
  ScrollController();

  Timer? _debounce;
  String _search = '';

  @override
  void initState() {
    super.initState();

    /// Fetch first page
    controller.fetchAirlines(
      search: _search,
      page: 1,
      append: false,
    );

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent -
            100) {
      if (controller.airlinesHasNext.value &&
          !controller.isLoadingMoreAirlines.value) {
        final nextPage =
            controller.airlinesPage.value + 1;

        controller.fetchAirlines(
          search: _search,
          page: nextPage,
          append: true,
        );
      }
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 350),
          () {
        _search = value.trim();

        controller.fetchAirlines(
          search: _search,
          page: 1,
          append: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.65,
      minChildSize: 0.40,
      maxChildSize: 0.95,
      builder: (context, sheetController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 45,
                height: 5,
                margin:
                const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                  BorderRadius.circular(10),
                ),
              ),

              const Text(
                'Select Airline',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search airline',
                  prefixIcon:
                  const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                ),
                onChanged: _onSearchChanged,
              ),

              const SizedBox(height: 16),

              Expanded(
                child: Obx(() {
                  final list =
                      controller.airlines;

                  if (controller
                      .isLoadingAirlines.value &&
                      list.isEmpty) {
                    return const Center(
                      child:
                      CircularProgressIndicator(),
                    );
                  }

                  if (list.isEmpty) {
                    return const Center(
                      child: Text(
                        'No airlines found',
                      ),
                    );
                  }

                  return ListView.builder(
                    controller:
                    _scrollController,
                    itemCount:
                    list.length +
                        (controller
                            .isLoadingMoreAirlines
                            .value
                            ? 1
                            : 0),
                    itemBuilder:
                        (context, index) {
                      if (index >=
                          list.length) {
                        return const Padding(
                          padding:
                          EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: Center(
                            child:
                            CircularProgressIndicator(),
                          ),
                        );
                      }

                      final item =
                      list[index];

                      return Obx(
                            () => RadioListTile<String>(
                          value: item.airline,
                          groupValue: controller
                              .selectedAirlines
                              .value,
                          title:
                          Text(item.airline),
                          onChanged: (value) {
                            controller
                                .selectedAirlines
                                .value = value!;
                            Get.back();
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}