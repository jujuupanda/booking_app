import 'package:flutter/material.dart';
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
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 180,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      imageNoConnection,
                      fit: BoxFit.cover,
                    ),
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buildingName,
                      style: const TextStyle(fontSize: 16),
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
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
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
            ],
          ),
        ),
      ),
    );
  }
}
