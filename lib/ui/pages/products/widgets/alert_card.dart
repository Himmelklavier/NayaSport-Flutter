// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';

// class AlertCard extends StatelessWidget {
//   final int status;
//   AlertCard({super.key, required this.status});

//   final Map<String, dynamic> success = {
//     "icon": const Icon(
//       Icons.check,
//       color: Colors.green,
//       size: 30.0,
//     ),
//     "titleMessage": "Agregado con exito",
//   };

//   final Map<String, dynamic> reject = {
//     "icon": const Icon(
//       Icons.error,
//       color: Colors.red,
//       size: 30.0,
//     ),
//     "titleMessage": "Error al agregar al producto",
//   };

//   statusCard() {
//     return status == 200
//         ? {
//             "icon": const Icon(
//               Icons.check,
//               color: Colors.green,
//               size: 30.0,
//             ),
//             "titleMessage": "Agregado con exito",
//           }
//         : reject;
//   }

//   @override
//   Widget build(BuildContext context) {
//    showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             icon: const Icon(
//               Icons.check,
//               color: Colors.green,
//               size: 30.0,
//             ),
//             title: const Text('jj'),
//             content: const Text('AlertDialog description'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Cancel'),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'OK'),
//                 child: const Text('OK'),
//               ),
//             ],
//             elevation: 24.0,
//           );
  
//         });
//   }
// }
