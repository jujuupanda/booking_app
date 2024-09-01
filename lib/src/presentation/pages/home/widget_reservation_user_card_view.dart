import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';

import '../../../data/model/reservation_model.dart';

class ReservationUserCardView extends StatelessWidget {
  const ReservationUserCardView({
    super.key,
    required this.reservation,
    required this.doneFunction,
    required this.cancelFunction,
    required this.deleteFunction,
  });

  final ReservationModel reservation;
  final VoidCallback doneFunction;
  final VoidCallback cancelFunction;
  final VoidCallback deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 140,
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imageNoConnection,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reservation.buildingName!,
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          "Pengguna: ${reservation.contactName}",
                          style: GoogleFonts.openSans(fontSize: 12),
                        ),
                        Text(
                          "Mulai: ${ParsingDate().convertDate(reservation.dateStart!)}",
                          style: GoogleFonts.openSans(fontSize: 12),
                        ),
                        Text(
                          "Selesai: ${ParsingDate().convertDate(reservation.dateEnd!)}",
                          style: GoogleFonts.openSans(fontSize: 12),
                        ),
                        Text(
                          "Status: ${reservation.status}",
                          style: GoogleFonts.openSans(fontSize: 12),
                        ),
                        Text(
                          "Keterangan: ${reservation.information}",
                          style: GoogleFonts.openSans(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Builder(
                  builder: (context) {
                    if (reservation.status == "Menunggu") {
                      return ButtonActionReservationUser(
                        name: "Batal",
                        function: cancelFunction,
                      );
                    } else if (reservation.status == "Disetujui") {
                      return ButtonActionReservationUser(
                        name: "Selesai",
                        function: doneFunction,
                      );
                    } else if (reservation.status == "Ditolak") {
                      return ButtonActionReservationUser(
                        name: "Hapus",
                        function: deleteFunction,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonActionReservationUser extends StatelessWidget {
  const ButtonActionReservationUser({
    super.key,
    required this.name,
    required this.function,
  });

  final String name;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: name == "Selesai"
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Colors.blueAccent,
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Colors.redAccent,
              ),
            ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: function,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Center(
              child: Text(
                name,
                style: name == "Selesai"
                    ? GoogleFonts.openSans(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      )
                    : GoogleFonts.openSans(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
