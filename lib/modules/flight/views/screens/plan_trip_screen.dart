import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/flight_controller.dart';


class PlanTripScreen extends GetView<FlightController> {
  const PlanTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),
      bottomNavigationBar: const _BottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // TOP SECTION
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff4F87FF),
                      Color(0xff89A7FF),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Plan your trip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // SEARCH CARD
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.95),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _locationTile(
                                    label: 'From',
                                    value: 'Jakarta (CGK)',
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                        Colors.black.withOpacity(.08),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.swap_vert,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            const Divider(height: 32),
                            _locationTile(
                              label: 'To',
                              value: 'Tokyo (NRT)',
                            ),
                            const Divider(height: 32),

                            Row(
                              children: [
                                Expanded(
                                  child: _infoTile(
                                    title: 'Departure',
                                    value: 'Tue, 2 Apr',
                                    icon: Icons.calendar_today,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: _infoTile(
                                    title: 'Amount',
                                    value: '3 people',
                                    icon: Icons.keyboard_arrow_down,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: () { Get.toNamed(Routes.flightResults);},
                                child: const Text(
                                  'Search flights',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // SAVED TRIPS
              Padding(
                padding:
                const EdgeInsets.fromLTRB(24, 28, 24, 12),
                child: Row(
                  children: const [
                    Text(
                      'Saved trips',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'See more',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 230,
                child: ListView.separated(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 18),
                  itemBuilder: (_, __) {
                    return const FlightTicket();
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationTile({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
          const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _infoTile({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
          const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(icon, size: 18)
          ],
        )
      ],
    );
  }
}

class FlightTicket extends StatelessWidget {
  const FlightTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            children: [
              const Text(
                'Citilink',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  _timeColumn(
                    '07:47',
                    'CGK',
                    '(Jakarta)',
                  ),
                  const Spacer(),
                  Column(
                    children: const [
                      Icon(
                        Icons.flight,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 8),
                      Text('7h 15m'),
                    ],
                  ),
                  const Spacer(),
                  _timeColumn(
                    '14:30',
                    'NRT',
                    '(Tokyo)',
                  ),
                ],
              ),
              const Divider(height: 40),
              Row(
                children: const [
                  _DateWidget(),
                  Spacer(),
                  _DateWidget(),
                ],
              )
            ],
          ),
        ),

        Positioned(
          left: -14,
          top: 95,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xffF5F5F7),
          ),
        ),
        Positioned(
          right: -14,
          top: 95,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xffF5F5F7),
          ),
        ),
      ],
    );
  }

  Widget _timeColumn(
      String time,
      String code,
      String city,
      ) {
    return Column(
      children: [
        Text(
          time,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          code,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          city,
          style:
          const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class _DateWidget extends StatelessWidget {
  const _DateWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: const [
        Text(
          'DATE',
          style:
          TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 8),
        Text(
          'Jan 20, 2025',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding:
      const EdgeInsets.symmetric(horizontal: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home, color: Colors.blue),
          Icon(Icons.flight_outlined,
              color: Colors.grey),
          Icon(Icons.map_outlined,
              color: Colors.grey),
          Icon(Icons.person_outline,
              color: Colors.grey),
        ],
      ),
    );
  }
}