import 'package:flutter/material.dart';

class ReservationCardView extends StatelessWidget {
  const ReservationCardView(
      {super.key,
      required this.buildingName,
      required this.numberOfGuest,
      required this.dateStart,
      required this.dateEnd});

  final String buildingName;
  final String numberOfGuest;
  final String dateStart;
  final String dateEnd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.black),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                buildingName,
                style: const TextStyle(fontSize: 24),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text("Jumlah Tamu: $numberOfGuest"),
              Text("Tanggal Mulai: $dateStart"),
              Text("Tanggal Akhir: $dateEnd"),
            ],
          ),
        ),
      ),
    );
  }
}
