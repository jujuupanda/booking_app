import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';
import 'package:reservation_app/src/presentation/widgets/general/exschool_card_view.dart';

import '../../../data/bloc/exschool/exschool_bloc.dart';
import '../../../data/bloc/reservation/reservation_bloc.dart';
import '../../../data/bloc/user/user_bloc.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/reservation_card_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime dateTime;
  late String date;
  late ReservationBloc _reservationBloc;
  late ExschoolBloc _exschoolBloc;
  late UserBloc _userBloc;

  getReservation() {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservation());
  }

  deleteReservation(String id) {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(DeleteReservation(id));
  }

  getExschool() {
    _exschoolBloc = context.read<ExschoolBloc>();
    _exschoolBloc.add(GetExschool());
  }

  getDateTime() {
    dateTime = DateTime.now();
    date = dateTime.toString();
  }

  getUser() {
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUser());
  }

  _cancelReservation(String id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
                Gap(10),
                Text(
                  'Ingin membatalkan reservasi?',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Tidak',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    deleteReservation(id);
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent,
                    ),
                    child: const Center(
                      child: Text(
                        'Batalkan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    getReservation();
    getDateTime();
    getExschool();
    getUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final parsingDate = ParsingDate();

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
                getExschool();
                getDateTime();
                getUser();
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: Text(
                                parsingDate.convertDate(date),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserGetSuccess) {
                                return Text(
                                  "Selamat Datang, ${state.user.fullName}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                );
                              } else {
                                return const Text(
                                  "Selamat Datang, Pengguna",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                );
                              }
                            },
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
                                            dateStart: ParsingDate()
                                                .convertDate(reservations[index]
                                                    .dateStart!),
                                            dateEnd: ParsingDate().convertDate(
                                                reservations[index].dateEnd!),
                                            information: reservations[index]
                                                .information!,
                                            status: reservations[index].status!,
                                            function: () {
                                              _cancelReservation(
                                                  reservations[index].id!);
                                            },
                                          );
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
                      const Gap(15),
                      const Text(
                        "Informasi Jadwal Ekstrakurikuler SMANTAB",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      BlocBuilder<ExschoolBloc, ExschoolState>(
                        builder: (context, state) {
                          if (state is ExschoolGetSuccess) {
                            final exschool = state.exschools;
                            if (exschool.isNotEmpty) {
                              return ListView.builder(
                                itemCount: exschool.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return ExschoolCardView(
                                    image: exschool[index].image!,
                                    name: exschool[index].name!,
                                    schedule: exschool[index].schedule!,
                                  );
                                },
                              );
                            } else {
                              return const Column(
                                children: [
                                  Gap(30),
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Center(
                                      child: Text("Tidak ada data ekskul"),
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
                      )
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
