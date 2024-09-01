import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
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
              SizedBox(
                height: 120,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageNoConnection,
                    scale: 1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        history.buildingName!,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        "Mulai: ${ParsingDate().convertDate(history.dateStart!)}",
                        style: GoogleFonts.openSans(fontSize: 12),
                      ),
                      Text(
                        "Selesai: ${ParsingDate().convertDate(history.dateEnd!)}",
                        style: GoogleFonts.openSans(fontSize: 12),
                      ),
                      Text(
                        "Dibuat: ${ParsingDate().convertDate(history.dateCreated!)}",
                        style: GoogleFonts.openSans(fontSize: 12),
                      ),
                      Text(
                        "Ketarangan: ${history.information}",
                        style: GoogleFonts.openSans(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Container(
                        width: 120,
                        decoration: history.status == "Selesai"
                            ? BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              )
                            : BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          child: Center(
                            child: Text(
                              history.status!,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
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
