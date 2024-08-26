import 'package:flutter/material.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';
import 'package:reservation_app/src/presentation/utils/general/parsing.dart';

import '../../../data/model/history_model.dart';

class HistoryCardView extends StatelessWidget {
  const HistoryCardView({
    super.key,
    required this.history,
    required this.function,
  });

  final HistoryModel history;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey)),
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
                      history.buildingName!,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      "Mulai: ${ParsingDate().convertDate(history.dateStart!)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Akhir: ${ParsingDate().convertDate(history.dateEnd!)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Dibuat: ${ParsingDate().convertDate(history.dateCreated!)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Ketarangan: ${history.information}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Status: ${history.status}",
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
