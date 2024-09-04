import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bloc/extracurricular/extracurricular_bloc.dart';
import '../../../data/bloc/history/history_bloc.dart';
import '../../../data/bloc/reservation/reservation_bloc.dart';
import '../../../data/bloc/user/user_bloc.dart';
import '../../../data/model/reservation_model.dart';
import '../../utils/general/parsing.dart';
import '../../widgets/general/header_pages.dart';
import '../../widgets/general/pop_up.dart';
import '../../widgets/general/widget_custom_loading.dart';
import 'widget_reservation_admin_card_view.dart';
import 'widget_reservation_user_card_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

///Create history when reservation is done or when canceled

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late DateTime dateTime;
  late String date;
  late ReservationBloc reservationBloc;
  late ExtracurricularBloc excurBloc;
  late UserBloc userBloc;
  late HistoryBloc historyBloc;
  late String roleUser;

  /// informasi list reservasi untuk pengguna
  getReservationForUser() {
    reservationBloc = context.read<ReservationBloc>();
    reservationBloc.add(GetReservationForUser());
  }

  /// informasi list reservasi untuk admin
  getReservationForAdmin() {
    reservationBloc = context.read<ReservationBloc>();
    reservationBloc.add(GetReservationForAdmin());
  }

  /// menghapus reservasi
  actionReservationAndHistory(
    ReservationModel reservation,
    String status,
  ) {
    return () {
      reservationBloc = context.read<ReservationBloc>();
      reservationBloc.add(DeleteReservation(reservation.id!));
      createHistory(reservation, status);
    };
  }

  /// terima reservasi
  acceptReservation(String id) {
    return () {
      reservationBloc = context.read<ReservationBloc>();
      reservationBloc.add(UpdateStatusReservation(id, "Disetujui"));
    };
  }

  /// tolak reservasi
  declineReservation(String id) {
    return () {
      reservationBloc = context.read<ReservationBloc>();
      reservationBloc.add(UpdateStatusReservation(id, "Ditolak"));
    };
  }

  /// informasi ekskul
  getExcur() {
    excurBloc = context.read<ExtracurricularBloc>();
    excurBloc.add(GetExtracurricular());
  }

  /// membuat riwayat
  createHistory(ReservationModel reservation, String status) {
    historyBloc = context.read<HistoryBloc>();
    historyBloc.add(
      CreateHistory(
        reservation.buildingName!,
        reservation.dateStart!,
        reservation.dateEnd!,
        reservation.dateCreated!,
        reservation.contactId!,
        reservation.contactName!,
        reservation.information!,
        status,
        reservation.image!,
      ),
    );
  }

  /// mengganti status building (status dan tanggal pakai)
  // changeStatusBuilding(String name, String dateEnd) {
  //   _buildingBloc = context.read<BuildingBloc>();
  //   _buildingBloc.add(ChangeStatusBuilding(name, dateEnd));
  // }

  /// informasi pengguna
  getUser() {
    userBloc = context.read<UserBloc>();
    userBloc.add(GetUser());
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

  @override
  void didChangeDependencies() {
    roleUser = "";
    getRole();
    getDateTime();
    getExcur();
    getUser();
    super.didChangeDependencies();
  }

  getReservationByRole() {
    if (roleUser == "0") {
      return () {};
    } else if (roleUser == "1") {
      return getReservationForAdmin();
    } else if (roleUser == "2") {
      return getReservationForUser();
    } else {}
  }

  listReservationByRole() {
    if (roleUser == "0") {
      return const SizedBox();
    } else if (roleUser == "1") {
      return Container(
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
                        .where((element) => element.status == "Menunggu")
                        .toList();
                    reservations.sort(
                      (a, b) => a.dateCreated!.compareTo(b.dateCreated!),
                    );
                    if (reservations.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: reservations.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ReservationAdminCardView(
                            reservation: reservations[index],
                            acceptFunction: () {
                              PopUp().whenDoSomething(
                                context,
                                "Setujui Reservasi?",
                                Icons.check,
                                acceptReservation(
                                  reservations[index].id!,
                                ),
                              );
                            },
                            declineFunction: () {
                              PopUp().whenDoSomething(
                                context,
                                "Tolak Reservasi?",
                                Icons.cancel,
                                declineReservation(
                                  reservations[index].id!,
                                ),
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
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      );
    } else if (roleUser == "2") {
      return Container(
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
                    reservations.sort(
                      (a, b) => b.dateCreated!.compareTo(a.dateCreated!),
                    );
                    if (reservations.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: reservations.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ReservationUserCardView(
                            reservation: reservations[index],
                            doneFunction: () {
                              PopUp().whenDoSomething(
                                context,
                                "Ingin menyelesaikan reservasi?",
                                Icons.check_circle,
                                actionReservationAndHistory(
                                  reservations[index],
                                  "Selesai",
                                ),
                              );
                            },
                            cancelFunction: () {
                              PopUp().whenDoSomething(
                                context,
                                "Ingin membatalkan reservasi?",
                                Icons.cancel,
                                actionReservationAndHistory(
                                  reservations[index],
                                  "Dibatalkan",
                                ),
                              );
                            },
                            deleteFunction: () {
                              PopUp().whenDoSomething(
                                context,
                                "Ingin menghapus reservasi?",
                                Icons.delete_forever,
                                actionReservationAndHistory(
                                  reservations[index],
                                  "Ditolak",
                                ),
                              );
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
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    getReservationByRole();
    return Scaffold(
      body: Stack(
        children: [
          BlocListener<ReservationBloc, ReservationState>(
            listener: (context, state) {
              if (state is ReservationUpdateSuccess) {
                PopUp().whenSuccessDoSomething(
                  context,
                  "Berhasil",
                  Icons.check_circle,
                );
              } else if (state is ReservationDeleteSuccess) {
                PopUp().whenSuccessDoSomething(
                  context,
                  "Berhasil",
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
                        getReservationByRole();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              listReservationByRole(),
                              const Gap(40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                if (state is HistoryLoading) {
                  return const CustomLoading();
                }
                return const SizedBox();
              },
            ),
          ),
          Center(
            child: BlocBuilder<ReservationBloc, ReservationState>(
              builder: (context, state) {
                if (state is ReservationLoading) {
                  return const CustomLoading();
                }
                return const SizedBox();
              },
            ),
          ),
          Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const CustomLoading();
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
