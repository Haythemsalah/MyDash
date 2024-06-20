
// import 'package:flutter/material.dart';
// import 'package:my_dash/Naviguation%20menu/PageMenu.dart'; // Import your pages
// import 'package:my_dash/Layout/PageB.dart'; // Import your pages
// import 'package:my_dash/Layout/PageC.dart';
// import 'package:my_dash/Layout/PageD.dart'; 
// // Import your pages
// import 'package:provider/provider.dart';

// class Pagefromswipe0 extends StatelessWidget {
//   final List<String> imagePaths = [
//     'assets/kpi_dashboard_main.png', 
//     'assets/dashboard-modern.png',
//     'assets/customer.png',
//     'assets/dash4.png',
//   ];

//   final List<String> otherImagePaths = [
//     'assets/1.png', // Replace with your additional image paths
//     'assets/2.png',
//     'assets/3.png',
//   ];

//   // List of pages corresponding to each container
//   final List<Widget> pages = [
//     PageD(),
//     PageB(),
//     PageC(),
//     // Add more pages as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'KPIs',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: themeProvider.isDarkMode ? Colors.white : Colors.black,
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             height: 150, // Adjust the height based on your needs
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: imagePaths.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: InkWell(
//                     onTap: () {
//                       // Navigate to the corresponding page when container is tapped
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => pages[index]),
//                       );
//                     },
//                     child: Container(
//                       height: 150, // Adjust the height based on your needs
//                       width: 200, // Adjust the width based on your needs
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: themeProvider.isDarkMode
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset(
//                           imagePaths[index],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 20),
        
//           Container(
//             height: 250, // Adjust the height based on your needs
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: otherImagePaths.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: InkWell(
//                     onTap: () {
//                       // Navigate to the corresponding page when additional container is tapped
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => pages[index]),
//                       );
//                     },
//                     child: Container(
//                       height: 250, // Adjust the height based on your needs
//                       width: 200, // Adjust the width based on your needs
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: themeProvider.isDarkMode
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset(
//                           otherImagePaths[index],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:my_dash/Naviguation%20menu/PageMenu.dart'; // Import your pages
// import 'package:my_dash/Layout/PageB.dart'; // Import your pages
// import 'package:my_dash/Layout/PageC.dart';
// import 'package:my_dash/Layout/PageD.dart';
// import 'package:provider/provider.dart';
// import 'package:my_dash/services/RetrieveData_api.dart';

// class Pagefromswipe0 extends StatefulWidget {
//   @override
//   _Pagefromswipe0State createState() => _Pagefromswipe0State();
// }

// class _Pagefromswipe0State extends State<Pagefromswipe0> {
//   final List<String> imagePaths = [
//     'assets/kpi_dashboard_main.png',
//     'assets/dashboard-modern.png',
//     'assets/customer.png',
//     'assets/dash4.png',
//   ];

//   final List<String> otherImagePaths = [
//     'assets/1.png', // Replace with your additional image paths
//     'assets/2.png',
//     'assets/3.png',
//   ];

//   // List of pages corresponding to each container
//   final List<Widget> pages = [
//     PageD(),
//     PageB(),
//     PageC(),
//     // Add more pages as needed
//   ];

//   late Future<List<Fact>> futureFacts;

//   @override
//   void initState() {
//     super.initState();
//     futureFacts = ApiService().fetchFacts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'KPIs',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: themeProvider.isDarkMode ? Colors.white : Colors.black,
//             ),
//           ),
//           SizedBox(height: 20),
//           FutureBuilder<List<Fact>>(
//             future: futureFacts,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Text('No data available');
//               } else {
//                 // Filtrer pour obtenir la dernière valeur de TotalRechargeTNDHT différente de 0
//                 Fact? latestFactWithValue;
//                 for (var fact in snapshot.data!.reversed) {
//                   if (fact.totalRechargeTNDHT != 0) {
//                     latestFactWithValue = fact;
//                     break;
//                   }
//                 }

//                 return Container(
//                   height: 150, // Adjust the height based on your needs
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: imagePaths.length,
//                     itemBuilder: (context, index) {
//                       final imagePath = imagePaths[index];
//                       return Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: InkWell(
//                           onTap: () {
//                             // Navigate to the corresponding page when container is tapped
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => pages[index]),
//                             );
//                           },
//                           child: Container(
//                             height: 150, // Adjust the height based on your needs
//                             width: 200, // Adjust the width based on your needs
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: themeProvider.isDarkMode
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: (index == 0 || 
//                                       imagePath == 'assets/dashboard-modern.png' ||
//                                       imagePath == 'assets/customer.png' ||
//                                       imagePath == 'assets/dash4.png')
//                                   ? Center(
//                                       child: Text(
//                                         index == 0 && latestFactWithValue != null
//                                             ? 'TotalRechargeTNDHT = ${latestFactWithValue.totalRechargeTNDHT}'
//                                             : 'No Image',
//                                         style: TextStyle(
//                                           color: themeProvider.isDarkMode
//                                               ? Colors.white
//                                               : Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     )
//                                   : Image.asset(
//                                       imagePath,
//                                       fit: BoxFit.cover,
//                                     ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           ),
//           SizedBox(height: 20),
//           Container(
//             height: 250, // Adjust the height based on your needs
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: otherImagePaths.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: InkWell(
//                     onTap: () {
//                       // Navigate to the corresponding page when additional container is tapped
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => pages[index]),
//                       );
//                     },
//                     child: Container(
//                       height: 250, // Adjust the height based on your needs
//                       width: 200, // Adjust the width based on your needs
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: themeProvider.isDarkMode
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset(
//                           otherImagePaths[index],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:my_dash/Naviguation%20menu/PageMenu.dart'; // Import your pages
// import 'package:my_dash/Layout/PageB.dart'; // Import your pages
// import 'package:my_dash/Layout/PageC.dart';
// import 'package:my_dash/Layout/PageD.dart';
// import 'package:provider/provider.dart';
// import 'package:my_dash/services/RetrieveData_api.dart';

// class Pagefromswipe0 extends StatefulWidget {
//   @override
//   _Pagefromswipe0State createState() => _Pagefromswipe0State();
// }

// class _Pagefromswipe0State extends State<Pagefromswipe0> {
//   final List<String> imagePaths = [
//     'assets/kpi_dashboard_main.png',
//     'assets/dashboard-modern.png',
//     'assets/customer.png',
//     'assets/dash4.png',
//   ];

//   final List<String> otherImagePaths = [
//     'assets/1.png', // Replace with your additional image paths
//     'assets/2.png',
//     'assets/3.png',
//   ];

//   // List of pages corresponding to each container
//   final List<Widget> pages = [
//     PageD(),
//     PageB(),
//     PageC(),
//     // Add more pages as needed
//   ];

//   late Future<List<Fact>> futureFacts;

//   @override
//   void initState() {
//     super.initState();
//     futureFacts = ApiService().fetchFacts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'KPIs',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: themeProvider.isDarkMode ? Colors.white : Colors.black,
//             ),
//           ),
//           SizedBox(height: 20),
//           FutureBuilder<List<Fact>>(
//             future: futureFacts,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Text('No data available');
//               } else {
//                 // Filtrer pour obtenir la dernière valeur de TotalRechargeTNDHT différente de 0
//                 Fact? latestFactWithValue;
//                 for (var fact in snapshot.data!.reversed) {
//                   if (fact.totalRechargeTNDHT != 0) {
//                     latestFactWithValue = fact;
//                     break;
//                   }
//                 }

//                 return Column(
//                   children: [
//                     // Premier container avec TotalRechargeTNDHT
//                     Container(
//                       height: 150, // Adjust the height based on your needs
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: imagePaths.length,
//                         itemBuilder: (context, index) {
//                           final imagePath = imagePaths[index];
//                           return Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: InkWell(
//                               onTap: () {
//                                 // Navigate to the corresponding page when container is tapped
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => pages[index]),
//                                 );
//                               },
//                               child: Container(
//                                 height: 150, // Adjust the height based on your needs
//                                 width: 200, // Adjust the width based on your needs
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: themeProvider.isDarkMode
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: (index == 0 ||
//                                           imagePath == 'assets/dashboard-modern.png' ||
//                                           imagePath == 'assets/customer.png' ||
//                                           imagePath == 'assets/dash4.png')
//                                       ? Center(
//                                           child: Text(
//                                             index == 0 && latestFactWithValue != null
//                                                 ? 'TotalRechargeTNDHT = ${latestFactWithValue.totalRechargeTNDHT}'
//                                                 : 'No Image',
//                                             style: TextStyle(
//                                               color: themeProvider.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         )
//                                       : Image.asset(
//                                           imagePath,
//                                           fit: BoxFit.cover,
//                                         ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     // Deuxième container avec NombreRecharge
//                     Container(
//                       height: 250, // Adjust the height based on your needs
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: otherImagePaths.length,
//                         itemBuilder: (context, index) {
//                           final otherImagePath = otherImagePaths[index];
//                           return Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: InkWell(
//                               onTap: () {
//                                 // Navigate to the corresponding page when additional container is tapped
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => pages[index]),
//                                 );
//                               },
//                               child: Container(
//                                 height: 250, // Adjust the height based on your needs
//                                 width: 200, // Adjust the width based on your needs
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: themeProvider.isDarkMode
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: (index == 0 ||
//                                           otherImagePath == 'assets/2.png')
//                                       ? Center(
//                                           child: Text(
//                                             index == 0 && latestFactWithValue != null
//                                                 ? 'NombreRecharge = ${latestFactWithValue.nombreRecharge}'
//                                                 : 'No Image',
//                                             style: TextStyle(
//                                               color: themeProvider.isDarkMode
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         )
//                                       : Image.asset(
//                                           otherImagePath,
//                                           fit: BoxFit.cover,
//                                         ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:my_dash/Naviguation%20menu/PageMenu.dart'; // Import your pages
import 'package:my_dash/Layout/PageB.dart'; // Import your pages
import 'package:my_dash/Layout/PageC.dart';
import 'package:my_dash/Layout/PageD.dart';
import 'package:provider/provider.dart';
import 'package:my_dash/services/RetrieveData_api.dart';

class Pagefromswipe0 extends StatefulWidget {
  @override
  _Pagefromswipe0State createState() => _Pagefromswipe0State();
}

class _Pagefromswipe0State extends State<Pagefromswipe0> {
  final List<String> imagePaths = [
    'assets/kpi_dashboard_main.png',
    'assets/dashboard-modern.png',
    'assets/customer.png',
    'assets/dash4.png',
  ];

  final List<String> otherImagePaths = [
    'assets/1.png', // Replace with your additional image paths
    'assets/2.png',
    'assets/3.png',
  ];

  // List of pages corresponding to each container
  final List<Widget> pages = [
    PageD(),
    PageB(),
    PageC(),
    // Add more pages as needed
  ];

  late Future<List<Fact>> futureFacts;

  @override
  void initState() {
    super.initState();
    futureFacts = ApiService().fetchFacts();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'KPIs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder<List<Fact>>(
            future: futureFacts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No data available');
              } else {
                // Filtrer pour obtenir la dernière valeur de TotalRechargeTNDHT différente de 0
                Fact? latestFactWithValue;
                Fact? latestFactWithValueTNDTC_Digital;
                Fact? latestFactWithValueNombreRecharge;

                for (var fact in snapshot.data!.reversed) {
                  if (fact.totalRechargeTNDHT != 0 && latestFactWithValue == null) {
                    latestFactWithValue = fact;
                  }
                  if (fact.totalRechargeTNDTTC_Digital != 0 && latestFactWithValueTNDTC_Digital == null) {
                    latestFactWithValueTNDTC_Digital = fact;
                  }
                  if (fact.nombreRecharge != 0 && latestFactWithValueNombreRecharge == null) {
                    latestFactWithValueNombreRecharge = fact;
                  }
                  if (latestFactWithValue != null && latestFactWithValueTNDTC_Digital != null && latestFactWithValueNombreRecharge != null) {
                    break;
                  }
                }

                return Container(
                  height: 150, // Adjust the height based on your needs
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      final imagePath = imagePaths[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            // Navigate to the corresponding page when container is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => pages[index]),
                            );
                          },
                          child: Container(
                            height: 150, // Adjust the height based on your needs
                            width: 200, // Adjust the width based on your needs
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: (index == 0 || 
                                      imagePath == 'assets/dashboard-modern.png' || 
                                      imagePath == 'assets/customer.png' || 
                                      imagePath == 'assets/dash4.png')
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            index == 0 && latestFactWithValue != null
                                                ? 'TotalRechargeTNDHT = ${latestFactWithValue.totalRechargeTNDHT}'
                                                : imagePath == 'assets/dashboard-modern.png' && latestFactWithValueTNDTC_Digital != null
                                                  ? 'TotalRechargeTNDTTC_Digital = ${latestFactWithValueTNDTC_Digital.totalRechargeTNDTTC_Digital}'
                                                  : imagePath == 'assets/customer.png' && latestFactWithValueNombreRecharge != null
                                                    ? 'NombreRecharge = ${latestFactWithValueNombreRecharge.nombreRecharge}'
                                                    : 'No Image',
                                            style: TextStyle(
                                              color: themeProvider.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
          SizedBox(height: 20),
          Container(
            height: 250, // Adjust the height based on your needs
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: otherImagePaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Navigate to the corresponding page when additional container is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pages[index]),
                      );
                    },
                    child: Container(
                      height: 250, // Adjust the height based on your needs
                      width: 200, // Adjust the width based on your needs
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          otherImagePaths[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}























