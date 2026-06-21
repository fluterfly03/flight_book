import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/flight_controller.dart';

class PasangerSelector extends StatefulWidget {
  const PasangerSelector({super.key});

  @override
  State<PasangerSelector> createState() => _PasangerSelectorState();
}

class _PasangerSelectorState extends State<PasangerSelector> {
  final controller = Get.find<FlightController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Obx(
              () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Passengers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'People',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed:
                        controller.decrementPassenger,
                        icon: const Icon(
                          Icons.remove_circle_outline,
                        ),
                      ),
                      Text(
                        '${controller.passengerCount.value}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed:
                        controller.incrementPassenger,
                        icon: const Icon(
                          Icons.add_circle_outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: Get.back,
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
