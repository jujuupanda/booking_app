import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:reservation_app/src/presentation/widgets/general/widget_custom_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/bloc/history/history_bloc.dart';
import '../../../data/model/history_model.dart';
import '../../utils/general/parsing.dart';
import '../../widgets/general/header_pages.dart';
import 'widget_history_card_view.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryBloc _historyBloc;
  late String userRole;

  /// user: mendapatkan informasi riwayat
  _getHistory() {
    _historyBloc = context.read<HistoryBloc>();
    _historyBloc.add(GetHistoryUser());
  }

  /// admin: mendapatkan informasi laporan
  _getReport() {
    _historyBloc = context.read<HistoryBloc>();
    _historyBloc.add(GetReportAdmin());
  }

  /// umum: mendapatkan informasi laporan riwayat reservasi
  getHistoryReport() {
    if (userRole == "1") {
      return _getReport();
    } else if (userRole == "2") {
      return _getHistory();
    } else {
      return () {};
    }
  }

  /// umum: mendapatkan informasi role
  getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString("role")!;
    setState(() {
      userRole = userRole;
    });
  }


  @override
  void didChangeDependencies() {
    userRole = "";
    getRole();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getHistoryReport();
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                headerPage(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      getHistoryReport();
                    },
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              buttonFilter(),
                              BlocBuilder<HistoryBloc, HistoryState>(
                                builder: (context, state) {
                                  if (state is HistoryGetSuccess) {
                                    final histories = state.histories;
                                    histories.sort(
                                      (a, b) => a.dateFinished!
                                          .compareTo(b.dateFinished!),
                                    );
                                    if (histories.isNotEmpty) {
                                      return GroupedListView<HistoryModel,
                                          String>(
                                        padding: EdgeInsets.zero,
                                        elements: histories,
                                        shrinkWrap: true,
                                        groupBy: (element) =>
                                            ParsingDate().convertDateOnlyMonth(
                                          element.dateCreated!,
                                        ),
                                        order: GroupedListOrder.DESC,
                                        sort: true,
                                        groupSeparatorBuilder:
                                            (String groupByValue) {
                                          return _groupSeparatorBuilder(
                                              groupByValue);
                                        },
                                        itemBuilder: (context, element) {
                                          return HistoryCardView(
                                            history: element,
                                            function: () {},
                                            role: userRole,
                                          );
                                        },
                                      );
                                    } else {
                                      return isEmptyText();
                                    }
                                  } else {
                                    return const SizedBox();
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
            Center(
              child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const CustomLoading();
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _groupSeparatorBuilder(String groupByValue) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
  }

  isEmptyText() {
    if (userRole == "1") {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            "Tidak ada laporan reservasi",
            style: GoogleFonts.openSans(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (userRole == "2") {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            "Tidak ada riwayat reservasi",
            style: GoogleFonts.openSans(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  headerPage() {
    if (userRole == "1") {
      return const HeaderPage(
        name: "Laporan",
      );
    } else if (userRole == "2") {
      return const HeaderPage(
        name: "Riwayat Reservasi",
      );
    } else {
      return const SizedBox();
    }
  }

  buttonFilter() {
    return Align(
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
    );
  }
}
