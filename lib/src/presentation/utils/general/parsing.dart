import 'package:intl/intl.dart';

class ParsingDate {
  String convertDate(String input) {
    final parsedEnglish =
    DateFormat('dd MMMM yyyy').format(DateTime.parse(input));
    return parsedEnglish.replaceAllMapped(
      RegExp(
          r'\b(January|February|March|April|May|June|July|August|September|October|November|December)\b'),
          (Match match) {
        switch (match.group(0)) {
          case 'January':
            return 'Januari';
          case 'February':
            return 'Februari';
          case 'March':
            return 'Maret';
          case 'April':
            return 'April';
          case 'May':
            return 'Mei';
          case 'June':
            return 'Juni';
          case 'July':
            return 'Juli';
          case 'August':
            return 'Agustus';
          case 'September':
            return 'September';
          case 'October':
            return 'Oktober';
          case 'November':
            return 'November';
          case 'December':
            return 'Desember';
          default:
            return match.group(0)!;
        }
      },
    );
  }

  String convertDateWithHour(String input) {
    final parsedEnglish =
    DateFormat('dd MMMM yyyy  kk:mm').format(DateTime.parse(input));
    return parsedEnglish.replaceAllMapped(
      RegExp(
          r'\b(January|February|March|April|May|June|July|August|September|October|November|December)\b'),
          (Match match) {
        switch (match.group(0)) {
          case 'January':
            return 'Januari';
          case 'February':
            return 'Februari';
          case 'March':
            return 'Maret';
          case 'April':
            return 'April';
          case 'May':
            return 'Mei';
          case 'June':
            return 'Juni';
          case 'July':
            return 'Juli';
          case 'August':
            return 'Agustus';
          case 'September':
            return 'September';
          case 'October':
            return 'Oktober';
          case 'November':
            return 'November';
          case 'December':
            return 'Desember';
          default:
            return match.group(0)!;
        }
      },
    );
  }

  String convertDateOnlyMonth(String input) {
    final parsedEnglish = DateFormat('MMMM yyyy').format(DateTime.parse(input));
    return parsedEnglish.replaceAllMapped(
      RegExp(
          r'\b(January|February|March|April|May|June|July|August|September|October|November|December)\b'),
          (Match match) {
        switch (match.group(0)) {
          case 'January':
            return 'Januari';
          case 'February':
            return 'Februari';
          case 'March':
            return 'Maret';
          case 'April':
            return 'April';
          case 'May':
            return 'Mei';
          case 'June':
            return 'Juni';
          case 'July':
            return 'Juli';
          case 'August':
            return 'Agustus';
          case 'September':
            return 'September';
          case 'October':
            return 'Oktober';
          case 'November':
            return 'November';
          case 'December':
            return 'Desember';
          default:
            return match.group(0)!;
        }
      },
    );
  }
}