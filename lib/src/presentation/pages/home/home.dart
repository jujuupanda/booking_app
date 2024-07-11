import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../data/bloc/reservation/reservation_bloc.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/reservation_card_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime dateTime;
  late String formattedDate;
  late ReservationBloc _reservationBloc;

  getReservation() {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservation());
  }

  getDateTime() {
    dateTime = DateTime.now();
    String formatted = DateFormat('EEEE, d MMMM yyyy').format(dateTime);
    formattedDate = formatted;
  }

  @override
  void didChangeDependencies() {
    getReservation();
    getDateTime();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderPage(
            name: "Beranda",
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                getReservation();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          const Text(
                            "Selamat Datang, User1",
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueAccent,
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Reservasi Anda",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              BlocBuilder<ReservationBloc, ReservationState>(
                                builder: (context, state) {
                                  if (state is ReservationGetSuccess) {
                                    final reservations = state.reservations;
                                    if (reservations.isNotEmpty) {
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: reservations.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return ReservationCardView(
                                              buildingName: reservations[index]
                                                  .buildingName!,
                                              dateStart: reservations[index]
                                                  .dateStart!,
                                              dateEnd:
                                                  reservations[index].dateEnd!,
                                              numberOfGuest: reservations[index]
                                                  .numberOfGuest!
                                                  .toString(),
                                              status:
                                                  reservations[index].status!);
                                        },
                                      );
                                    } else {
                                      return const Column(
                                        children: [
                                          Gap(30),
                                          Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Center(
                                              child: Text(
                                                "Kamu tidak dalam reservasi. Reservasi Sekarang?",
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  } else {
                                    return const Column(
                                      children: [
                                        Gap(30),
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
