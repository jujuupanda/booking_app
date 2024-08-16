import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reservation_app/src/data/model/reservation_model.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';

import '../../utils/general/parsing.dart';

class ReservationAdminCardView extends StatelessWidget {
  const ReservationAdminCardView({
    super.key,
    required this.reservation,
    required this.function,
  });

  final ReservationModel reservation;
  final VoidCallback function;

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
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
                child: SizedBox(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation.buildingName!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        "Pengguna: ${reservation.contactName}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Mulai: ${ParsingDate().convertDate(reservation.dateStart!)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Selesai: ${ParsingDate().convertDate(reservation.dateEnd!)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Status: ${reservation.status}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          "Keterangan: ${reservation.information}",
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Colors.blueAccent,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: function,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text(
                                    "Konfirmasi Reservasi",
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
