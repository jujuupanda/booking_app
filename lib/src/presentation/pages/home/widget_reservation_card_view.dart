import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../data/model/reservation_model.dart';
import '../../utils/constant/constant.dart';
import '../../utils/general/parsing.dart';
import '../../widgets/general/widget_title_desc_card_view.dart';
import '../../widgets/general/widget_text_content_reservation.dart';
import 'widget_button_action.dart';

class ReservationCardView extends StatelessWidget {
  const ReservationCardView({
    super.key,
    required this.reservation,
    this.acceptFunction,
    this.declineFunction,
    this.doneFunction,
    this.cancelFunction,
    this.deleteFunction,
    required this.role,
  });

  final ReservationModel reservation;
  final VoidCallback? acceptFunction;
  final VoidCallback? declineFunction;
  final VoidCallback? doneFunction;
  final VoidCallback? cancelFunction;
  final VoidCallback? deleteFunction;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
                        TextTitleDescriptionCardView(
                          text: reservation.buildingName!,
                          isTitle: true,
                        ),
                        role == "1"
                            ? TextContentCardView(
                                name: "Pengguna",
                                content: reservation.contactName!,
                              )
                            : const SizedBox(),
                        TextContentCardView(
                          name: "Mulai",
                          content:
                              ParsingDate().convertDateWithHour(reservation.dateStart!),
                        ),
                        TextContentCardView(
                          name: "Selesai",
                          content:
                              ParsingDate().convertDateWithHour(reservation.dateEnd!),
                        ),
                        TextContentCardView(
                          name: "Status",
                          content: reservation.status!,
                        ),
                        const TextTitleDescriptionCardView(
                          text: "Keterangan",
                        ),
                        TextTitleDescriptionCardView(
                          text: reservation.information!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              buttonByRole(),
            ],
          ),
        ),
      ),
    );
  }

  buttonByRole() {
    if (role == "1") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonAction(
            name: "Tolak",
            function: declineFunction ?? () {},
          ),
          const Gap(10),
          ButtonAction(
            name: "Terima",
            function: acceptFunction ?? () {},
          ),
        ],
      );
    } else if (role == "2") {
      return Align(
        alignment: Alignment.bottomRight,
        child: Builder(
          builder: (context) {
            if (reservation.status == "Menunggu") {
              return ButtonAction(
                name: "Batal",
                function: cancelFunction ?? () {},
              );
            } else if (reservation.status == "Disetujui") {
              return ButtonAction(
                name: "Selesai",
                function: doneFunction ?? () {},
              );
            } else if (reservation.status == "Ditolak") {
              return ButtonAction(
                name: "Hapus",
                function: deleteFunction ?? () {},
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
