import 'package:flutter/material.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';

class ReservationCardView extends StatelessWidget {
  const ReservationCardView({
    super.key,
    required this.buildingName,
    required this.dateStart,
    required this.dateEnd,
    required this.numberOfGuest,
    required this.status,
  });

  final String buildingName;
  final String dateStart;
  final String dateEnd;
  final String numberOfGuest;
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
            children: [
              Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      imageNoConnection,
                      fit: BoxFit.fill,
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
                      "Akhir: $dateEnd",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Jumlah Tamu: $numberOfGuest Orang",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Status: $status",
                      style: const TextStyle(fontSize: 12),
                    ),
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
