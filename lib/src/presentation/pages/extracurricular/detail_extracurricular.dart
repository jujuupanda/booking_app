import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation_app/src/data/model/extracurricular_model.dart';

import '../../utils/constant/constant.dart';
import '../../widgets/general/header_detail_page.dart';

class DetailExtracurricularPage extends StatefulWidget {
  const DetailExtracurricularPage({
    super.key,
    required this.extracurricular,
  });

  final ExtracurricularModel extracurricular;

  @override
  State<DetailExtracurricularPage> createState() =>
      _DetailExtracurricularPageState();
}

class _DetailExtracurricularPageState extends State<DetailExtracurricularPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderDetailPage(
            pageName: widget.extracurricular.name!,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset(
                        imageNoConnection,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.extracurricular.name!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.extracurricular.description!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            "Jadwal",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.extracurricular.schedule!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            "Instansi",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.extracurricular.agency!,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(60),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
