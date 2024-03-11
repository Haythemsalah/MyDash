
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Page2 extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData("assets/event.json"); // Replace with the correct path to your JSON file
//   }

//   Future<void> fetchData(String jsonFileName) async {
//     try {
//       // Load JSON content from the file
//       String jsonString = await rootBundle.loadString(jsonFileName);

//       // Parse the JSON data
//       final jsonData = json.decode(jsonString);

//       // Process your data and create _SalesData objects
//       data = jsonData.map<_SalesData>((chartData) {
//         // Add a null check for date and Chiffre d'affaire
//         String date = chartData['date'] ?? '';
//         double chiffreAffaire = chartData["chiffreAffaire"] != null
//             ? double.parse(chartData["chiffreAffaire"])
//             : 0.0;
//         return _SalesData(
//           date,
//           chiffreAffaire,
//         );
//       }).toList();

//       setState(() {
//         loading = false;
//       });
//     } catch (e) {
//       // Handle errors
//       print("Error loading/processing data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Syncfusion Flutter chart'),
//       ),
//       body: loading
//           ? Center(child: CircularProgressIndicator())
//           : PageView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: 2, // Number of charts
//               itemBuilder: (context, index) {
//                 return index == 0
//                     ? Container(
//                         // Line chart
//                         child: SfCartesianChart(
//                           primaryXAxis: CategoryAxis(),
//                           title: ChartTitle(text: 'Chiffre d\'affaire analysis'),
//                           legend: Legend(isVisible: true),
//                           tooltipBehavior: TooltipBehavior(enable: true),
//                           series: <CartesianSeries<_SalesData, String>>[
//                             LineSeries<_SalesData, String>(
//                               dataSource: data,
//                               xValueMapper: (_SalesData sales, _) => sales.date,
//                               yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
//                               name: 'Chiffre d\'affaire',
//                               dataLabelSettings: DataLabelSettings(isVisible: true),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Container(
//                         // Bar chart
//                         child: SfCartesianChart(
//                           primaryXAxis: CategoryAxis(),
//                           title: ChartTitle(text: 'Bar Chart'),
//                           legend: Legend(isVisible: true),
//                           tooltipBehavior: TooltipBehavior(enable: true),
//                           series: <CartesianSeries<_SalesData, String>>[
//                             BarSeries<_SalesData, String>(
//                               dataSource: data,
//                               xValueMapper: (_SalesData sales, _) => sales.date,
//                               yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
//                               name: 'Chiffre d\'affaire',
//                               dataLabelSettings: DataLabelSettings(isVisible: true),
//                             ),
//                           ],
//                         ),
//                       );
//               },
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.date, this.chiffreAffaire);

//   final String date;
//   final double chiffreAffaire;
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Page2 extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData("assets/event.json"); // Replace with the correct path to your JSON file
//   }

//   Future<void> fetchData(String jsonFileName) async {
//     try {
//       // Load JSON content from the file
//       String jsonString = await rootBundle.loadString(jsonFileName);

//       // Parse the JSON data
//       final jsonData = json.decode(jsonString);

//       // Process your data and create _SalesData objects
//       data = jsonData.map<_SalesData>((chartData) {
//         // Add a null check for date and Chiffre d'affaire
//         String date = chartData['date'] ?? '';
//         double chiffreAffaire = chartData["chiffreAffaire"] != null
//             ? double.parse(chartData["chiffreAffaire"])
//             : 0.0;
//         return _SalesData(
//           date,
//           chiffreAffaire,
//         );
//       }).toList();

