// import 'package:cattle_app/core/constants/color_const.dart';
// import 'package:flutter/material.dart';

// class MenuConfiguration extends StatelessWidget {
//   const MenuConfiguration({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           width: 1,
//           color: Palette.gray3,
//         ),
//         boxShadow: [
//           BoxShadow(
//             spreadRadius: 3,
//             blurRadius: 4,
//             offset: const Offset(0, 1),
//             color: Colors.black.withOpacity(.1),
//           ),
//         ],
//         color: Palette.gray1,
//       ),
//       padding: EdgeInsets.all(18),
//       child: Column(
//         children: [
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 buildConfigurationCard(
//                   title: 'Resolusi (px)',
//                   data: '100 x 100',
//                 ),
//                 SizedBox(
//                   width: 8,
//                 ),
//                 buildConfigurationCard(
//                   title: 'Jarak Gambar dari object (m)',
//                   data: '100',
//                 ),
//               ]),
//           SizedBox(
//             height: 8,
//           ),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 buildConfigurationCard(
//                   title: 'Panjang Object (m)',
//                   data: '200',
//                 ),
//                 SizedBox(
//                   width: 8,
//                 ),
//                 buildConfigurationCard(
//                   title: 'Panjang Object (px)',
//                   data: '100',
//                 ),
//               ]),
//         ],
//       ),
//     );
//   }

//   buildConfigurationCard({required String title, required String data}) {
//     return Expanded(
//       child: Container(
//         height: 100,
//         decoration: BoxDecoration(
//           border:
//               Border.all(width: 1, color: Palette.secondary.withOpacity(.75)),
//           borderRadius: BorderRadius.circular(6),
//         ),
//         padding: EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 height: 1,
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               data,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: Palette.secondary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
