import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/flight_controller.dart';

class AircraftTypeSelector extends StatefulWidget {
  const AircraftTypeSelector({super.key});

  @override
  State<AircraftTypeSelector> createState() => _AircraftTypeSelectorState();
}

class _AircraftTypeSelectorState extends State<AircraftTypeSelector> {
  final FlightController controller = Get.find();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  String _search = '';

  @override
  void initState() {
	super.initState();
	// fetch first page
	controller.fetchAircraftTypes(search: _search, page: 1, append: false);

	_scrollController.addListener(() {
	  if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
		// near bottom
		if (controller.aircraftTypesHasNext.value && !controller.isLoadingMoreAircraftTypes.value) {
		  final nextPage = controller.aircraftTypesPage.value + 1;
		  controller.fetchAircraftTypes(search: _search, page: nextPage, append: true);
		}
	  }
	});
  }

  @override
  void dispose() {
	_debounce?.cancel();
	_scrollController.dispose();
	super.dispose();
  }

  void _onSearchChanged(String value) {
	_debounce?.cancel();
	_debounce = Timer(const Duration(milliseconds: 350), () {
	  _search = value;
	  controller.fetchAircraftTypes(search: _search, page: 1, append: false);
	});
  }

  @override
  Widget build(BuildContext context) {
	return DraggableScrollableSheet(
	  expand: false,
	  initialChildSize: 0.6,
	  minChildSize: 0.4,
	  maxChildSize: 0.95,
	  builder: (context, scrollController) {
		return Container(
		  padding: const EdgeInsets.all(16),
		  decoration: const BoxDecoration(
			color: Colors.white,
			borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
					'Select Aircraft Type',
					style: TextStyle(
						fontSize: 18,
						fontWeight: FontWeight.w600,
					),
				),

				const SizedBox(height: 16),
			  TextField(
					decoration: InputDecoration(
						hintText: 'Search aircraft type',
						prefixIcon:
						const Icon(Icons.search),
						border: OutlineInputBorder(
							borderRadius:
							BorderRadius.circular(12),
						),
					),
				onChanged: _onSearchChanged,
			  ),
			  const SizedBox(height: 8),
			  Expanded(
				child: Obx(() {
				  final list = controller.aircraftTypes;
				  if (controller.isLoadingAircraftTypes.value && list.isEmpty) {
					return const Center(child: CircularProgressIndicator());
				  }

				  return ListView.builder(
					controller: _scrollController,
					itemCount: list.length + (controller.isLoadingMoreAircraftTypes.value ? 1 : 0),
					itemBuilder: (context, index) {
					  if (index >= list.length) {
						return const Padding(
						  padding: EdgeInsets.symmetric(vertical: 12),
						  child: Center(child: CircularProgressIndicator()),
						);
					  }
					  final item = list[index];
					  return ListTile(
						title: Text(item.aircraft),
						onTap: () {
						  controller.selectedAircraftType.value = item.aircraft;
						  Get.back();
							controller.searchFlights();
						},
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


