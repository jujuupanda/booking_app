import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:reservation_app/src/data/bloc/history/history_bloc.dart';
import 'package:reservation_app/src/presentation/widgets/general/history_model.dart';

import '../../widgets/general/header_pages.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryBloc _historyBloc;

  _getHistory() {
    _historyBloc = context.read<HistoryBloc>();
    _historyBloc.add(GetHistory());
  }

  @override
  void didChangeDependencies() {
    _getHistory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const HeaderPage(
              name: "Riwayat Reservasi",
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getHistory();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: BlocBuilder<HistoryBloc, HistoryState>(
                    builder: (context, state) {
                      if (state is HistoryGetSuccess) {
                        final histories = state.histories;
                        if (histories.isNotEmpty) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: histories.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: HistoryCardView(
                                      imagePath: histories[index].image!,
                                      buildingName:
                                          histories[index].buildingName!,
                                      dateStart: histories[index].dateStart!,
                                      dateEnd: histories[index].dateEnd!,
                                      numberOfGuest: histories[index]
                                          .numberOfGuest!
                                          .toString(),
                                      created: histories[index].dateCreated!,
                                      function: () {}));
                            },
                          );
                        } else {
                          return const Column(
                            children: [
                              Gap(30),
                              Center(
                                child: Text(
                                  "Tidak ada riwayat reservasi",
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
