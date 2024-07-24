import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';

class ReservationCardView extends StatelessWidget {
  const ReservationCardView({
    super.key,
    required this.buildingName,
    required this.dateStart,
    required this.dateEnd,
    required this.information,
    required this.status,
  });

  final String buildingName;
  final String dateStart;
  final String dateEnd;
  final String information;
  final String status;

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
                height: 180,
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
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buildingName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        "Mulai: $dateStart",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Selesai: $dateEnd",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Status: $status",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Keterangan: $information",
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                //muncul pop up yang memberitahu jika ingin membatalkan
                                //reservasi
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Batalkan Reservasi"),
                              ),
                            ),
                          ),
                        ),
                      )
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
