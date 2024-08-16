import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';
import 'package:reservation_app/src/presentation/utils/general/pop_up.dart';
import 'package:reservation_app/src/presentation/widgets/general/exschool_card_view.dart';
import 'package:reservation_app/src/presentation/widgets/general/reservation_admin_card_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

///Create history when reservation is done or when canceled

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late DateTime dateTime;
  late String date;
  late ReservationBloc _reservationBloc;
  late ExschoolBloc _exschoolBloc;
  late UserBloc _userBloc;
  late String roleUser;
  late TabController _tabController;

  getReservationForUser() {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservationForUser());
  }

  getReservationForAdmin() {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservationForAdmin());
  }

  deleteReservation(String id) {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(DeleteReservation(id));
  }

  acceptReservation(String id) {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(AcceptReservation(id));
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

  getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleUser = prefs.getString("role")!;
    setState(() {
      roleUser = roleUser;
    });
  }

  popUpCancelReservation(String id) async {
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
                        'Ya',
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

  popUpDoneReservation(String id) async {
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
                    Icons.check_circle,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
                Gap(10),
                Text(
                  'Ingin menyelesaikan reservasi?',
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
                        'Ya',
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

  popUpAcceptReservation(String id) async {
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
                    Icons.check_circle,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
                Gap(10),
                Text(
                  'Setujui reservasi?',
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
                    acceptReservation(id);
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
                        'Ya',
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
    roleUser = "";
    getRole();
    _tabController = TabController(length: 2, vsync: this);
    getDateTime();
    getExschool();
    getUser();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (roleUser) {
      case "0":
        return const Scaffold(
          body: Text("data"),
        );
      case "1":
        return adminDashboard();
      case "2":
        return userDashboard();
    }
    return const SizedBox();
  }

  adminDashboard() {
    getReservationForAdmin();
    return BlocListener<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if (state is ReservationAcceptSuccess) {
          PopUp().whenSuccessDoSomething(
            context,
            "Reservasi disetujui",
            Icons.check_circle,
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const HeaderPage(name: "Beranda"),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getReservationForAdmin();
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
                                  ParsingDate().convertDate(date),
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
                                    "Konfirmasi Reservasi",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.white,
                                ),
                                BlocBuilder<ReservationBloc, ReservationState>(
                                  builder: (context, state) {
                                    if (state is ReservationGetSuccess) {
                                      final reservations = state.reservations
                                          .where((element) =>
                                              element.status == "Menunggu")
                                          .toList();
                                      if (reservations.isNotEmpty) {
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: reservations.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ReservationAdminCardView(
                                              reservation: reservations[index],
                                              function: () {
                                                popUpAcceptReservation(reservations[index].id!);
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
                                                  "Tidak ada reservasi yang menunggu",
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
                                              child:
                                                  CircularProgressIndicator(),
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
                        const Gap(40),
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
                                    "Reservasi Berlangsung",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.white,
                                ),
                                BlocBuilder<ReservationBloc, ReservationState>(
                                  builder: (context, state) {
                                    if (state is ReservationGetSuccess) {
                                      final reservations = state.reservations
                                          .where((element) =>
                                              element.status == "Disetujui")
                                          .toList();
                                      if (reservations.isNotEmpty) {
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: reservations.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ReservationAdminCardView(
                                              reservation: reservations[index],
                                              function: () {},
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
                                                  "Tidak ada reservasi yang berlangsung",
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
                                              child:
                                                  CircularProgressIndicator(),
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
      ),
    );
  }

  userDashboard() {
    getReservationForUser();
    return BlocListener<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if (state is ReservationDeleteSuccess) {
          PopUp().whenSuccessDoSomething(
            context,
            "Reservasi dibatalkan",
            Icons.cancel,
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const HeaderPage(
              name: "Beranda",
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getReservationForUser();
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
                                  ParsingDate().convertDate(date),
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
                                const Divider(
                                  height: 1,
                                  color: Colors.white,
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
                                              reservation: reservations[index],
                                              function: () {
                                                reservations[index].status ==
                                                        "Menunggu"
                                                    ? popUpCancelReservation(
                                                        reservations[index].id!)
                                                    : popUpDoneReservation(
                                                        reservations[index]
                                                            .id!);
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
                                              child:
                                                  CircularProgressIndicator(),
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
      ),
    );
  }
}
