import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PopUp {

  // whenDoSomething(BuildContext context, String text, IconData icon,
  //     Function function) async {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: SizedBox(
  //           height: 130,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Expanded(
  //                 child: Icon(
  //                   icon,
  //                   size: 60,
  //                   color: Colors.blueAccent,
  //                 ),
  //               ),
  //               const Gap(10),
  //               Text(
  //                 text,
  //                 style: const TextStyle(fontSize: 14),
  //                 textAlign: TextAlign.center,
  //               )
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 borderRadius: BorderRadius.circular(10),
  //                 child: Container(
  //                   height: 40,
  //                   width: 100,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     border: Border.all(
  //                       width: 1,
  //                       color: Colors.blueAccent,
  //                     ),
  //                   ),
  //                   child: const Center(
  //                     child: Text(
  //                       'Tidak',
  //                       style: TextStyle(
  //                         color: Colors.blueAccent,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   function();
  //                   Navigator.of(context).pop();
  //                 },
  //                 borderRadius: BorderRadius.circular(10),
  //                 child: Container(
  //                   height: 40,
  //                   width: 100,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: Colors.blueAccent,
  //                   ),
  //                   child: const Center(
  //                     child: Text(
  //                       'Ya',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  whenSuccessDoSomething(
      BuildContext context, String text, IconData icon) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
                const Gap(10),
                Text(
                  text,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent),
                    child: const Center(
                      child: Text(
                        'Ya',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
