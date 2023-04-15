// import 'package:flutter/material.dart';
// import 'package:news_app/app/core/env/env.dart';

// class Favorit extends StatefulWidget {
//   @override
//   State<Favorit> createState() => _FavoritState();
// }

// class _FavoritState extends State<Favorit> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: Icon(Icons.arrow_back)),
//         title: Text(
//           'Favorit',
//           style: TextStyle(fontSize: 23),
//         ),
//         backgroundColor: const Color(0xff4f9b9b),
//       ),
//       body: FutureBuilder(
//         future: con,
//         child: Column(
//           children: [
//             Card(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.1,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 30,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                     child: Text(
//                                       'Ab',
//                                       style:
//                                           Theme.of(context).textTheme.bodyText2,
//                                     ),
//                                   ),
//                                   IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           // widget.favorit = true;
//                                         });
//                                       },
//                                       icon: Icon(
//                                         Icons.star,
//                                         size: 20,
//                                         color: Color(0xff4f9b9b),
//                                       ))
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Divider(
//                               height: 5,
//                               thickness: 2,
//                             ),
//                             SizedBox(height: 5),
//                             Flexible(
//                               child: Text(
//                                 'Antibodi. Disebut juga glubulin gamma.',
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 10,
//                                 softWrap: false,
//                                 style: Theme.of(context).textTheme.subtitle2,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
