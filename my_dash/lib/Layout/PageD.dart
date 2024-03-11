
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';

// class PageD extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   PageD({Key? key}) : super(key: key);

//   @override
//   PageDState createState() => PageDState();
// }

// class PageDState extends State<PageD> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   Set<String> selectedDates = {}; // Track the selected dates using a Set
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData("assets/Recharge.json"); // Replace with the correct path to your JSON file
//   }

//   Future<void> fetchData(String jsonFileName) async {
//     try {
//       // Load JSON content from the file
//       String jsonString = await rootBundle.loadString(jsonFileName);

//       // Parse the JSON data
//       final jsonData = json.decode(jsonString);

//       // Process your data and create _SalesData objects
//       data = jsonData.map<_SalesData>((chartData) {
//         String date = chartData['Date'] ?? '';
//         double totalRechargeTNDHTGlobal = chartData["Total Recharge TND HT (Global)"] != null
//             ? (chartData["Total Recharge TND HT (Global)"] is int
//                 ? (chartData["Total Recharge TND HT (Global)"] as int).toDouble()
//                 : chartData["Total Recharge TND HT (Global)"])
//             : 0.0;
//         int nombreRechargeGlobal = chartData["Nombre Recharge (Global)"] != null
//             ? chartData["Nombre Recharge (Global)"]
//             : 0;
//         double totalRechargeTNDDigital = chartData["Total Recharge TND TTC (Digital)"] != null
//             ? (chartData["Total Recharge TND TTC (Digital)"] is int
//                 ? (chartData["Total Recharge TND TTC (Digital)"] as int).toDouble()
//                 : chartData["Total Recharge TND TTC (Digital)"])
//             : 0.0;
//         int nombreRechargeDigital = chartData["Nombre Recharge (Digital)"] != null
//             ? chartData["Nombre Recharge (Digital)"]
//             : 0;
//         double pourcentage = chartData["Pourcentage"] != null
//             ? (chartData["Pourcentage"] is int
//                 ? (chartData["Pourcentage"] as int).toDouble()
//                 : chartData["Pourcentage"])
//             : 0.0;

//         return _SalesData(
//           date,
//           totalRechargeTNDHTGlobal,
//           nombreRechargeGlobal,
//           totalRechargeTNDDigital,
//           nombreRechargeDigital,
//           pourcentage,
//         );
//       }).toList();

//       // Extract the list of unique dates
//       dateList = data.map((salesData) => salesData.date).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedDates.clear(); // Set the initial selected dates to an empty Set
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
//                     indicatorColor: Colors.black, // Customize the color of the selected tab indicator
//                     tabs: [
//                       Tab(
//                         child: Text(
//                           'Line Chart',
//                           style: TextStyle(color: Colors.black), // Set text color to black
//                         ),
//                         icon: Icon(Icons.show_chart, color: Colors.black),
//                       ),
//                       Tab(
//                         child: Text(
//                           'Bar Chart',
//                           style: TextStyle(color: Colors.black), // Set text color to black
//                         ),
//                         icon: Icon(Icons.bar_chart, color: Colors.black),
//                       ),
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
//                                 yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHTGlobal,
//                                 name: 'Total Recharge TND HT Global',
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
//                                             if (selectedDates.contains(dateList[index])) {
//                                               // Unselect the date
//                                               selectedDates.remove(dateList[index]);
//                                             } else {
//                                               // Select the date
//                                               selectedDates.add(dateList[index]);
//                                             }
//                                           });
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           primary: selectedDates.contains(dateList[index])
//                                               ? Colors.black // Highlight the selected button
//                                               : null,
//                                         ),
//                                         child: Text(
//                                           dateList[index],
//                                           style: TextStyle(
//                                             color: selectedDates.contains(dateList[index])
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
//                               // Bar chart with selected dates
//                               SfCartesianChart(
//                                 primaryXAxis: CategoryAxis(),
//                                 title: ChartTitle(
//                                   text: selectedDates.isEmpty
//                                       ? 'Bar Chart for all dates'
//                                       : 'Bar Chart for ${selectedDates.join(", ")}',
//                                 ),
//                                 legend: Legend(isVisible: true),
//                                 tooltipBehavior: TooltipBehavior(enable: true),
//                                 series: <CartesianSeries<_SalesData, String>>[
//                                   BarSeries<_SalesData, String>(
//                                     color: Color.fromARGB(223, 255, 115, 34), // Customize the color of the bars
//                                     dataSource: selectedDates.isEmpty
//                                         ? data
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHTGlobal,
//                                     name: 'Total Recharge TND HT Global',
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
//   _SalesData(
//     this.date,
//     this.totalRechargeTNDHTGlobal,
//     this.nombreRechargeGlobal,
//     this.totalRechargeTNDDigital,
//     this.nombreRechargeDigital,
//     this.pourcentage,
//   );