//       setState(() {
//         loading = false;
//       });
//     } catch (e) {
//       // Handle errors
//       print("Error loading/processing data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Syncfusion Flutter chart'),
//       ),
//       body: loading
//           ? Center(child: CircularProgressIndicator())
//           : DefaultTabController(
//               length: 2,
//               child: Column(
//                 children: [
//                   TabBar(
//                     tabs: [
//                       Tab(text: 'Line Chart'),
//                       Tab(text: 'Bar Chart'),
//                     ],
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         // Line chart
//                         Container(
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(text: 'Chiffre d\'affaire analysis'),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               LineSeries<_SalesData, String>(
//                                 dataSource: data,
//                                 xValueMapper: (_SalesData sales, _) => sales.date,
//                                 yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
//                                 name: 'Chiffre d\'affaire',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Bar chart
//                         Container(
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(text: 'Bar Chart'),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 dataSource: data,
//                                 xValueMapper: (_SalesData sales, _) => sales.date,
//                                 yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
//                                 name: 'Chiffre d\'affaire',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.date, this.chiffreAffaire);

//   final String date;
//   final double chiffreAffaire;
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Page2 extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   String selectedDate = ''; // Track the selected date
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData("assets/event.json"); // Replace with the correct path to your JSON file
//   }

//   Future<void> fetchData(String jsonFileName) async {
//     try {
//       // Load JSON content from the file
//       String jsonString = await rootBundle.loadString(jsonFileName);

//       // Parse the JSON data
//       final jsonData = json.decode(jsonString);

//       // Process your data and create _SalesData objects
//       data = jsonData.map<_SalesData>((chartData) {
//         String date = chartData['date'] ?? '';
//         double chiffreAffaire = chartData["chiffreAffaire"] != null
//             ? double.parse(chartData["chiffreAffaire"])
//             : 0.0;
//         return _SalesData(
//           date,
//           chiffreAffaire,
//         );
//       }).toList();

//       // Extract the list of unique dates
//       dateList = data.map((salesData) => salesData.date).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedDate = ''; // Set the initial selected date to an empty string
//       });
//     } catch (e) {
//       // Handle errors
//       print("Error loading/processing data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Syncfusion Flutter chart'),
//       ),
//       body: loading
//           ? Center(child: CircularProgressIndicator())
//           : DefaultTabController(
//               length: 2,
//               child: Column(
//                 children: [
//                   TabBar(
//                     tabs: [
//                       Tab(text: 'Line Chart'),
//                       Tab(text: 'Bar Chart'),
//                     ],
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         // Line chart
//                         Container(
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(text: 'Chiffre d\'affaire analysis'),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               LineSeries<_SalesData, String>(
//                                 dataSource: data,
//                                 xValueMapper: (_SalesData sales, _) => sales.date,
//                                 yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
//                                 name: 'Chiffre d\'affaire',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Bar chart
//                         Container(
//                           child: Column(
//                             children: [
//                               // Swipeable buttons containing dates
//                               Container(
//                                 height: 50,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: dateList.length,
//                                   itemBuilder: (context, index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             if (selectedDate == dateList[index]) {
//                                               // Toggle off the selected state
//                                               selectedDate = '';
//                                             } else {
//                                               // Toggle on the selected state
//                                               selectedDate = dateList[index];
//                                             }
//                                           });
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           primary: selectedDate == dateList[index]
//                                               ? Colors.blue // Highlight the selected button
//                                               : null,
//                                         ),
//                                         child: Text(dateList[index]),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               // Bar chart with selected date
//                               SfCartesianChart(
//                                 primaryXAxis: CategoryAxis(),
//                                 title: ChartTitle(
//                                   text: selectedDate.isEmpty
//                                       ? 'Bar Chart for all dates'
//                                       : 'Bar Chart for $selectedDate',
//                                 ),
//                                 legend: Legend(isVisible: true),
//                                 tooltipBehavior: TooltipBehavior(enable: true),
//                                 series: <CartesianSeries<_SalesData, String>>[
//                                   BarSeries<_SalesData, String>(
//                                     dataSource: selectedDate.isEmpty
//                                         ? data
//                                         : data.where((d) => d.date == selectedDate).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
//                                     name: 'Chiffre d\'affaire',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.date, this.chiffreAffaire);

//   final String date;
//   final double chiffreAffaire;
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Page2 extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   String selectedDate = ''; // Track the selected date
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData("assets/event.json"); // Replace with the correct path to your JSON file
//   }

//   Future<void> fetchData(String jsonFileName) async {
//     try {
//       // Load JSON content from the file
//       String jsonString = await rootBundle.loadString(jsonFileName);

//       // Parse the JSON data
//       final jsonData = json.decode(jsonString);

//       // Process your data and create _SalesData objects
//       data = jsonData.map<_SalesData>((chartData) {
//         String date = chartData['date'] ?? '';
//         double chiffreAffaire = chartData["chiffreAffaire"] != null
//             ? double.parse(chartData["chiffreAffaire"])
//             : 0.0;
//         return _SalesData(
//           date,
//           chiffreAffaire,
//         );
//       }).toList();

//       // Extract the list of unique dates
//       dateList = data.map((salesData) => salesData.date).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedDate = ''; // Set the initial selected date to an empty string
//       });
//     } catch (e) {
//       // Handle errors
//       print("Error loading/processing data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? Center(child: CircularProgressIndicator())
//           : DefaultTabController(
//               length: 2,
//               child: Column(
//                 children: [
//                   TabBar(
//                     tabs: [
//                       Tab(text: 'Line Chart'),
//                       Tab(text: 'Bar Chart'),
//                     ],
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         // Line chart
//                         Container(
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(text: 'Chiffre d\'affaire analysis'),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               LineSeries<_SalesData, String>(
//                                 dataSource: data,
//                                 xValueMapper: (_SalesData sales, _) => sales.date,
//                                 yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
//                                 name: 'Chiffre d\'affaire',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Bar chart
//                         Container(
//                           child: Column(
//                             children: [
//                               // Swipeable buttons containing dates
//                               Container(
//                                 height: 50,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: dateList.length,
//                                   itemBuilder: (context, index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             if (selectedDate == dateList[index]) {
//                                               // Toggle off the selected state
//                                               selectedDate = '';
//                                             } else {
//                                               // Toggle on the selected state
//                                               selectedDate = dateList[index];
//                                             }
//                                           });
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           primary: selectedDate == dateList[index]
//                                               ? Colors.black // Highlight the selected button
//                                               : null,
//                                         ),
//                                         child: Text(
//                                           dateList[index],
//                                           style: TextStyle(
//                                             color: selectedDate == dateList[index]
//                                                 ? Colors.white // Color of the pressed button text
//                                                 : Colors.black, // Color of the button text
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               // Bar chart with selected date
//                               SfCartesianChart(
//                                 primaryXAxis: CategoryAxis(),
//                                 title: ChartTitle(
//                                   text: selectedDate.isEmpty
//                                       ? 'Bar Chart for all dates'
//                                       : 'Bar Chart for $selectedDate',
//                                 ),
//                                 legend: Legend(isVisible: true),
//                                 tooltipBehavior: TooltipBehavior(enable: true),
//                                 series: <CartesianSeries<_SalesData, String>>[
//                                   BarSeries<_SalesData, String>(
//                                     color: Color.fromARGB(223, 255, 115, 34), // Customize the color of the bars
//                                     dataSource: selectedDate.isEmpty
//                                         ? data
//                                         : data.where((d) => d.date == selectedDate).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
//                                     name: 'Chiffre d\'affaire',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.date, this.chiffreAffaire);

//   final String date;
//   final double chiffreAffaire;
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';

class Page2 extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Page2({Key? key}) : super(key: key);

  @override
  Page2State createState() => Page2State();
}

class Page2State extends State<Page2> {
  List<_SalesData> data = [];
  List<String> dateList = [];
  String selectedDate = ''; // Track the selected date
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData("assets/event.json"); // Replace with the correct path to your JSON file
  }

  Future<void> fetchData(String jsonFileName) async {
    try {
      // Load JSON content from the file
      String jsonString = await rootBundle.loadString(jsonFileName);

      // Parse the JSON data
      final jsonData = json.decode(jsonString);

      // Process your data and create _SalesData objects
      data = jsonData.map<_SalesData>((chartData) {
        String date = chartData['date'] ?? '';
        double chiffreAffaire = chartData["chiffreAffaire"] != null
            ? double.parse(chartData["chiffreAffaire"])
            : 0.0;
        return _SalesData(
          date,
          chiffreAffaire,
        );
      }).toList();

      // Extract the list of unique dates
      dateList = data.map((salesData) => salesData.date).toSet().toList();

      setState(() {
        loading = false;
        selectedDate = ''; // Set the initial selected date to an empty string
      });
    } catch (e) {
      // Handle errors
      print("Error loading/processing data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KPIs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 2,
              child: Column(
                children: [
                TabBar(
  indicatorColor: Colors.black, // Customize the color of the selected tab indicator
  tabs: [
    Tab(
      child: Text(
        'Line Chart',
        style: TextStyle(color: Colors.black), // Set text color to black
      ),
      icon: Icon(Icons.show_chart, color: Colors.black),
    ),
    Tab(
      child: Text(
        'Bar Chart',
        style: TextStyle(color: Colors.black), // Set text color to black
      ),
      icon: Icon(Icons.bar_chart, color: Colors.black),
    ),
  ],
),

                  Expanded(
                    child: TabBarView(
                      children: [
                        // Line chart
                        Container(
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            title: ChartTitle(text: 'Chiffre d\'affaire analysis'),
                            legend: Legend(isVisible: true),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries<_SalesData, String>>[
                              LineSeries<_SalesData, String>(
                                dataSource: data,
                                xValueMapper: (_SalesData sales, _) => sales.date,
                                yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
                                name: 'Chiffre d\'affaire',
                                dataLabelSettings: DataLabelSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ),
                        // Bar chart
                        Container(
                          child: Column(
                            children: [
                              // Swipeable buttons containing dates
                              Container(
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dateList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (selectedDate == dateList[index]) {
                                              // Toggle off the selected state
                                              selectedDate = '';
                                            } else {
                                              // Toggle on the selected state
                                              selectedDate = dateList[index];
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: selectedDate == dateList[index]
                                              ? Colors.black // Highlight the selected button
                                              : null,
                                        ),
                                        child: Text(
                                          dateList[index],
                                          style: TextStyle(
                                            color: selectedDate == dateList[index]
                                                ? Colors.white // Color of the pressed button text
                                                : Colors.black, // Color of the button text
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Bar chart with selected date
                              SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                title: ChartTitle(
                                  text: selectedDate.isEmpty
                                      ? 'Bar Chart for all dates'
                                      : 'Bar Chart for $selectedDate',
                                ),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CartesianSeries<_SalesData, String>>[
                                  BarSeries<_SalesData, String>(
                                    color: Color.fromARGB(223, 255, 115, 34), // Customize the color of the bars
                                    dataSource: selectedDate.isEmpty
                                        ? data
                                        : data.where((d) => d.date == selectedDate).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
                                    name: 'Chiffre d\'affaire',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _SalesData {
  _SalesData(this.date, this.chiffreAffaire);

  final String date;
  final double chiffreAffaire;
}
