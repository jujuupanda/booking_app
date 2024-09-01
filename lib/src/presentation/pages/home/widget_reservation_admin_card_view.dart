import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/reservation_model.dart';
import '../../utils/constant/constant.dart';
import '../../utils/general/parsing.dart';
import 'widget_button_accept_decline.dart';

class ReservationAdminCardView extends StatelessWidget {
  const ReservationAdminCardView({
    super.key,
    required this.reservation,
    required this.acceptFunction,
    required this.declineFunction,
  });

  final ReservationModel reservation;
  final VoidCallback acceptFunction;
  final VoidCallback declineFunction;

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
                    height: 150,
                    width: 120,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonAcceptDecline(
                    name: "Tolak",
                    function: declineFunction,
                  ),
                  const Gap(10),
                  ButtonAcceptDecline(
                    name: "Terima",
                    function: acceptFunction,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

