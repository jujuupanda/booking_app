import 'package:flutter/material.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';

class ReservationCardView extends StatelessWidget {
  const ReservationCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.white),
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
                const Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "GOS SMANSA GOS SMANSA GOS SMANSA GOS SMANSA",
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      "Mulai: 10 Januari 2024",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Akhir: 12 Januari 2024",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Jumlah Tamu: 50 Orang",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Status: Menunggu persetujuan",
                      style: TextStyle(fontSize: 12),
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
