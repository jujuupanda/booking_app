import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/bloc/reservation/reservation_bloc.dart';
import 'package:reservation_app/src/data/bloc/reservation_building/reservation_building_bloc.dart';
import 'package:reservation_app/src/data/model/building_model.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';
import 'package:reservation_app/src/presentation/utils/routes/route_name.dart';

import '../../../data/bloc/user/user_bloc.dart';

class ConfirmReservationPage extends StatefulWidget {
  const ConfirmReservationPage({
    super.key,
    required this.building,
    required this.dateStart,
    required this.dateEnd,
  });

  final BuildingModel building;
  final String dateStart;
  final String dateEnd;

  @override
  State<ConfirmReservationPage> createState() => _ConfirmReservationPageState();
}

class _ConfirmReservationPageState extends State<ConfirmReservationPage> {
  late TextEditingController buildingNameController;
  late TextEditingController dateUsedController;
  late TextEditingController informationController;
  late ReservationBloc _reservationBloc;
  late UserBloc _userBloc;
  late String contactId;
  late String contactName;
  late String contactEmail;
  late String contactPhone;

  _getUser() {
    _userBloc = context.read<UserBloc>();
    _userBloc.add(GetUser());
  }

  _createReservation(
    String buildingName,
    String contactId,
    String contactName,
    String contactEmail,
    String contactPhone,
    String dateStart,
    String dateEnd,
    String information,
  ) {
    _reservationBloc = context.read<ReservationBloc>();
    _reservationBloc.add(
      CreateReservation(
        buildingName,
        contactId,
        contactName,
        contactEmail,
        contactPhone,
        dateStart,
        dateEnd,
        information,
      ),
    );
  }

  _confirmReservation(
    String buildingName,
    String contactId,
    String contactName,
    String contactEmail,
    String contactPhone,
    String dateStart,
    String dateEnd,
    String information,
  ) async {
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
                  'Ingin membuat reservasi?',
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
                    _createReservation(
                      buildingName,
                      contactId,
                      contactName,
                      contactEmail,
                      contactPhone,
                      dateStart,
                      dateEnd,
                      information,
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
                        'Buat',
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

  _popBack() async {
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
                  'Ingin kembali ke halaman reservasi?',
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
                    context.pop();
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
                        'Kembali',
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
  void initState() {
    _getUser();
    buildingNameController = TextEditingController(text: widget.building.name);
    informationController = TextEditingController();
    dateUsedController = TextEditingController(
        text:
            "${ParsingDate().convertDate(widget.dateStart)} - ${ParsingDate().convertDate(widget.dateEnd)}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserGetSuccess) {
              contactId = state.user.username!;
              contactName = state.user.fullName!;
              contactEmail = state.user.email!;
              contactPhone = state.user.phone!;
            }
          },
        ),
        BlocListener<ReservationBloc, ReservationState>(
          listener: (context, state) {
            if (state is ReservationCreateSuccess) {
              BlocProvider.of<ReservationBuildingBloc>(context)
                  .add(InitialBuildingAvail());
              context.goNamed(Routes().home);
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _popBack();
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          const Text(
                            "Konfirmasi Reservasi",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(20),
                            const Text(
                              "Nama Gedung",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const Gap(8),
                            TextFormField(
                              controller: buildingNameController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.corporate_fare),
                              ),
                            ),
                            const Gap(10),
                            const Text(
                              "Tanggal Pakai",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const Gap(10),
                            TextFormField(
                              readOnly: true,
                              controller: dateUsedController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.date_range),
                              ),
                            ),
                            const Gap(10),
                            const Text(
                              "Keterangan",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const Gap(10),
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: informationController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.info_rounded),
                              ),
                            ),
                            const Gap(30),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _confirmReservation(
                                        widget.building.name!,
                                        contactId,
                                        contactName,
                                        contactEmail,
                                        contactPhone,
                                        widget.dateStart,
                                        widget.dateEnd,
                                        informationController.text.toString(),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Text(
                                        "Reservasi Sekarang",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            BlocBuilder<ReservationBloc, ReservationState>(
              builder: (context, state) {
                if (state is ReservationLoading) {
                  return Container(
                    decoration: const BoxDecoration(color: Color(0x80FFFFFF)),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