//   final String date;
//   final double totalRechargeTNDHTGlobal;
//   final int nombreRechargeGlobal;
//   final double totalRechargeTNDDigital;
//   final int nombreRechargeDigital;
//   final double pourcentage;
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';

class PageD extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  PageD({Key? key}) : super(key: key);

  @override
  PageDState createState() => PageDState();
}

class PageDState extends State<PageD> {
  List<_SalesData> data = [];
  List<String> dateList = [];
  List<String> selectedDates = []; // Track the selected dates
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData("assets/Recharge.json"); // Replace with the correct path to your JSON file
  }

  Future<void> fetchData(String jsonFileName) async {
    try {
      // Load JSON content from the file
      String jsonString = await rootBundle.loadString(jsonFileName);

      // Parse the JSON data
      final jsonData = json.decode(jsonString);

      // Process your data and create _SalesData objects
      data = jsonData.map<_SalesData>((chartData) {
        String date = chartData['Date'] ?? '';
        double totalRechargeTNDHTGlobal = chartData["Total Recharge TND HT (Global)"] != null
            ? (chartData["Total Recharge TND HT (Global)"] is int
                ? (chartData["Total Recharge TND HT (Global)"] as int).toDouble()
                : chartData["Total Recharge TND HT (Global)"])
            : 0.0;
        int nombreRechargeGlobal = chartData["Nombre Recharge (Global)"] != null
            ? chartData["Nombre Recharge (Global)"]
            : 0;
        double totalRechargeTNDDigital = chartData["Total Recharge TND TTC (Digital)"] != null
            ? (chartData["Total Recharge TND TTC (Digital)"] is int
                ? (chartData["Total Recharge TND TTC (Digital)"] as int).toDouble()
                : chartData["Total Recharge TND TTC (Digital)"])
            : 0.0;
        int nombreRechargeDigital = chartData["Nombre Recharge (Digital)"] != null
            ? chartData["Nombre Recharge (Digital)"]
            : 0;
        double pourcentage = chartData["Pourcentage"] != null
            ? (chartData["Pourcentage"] is int
                ? (chartData["Pourcentage"] as int).toDouble()
                : chartData["Pourcentage"])
            : 0.0;

        return _SalesData(
          date,
          totalRechargeTNDHTGlobal,
          nombreRechargeGlobal,
          totalRechargeTNDDigital,
          nombreRechargeDigital,
          pourcentage,
        );
      }).toList();

      // Extract the list of unique dates
      dateList = data.map((salesData) => salesData.date).toSet().toList();

      setState(() {
        loading = false;
        selectedDates = []; // Set the initial selected dates to an empty list
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
                                yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHTGlobal,
                                name: 'Total Recharge TND HT Global',
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
                                            if (selectedDates.contains(dateList[index])) {
                                              // Remove the selected date
                                              selectedDates.remove(dateList[index]);
                                            } else {
                                              // Add the selected date
                                              selectedDates.add(dateList[index]);
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: selectedDates.contains(dateList[index])
                                              ? Colors.black // Highlight the selected button
                                              : null,
                                        ),
                                        child: Text(
                                          dateList[index],
                                          style: TextStyle(
                                            color: selectedDates.contains(dateList[index])
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
                              // Bar chart with selected dates
                              SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                title: ChartTitle(
                                  text: selectedDates.isEmpty
                                      ? 'Bar Chart for all dates'
                                      : 'Bar Chart for ${selectedDates.join(", ")}',
                                ),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CartesianSeries<_SalesData, String>>[
                                  BarSeries<_SalesData, String>(
                                    color: Color.fromARGB(223, 255, 115, 34), // Default color for bars
                                    dataSource: selectedDates.isEmpty
                                        ? data
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHTGlobal,
                                    name: 'Total Recharge TND HT Global',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                    // Customize color based on highest value
                                    pointColorMapper: (_SalesData sales, _) {
                                      double maxVal = selectedDates.isEmpty
                                          ? data.map((d) => d.totalRechargeTNDHTGlobal).reduce((a, b) => a > b ? a : b)
                                          : data
                                              .where((d) => selectedDates.contains(d.date))
                                              .map((d) => d.totalRechargeTNDHTGlobal)
                                              .reduce((a, b) => a > b ? a : b);

                                      return sales.totalRechargeTNDHTGlobal == maxVal ? Colors.red : Color.fromARGB(223, 255, 115, 34);
                                    },
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
  _SalesData(
    this.date,
    this.totalRechargeTNDHTGlobal,
    this.nombreRechargeGlobal,
    this.totalRechargeTNDDigital,
    this.nombreRechargeDigital,
    this.pourcentage,
  );

  final String date;
  final double totalRechargeTNDHTGlobal;
  final int nombreRechargeGlobal;
  final double totalRechargeTNDDigital;
  final int nombreRechargeDigital;
  final double pourcentage;
}
