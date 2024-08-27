import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/data/bloc/building/building_bloc.dart';
import 'package:reservation_app/src/data/bloc/history/history_bloc.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';
import 'package:reservation_app/src/presentation/utils/general/pop_up.dart';
import 'package:reservation_app/src/presentation/widgets/general/exschool_card_view.dart';
import 'package:reservation_app/src/presentation/widgets/general/reservation_admin_card_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bloc/exschool/exschool_bloc.dart';
import '../../../data/bloc/reservation/reservation_bloc.dart';
import '../../../data/bloc/user/user_bloc.dart';
import '../../../data/model/reservation_model.dart';
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
  late HistoryBloc _historyBloc;
  late BuildingBloc _buildingBloc;
  late String roleUser;

  /// informasi list reservasi untuk pengguna
  getReservationForUser() {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservationForUser());
  }

  /// informasi list reservasi untuk admin
  getReservationForAdmin() {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(GetReservationForAdmin());
  }

  /// menghapus reservasi
  deleteReservation(String id) {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(DeleteReservation(id));
  }

  /// accept reservasi
  acceptReservation(String id) {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(AcceptReservation(id));
  }

  /// informasi ekskul
  getExschool() {
    _exschoolBloc = context.read<ExschoolBloc>();
    _exschoolBloc.add(GetExschool());
  }

  /// membuat riwayat
  createHistory(
    String buildingName,
    String dateStart,
    String dateEnd,
    String dateCreated,
    String contactId,
    String contactName,
    String information,
    String status,
  ) {
    _historyBloc = context.read<HistoryBloc>();
    _historyBloc.add(
      CreateHistory(
        buildingName,
        dateStart,
        dateEnd,
        dateCreated,
        contactId,
        contactName,
        information,
        status,
      ),
    );
  }

  /// mengganti status building (status dan tanggal pakai)
  changeStatusBuilding(String name, String dateEnd) {
    _buildingBloc = context.read<BuildingBloc>();
    _buildingBloc.add(ChangeStatusBuilding(name, dateEnd));
  }

  /// informasi pengguna
  getUser() {
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUser());
  }

  /// informasi waktu saat ini
  getDateTime() {
    dateTime = DateTime.now();
    date = dateTime.toString();
  }

  /// informasi role
  getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    roleUser = prefs.getString("role")!;
    setState(() {
      roleUser = roleUser;
    });
  }

  /// Popup ketika doing something
  popUpCancelReservation(ReservationModel reservation) async {
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
                    deleteReservation(reservation.id!);
                    createHistory(
                      reservation.buildingName!,
                      reservation.dateStart!,
                      reservation.dateEnd!,
                      reservation.dateCreated!,
                      reservation.contactId!,
                      reservation.contactName!,
                      reservation.information!,
                      "Dibatalkan",
                    );
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

  popUpDoneReservation(ReservationModel reservation) async {
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
                    deleteReservation(reservation.id!);
                    createHistory(
                      reservation.buildingName!,
                      reservation.dateStart!,
                      reservation.dateEnd!,
                      reservation.dateCreated!,
                      reservation.contactId!,
                      reservation.contactName!,
                      reservation.information!,
                      "Selesai",
                    );
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

  popUpAcceptReservation(String id, String name, String dateEnd) async {
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
                    changeStatusBuilding(name, dateEnd);
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
    getDateTime();
    getExschool();
    getUser();
    super.didChangeDependencies();
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
                                                popUpAcceptReservation(
                                                  reservations[index].id!,
                                                  reservations[index]
                                                      .buildingName!,
                                                  reservations[index].dateEnd!,
                                                );
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
            Icons.check_circle,
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
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                child: Text(
                                  ParsingDate().convertDate(date),
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserGetSuccess) {
                                  return Text(
                                    "Selamat Datang, ${state.user.fullName}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic),
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
                            borderRadius: BorderRadius.circular(10),
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Reservasi Anda",
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                                        reservations[index])
                                                    : popUpDoneReservation(
                                                        reservations[index]);
                                              },
                                            );
                                          },
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Center(
                                                child: Text(
                                                  "Anda belum melakukan reservasi",
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
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
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if (state is UserGetSuccess) {
                              return Text(
                                "Jadwal Ekstrakurikuler ${state.user.agency}",
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                            return Text(
                              "Jadwal Ekstrakurikuler",
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
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
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Center(
                                        child: Text(
                                            "Jadwal ekstrakurikuler tidak ada"),
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
