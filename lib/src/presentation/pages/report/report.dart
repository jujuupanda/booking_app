import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:reservation_app/src/presentation/pages/history/widget_report_card_view.dart';

import '../../../data/bloc/history/history_bloc.dart';
import '../../../data/model/history_model.dart';
import '../../utils/general/parsing.dart';
import '../../widgets/general/header_pages.dart';
import '../history/widget_history_card_view.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late HistoryBloc _historyBloc;

  _getAllHistory() {
    _historyBloc = context.read<HistoryBloc>();
    _historyBloc.add(GetAllHistoryAdmin());
  }

  @override
  void didChangeDependencies() {
    _getAllHistory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const HeaderPage(
              name: "Laporan",
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getAllHistory();
                },
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(8),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.filter_alt),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<HistoryBloc, HistoryState>(
                            builder: (context, state) {
                              if (state is HistoryGetSuccess) {
                                final histories = state.histories;
                                if (histories.isNotEmpty) {
                                  return GroupedListView<HistoryModel, String>(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    elements: histories,
                                    groupBy: (element) => ParsingDate()
                                        .convertDateOnlyMonth(
                                        element.dateCreated!),
                                    order: GroupedListOrder.DESC,
                                    groupSeparatorBuilder:
                                        (String groupByValue) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8,
                                          top: 20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              groupByValue,
                                              style: GoogleFonts.openSans(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    itemBuilder: (context, element) {
                                      return ReportCardView(
                                        history: element,
                                        function: () {},
                                      );
                                    },
                                  );
                                } else {
                                  return const Column(
                                    children: [
                                      Gap(30),
                                      Center(
                                        child: Text(
                                          "Laporan reservasi kosong",
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              } else {
                                return const SizedBox(
                                  height: 500,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
