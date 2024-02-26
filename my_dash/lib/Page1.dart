// page1.dart
// import 'package:flutter/material.dart';

// class Page1 extends StatefulWidget {
//   const Page1({Key? key}) : super(key: key);

//   @override
//   Page0State createState() => Page0State();
// }

// class Page0State extends State<Page1> {
//   int tag = 3;
//   List<String> tags = ['Tracking'];
//   List<String> options = [
//     'Recharge',
//     'Achat option',
//     'Promos',
//     'Bons plans',
//     'Transfert internet',
//     'Transfert crédit',
//     'Dates',
//     'E-Shop',
//     'Roue de la chance',
//     'Services',
//     'Paiement de facture',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0.0,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Content(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: options.map((String option) {
//                     return Container(
//                       margin: const EdgeInsets.only(right: 8.0),
//                       child: ChoiceChip(
//                         label: Text(option),
//                         selected: tag == options.indexOf(option),
//                         onSelected: (bool selected) {
//                           setState(() {
//                             tag = selected ? options.indexOf(option) : -1;
//                           });
//                         },
//                         selectedColor: Color.fromARGB(223, 0, 0, 0),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Content extends StatelessWidget {
//   final Widget child;

//   const Content({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: child,
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class Page1 extends StatefulWidget {
//   const Page1({Key? key}) : super(key: key);

//   @override
//   Page1State createState() => Page1State();
// }

// class Page1State extends State<Page1> {
//   int tag = 3;
//   List<String> tags = ['Tracking'];
//   List<String> options = [
//     'Recharge',
//     'Achat option',
//     'Promos',
//     'Bons plans',
//     'Transfert internet',
//     'Transfert crédit',
//     'Dates',
//     'E-Shop',
//     'Roue de la chance',
//     'Services',
//     'Paiement de facture',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0.0,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Content(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: options.map((String option) {
//                     return Container(
//                       margin: const EdgeInsets.only(right: 8.0),
//                       child: ChoiceChip(
//                         label: Text(
//                           option,
//                           style: TextStyle(
//                             color: tag == options.indexOf(option)
//                                 ? Colors.white
//                                 : Colors.black,
//                           ),
//                         ),
//                         selected: tag == options.indexOf(option),
//                         onSelected: (bool selected) {
//                           setState(() {
//                             tag = selected ? options.indexOf(option) : -1;
//                           });
//                         },
//                         selectedColor: Colors.black,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Content extends StatelessWidget {
//   final Widget child;

//   const Content({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: child,
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class Page1 extends StatefulWidget {
//   const Page1({Key? key}) : super(key: key);

//   @override
//   Page1State createState() => Page1State();
// }

// class Page1State extends State<Page1> {
//   int tag = 3;
//   List<String> tags = ['Tracking'];
//   List<String> options = [
//     'Recharge',
//     'Achat option',
//     'Promos',
//     'Bons plans',
//     'Transfert internet',
//     'Transfert crédit',
//     'Dates',
//     'E-Shop',
//     'Roue de la chance',
//     'Services',
//     'Paiement de facture',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0.0,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Content(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: options.map((String option) {
//                     return Container(
//                       margin: const EdgeInsets.only(right: 8.0),
//                       child: ChoiceChip(
//                         label: Text(
//                           option,
//                           style: TextStyle(
//                             color: tag == options.indexOf(option)
//                                 ? Colors.white
//                                 : Colors.black,
//                           ),
//                         ),
//                         selected: tag == options.indexOf(option),
//                         onSelected: (bool selected) {
//                           setState(() {
//                             tag = selected ? options.indexOf(option) : -1;
//                           });
//                         },
//                         selectedColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Content extends StatelessWidget {
//   final Widget child;

//   const Content({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: child,
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class Page1 extends StatelessWidget {
//   @override
//    Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       // Your content for Page 0
//       child: ListView.builder(
//         itemCount: 10, // Adjust the number of items as needed
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'assets/Orange_small_logo.png', // Replace with the correct asset path
//               height: 100, // Set the desired height
//               width: 100,  // Set the desired width
//             ),
//           );
//         },
//       ),
//     );
//   }
// }