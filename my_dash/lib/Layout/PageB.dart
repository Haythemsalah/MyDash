
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';

// class PageB extends StatefulWidget {
//   PageB({Key? key}) : super(key: key);

//   @override
//   PageBState createState() => PageBState();
// }

// class PageBState extends State<PageB> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   List<String> selectedDates = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData("assets/RechargeGlobal.json");
//   }

//   Future<void> fetchData(String jsonFileName) async {
//     try {
//       String jsonString = await rootBundle.loadString(jsonFileName);
//       final jsonData = json.decode(jsonString);

//       data = jsonData.map<_SalesData>((chartData) {
//         String date = chartData['date'] ?? '';
//         double totalRechargeJourJ = (chartData["total_recharge_jour_j"] ?? 0).toDouble();
//         double totalRechargeJourJ7 = (chartData["total_recharge_jour_j_7"] ?? 0).toDouble();
//         double totalRechargeJourM1 = (chartData["total_recharge_jour_m_1"] ?? 0).toDouble();
//         double totalRechargeJourY1 = (chartData["total_recharge_jour_y_1"] ?? 0).toDouble();
//         double totalRechargeCummulM = (chartData["total_recharge_cummul_m"] ?? 0).toDouble();
//         double totalRechargeCummulM1 = (chartData["total_recharge_cummul_m_1"] ?? 0).toDouble();
//         double totalRechargeCummulY1 = (chartData["total_recharge_cummul_y_1"] ?? 0).toDouble();

//         return _SalesData(
//           date,
//           totalRechargeJourJ,
//           totalRechargeJourJ7,
//           totalRechargeJourM1,
//           totalRechargeJourY1,
//           totalRechargeCummulM,
//           totalRechargeCummulM1,
//           totalRechargeCummulY1,
//         );
//       }).toList();

//       dateList = data.map((salesData) => salesData.date).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedDates = [];
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getTop5Data(List<_SalesData> list, double Function(_SalesData) getValue) {
//     list.sort((a, b) => getValue(b).compareTo(getValue(a)));
//     return list.take(5).toList();
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
//               length: 3,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // Date filter buttons
//                     Container(
//                       height: 50,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: dateList.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   if (selectedDates.contains(dateList[index])) {
//                                     selectedDates.remove(dateList[index]);
//                                   } else {
//                                     selectedDates.add(dateList[index]);
//                                   }
//                                 });
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 primary: selectedDates.contains(dateList[index]) ? Colors.black : null,
//                               ),
//                               child: Text(
//                                 dateList[index],
//                                 style: TextStyle(
//                                   color: selectedDates.contains(dateList[index]) ? Colors.white : Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     // Bar chart
//                     Container(
//                       height: 350,
//                       margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white, // Gray background color
//                       ),
//                       child: Column(
//                         children: [
//                           Text('Bar Chart'),
//                           Expanded(
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               child: SfCartesianChart(
//                                 primaryXAxis: CategoryAxis(),
//                                 primaryYAxis: NumericAxis(),
//                                 title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
//                                 legend: Legend(isVisible: true),
//                                 tooltipBehavior: TooltipBehavior(enable: true),
//                                 series: <CartesianSeries<_SalesData, String>>[
//                                   BarSeries<_SalesData, String>(
//                                     color: Color.fromARGB(223, 255, 115, 34),
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//                                     name: 'Total Recharge Jour J',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   BarSeries<_SalesData, String>(
//                                     color: Colors.blue,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourJ7)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
//                                     name: 'Total Recharge Jour J-7',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   BarSeries<_SalesData, String>(
//                                     color: Colors.green,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourM1)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
//                                     name: 'totalRechargeJourM-1',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   BarSeries<_SalesData, String>(
//                                     color: Colors.red,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourY1)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
//                                     name: 'Total Recharge Jour Y-1',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Line chart
//                     Container(
//                       height: 350,
//                       margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white, // Gray background color
//                       ),
//                       child: Column(
//                         children: [
//                           Text('Line Chart'),
//                           Expanded(
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               child: SfCartesianChart(
//                                 primaryXAxis: CategoryAxis(),
//                                 primaryYAxis: NumericAxis(),
//                                 title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
//                                 legend: Legend(isVisible: true),
//                                 tooltipBehavior: TooltipBehavior(enable: true),
//                                 series: <CartesianSeries<_SalesData, String>>[
//                                   LineSeries<_SalesData, String>(
//                                     color: Color.fromARGB(223, 255, 115, 34),
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//                                     name: 'Total Recharge Jour J',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   LineSeries<_SalesData, String>(
//                                     color: Colors.blue,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourJ7)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
//                                     name: 'Total Recharge Jour J-7',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   LineSeries<_SalesData, String>(
//                                     color: Colors.green,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourM1)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
//                                     name: 'totalRechargeJourM-1',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   LineSeries<_SalesData, String>(
//                                     color: Colors.red,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourY1)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
//                                     name: 'Total Recharge Jour Y-1',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Bar chart for total Recharge Cummulé
//                     Container(
//                       height: 350,
//                       margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white, // Gray background color
//                       ),
//                       child: Column(
//                         children: [
//                           Text('Bar Chart for Total Recharge Cummulé'),
//                           Expanded(
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               child: SfCartesianChart(
//                                 primaryXAxis: CategoryAxis(),
//                                 primaryYAxis: NumericAxis(),
//                                 title: ChartTitle(text: 'Comparaison de total Recharge Cummulé par dates '),
//                                 legend: Legend(isVisible: true),
//                                 tooltipBehavior: TooltipBehavior(enable: true),
//                                 series: <CartesianSeries<_SalesData, String>>[
//                                   BarSeries<_SalesData, String>(
//                                     color: Color.fromARGB(223, 255, 115, 34),
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeCummulM)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM,
//                                     name: 'Total Recharge Cummul M',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   BarSeries<_SalesData, String>(
//                                     color: Colors.blue,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeCummulM1)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM1,
//                                     name: 'Total Recharge Cummul M-1',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   BarSeries<_SalesData, String>(
//                                     color: Colors.green,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeCummulY1)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulY1,
//                                     name: 'Total Recharge Cummul Y-1',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Line chart for total Recharge Cummulé
//                     Container(
//                       height: 350,
//                       margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white, // Gray background color
//                       ),
//                       child: Column(
//                         children: [
//                           Text('Line Chart for Total Recharge Cummulé'),
//                           Expanded(
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               child: SfCartesianChart(
//                                 primaryXAxis: CategoryAxis(),
//                                 primaryYAxis: NumericAxis(),
//                                 title: ChartTitle(text: 'Comparaison de total Recharge Cummulé par dates '),
//                                 legend: Legend(isVisible: true),
//                                 tooltipBehavior: TooltipBehavior(enable: true),
//                                 series: <CartesianSeries<_SalesData, String>>[
//                                   LineSeries<_SalesData, String>(
//                                     color: Color.fromARGB(223, 255, 115, 34),
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeCummulM)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM,
//                                     name: 'Total Recharge Cummul M',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   LineSeries<_SalesData, String>(
//                                     color: Colors.blue,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeCummulM1)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM1,
//                                     name: 'Total Recharge Cummul M-1',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                   LineSeries<_SalesData, String>(
//                                     color: Colors.green,
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeCummulY1)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulY1,
//                                     name: 'Total Recharge Cummul Y-1',
//                                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                    // Candlestick chart
// Container(
//   height: 350,
//   margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
//   decoration: BoxDecoration(
//     border: Border.all(color: Colors.grey),
//     borderRadius: BorderRadius.circular(10),
//     color: Colors.white, // Gray background color
//   ),
//   child: Column(
//     children: [
//       Text('Candlestick Chart'),
//       Expanded(
//         child: Container(
//           padding: EdgeInsets.all(10),
//           child: SfCartesianChart(
//             primaryXAxis: CategoryAxis(),
//             primaryYAxis: NumericAxis(),
//             title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
//             legend: Legend(isVisible: true),
//             tooltipBehavior: TooltipBehavior(enable: true),
//             series: <CartesianSeries<_SalesData, String>>[
//               CandleSeries<_SalesData, String>(
//                 dataSource: selectedDates.isEmpty
//                     ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//                     : data.where((d) => selectedDates.contains(d.date)).toList(),
//                 xValueMapper: (_SalesData sales, _) => sales.date,
//                 lowValueMapper: (_SalesData sales, _) => 
//                   sales.totalRechargeJourY1 < sales.totalRechargeJourJ ? sales.totalRechargeJourY1 : sales.totalRechargeJourJ,
//                 highValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
//                 openValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1, // Set open value to totalRechargeJourY1
//                 closeValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ, // Set close value to totalRechargeJourJ
//                 bearColor: Colors.red, // Red color for bearish candles
//                 bullColor: Colors.green, // Green color for bullish candles
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// ),



//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(
//     this.date,
//     this.totalRechargeJourJ,
//     this.totalRechargeJourJ7,
//     this.totalRechargeJourM1,
//     this.totalRechargeJourY1,
//     this.totalRechargeCummulM,
//     this.totalRechargeCummulM1,
//     this.totalRechargeCummulY1,
//   );

//   final String date;
//   final double totalRechargeJourJ;
//   final double totalRechargeJourJ7;
//   final double totalRechargeJourM1;
//   final double totalRechargeJourY1;
//   final double totalRechargeCummulM;
//   final double totalRechargeCummulM1;
//   final double totalRechargeCummulY1;
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/RetrieveData_api.dart';

// class PageB extends StatefulWidget {
//   PageB({Key? key}) : super(key: key);

//   @override
//   PageBState createState() => PageBState();
// }

// class PageBState extends State<PageB> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   List<String> selectedDates = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<Fact> facts = await apiService.fetchFacts();

//       data = facts
//           .where((fact) => fact.typeRecharge == "Global")
//           .map<_SalesData>((fact) => _SalesData(
//                 fact.date,
//                 fact.nombreRecharge,
//                 fact.nbrOptionGlobal,
//                 fact.montantOptionGlobal,
//                 fact.nbrDataGlobal,
//                 fact.montantDataGlobal,
//                 fact.totalRechargeTNDHT,
//               ))
//           .toList();

//       dateList = data.map((salesData) => salesData.date).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedDates = [];
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getTop5Data(List<_SalesData> list, double Function(_SalesData) getValue) {
//     list.sort((a, b) => getValue(b).compareTo(getValue(a)));
//     return list.take(5).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Global Statiscs Dashboard',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? Center(child: CircularProgressIndicator())
//           : DefaultTabController(
//               length: 4,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 50,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: dateList.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   if (selectedDates.contains(dateList[index])) {
//                                     selectedDates.remove(dateList[index]);
//                                   } else {
//                                     selectedDates.add(dateList[index]);
//                                   }
//                                 });
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 primary: selectedDates.contains(dateList[index])
//                                     ? Colors.black
//                                     : null,
//                               ),
//                               child: Text(
//                                 dateList[index],
//                                 style: TextStyle(
//                                   color: selectedDates.contains(dateList[index])
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         title: ChartTitle(
//                           text: selectedDates.isEmpty
//                               ? 'Recharge number per date '
//                               : 'Recharge number for ${selectedDates.join(", ")}',
//                           textStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.nombreRecharge.toDouble())
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRecharge.toDouble(),
//                             name: 'Recharge number',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                             pointColorMapper: (_SalesData sales, _) {
//                               double maxVal = selectedDates.isEmpty
//                                   ? data.map((d) => d.nombreRecharge.toDouble()).reduce((a, b) => a > b ? a : b)
//                                   : data
//                                       .where((d) => selectedDates.contains(d.date))
//                                       .map((d) => d.nombreRecharge.toDouble())
//                                       .reduce((a, b) => a > b ? a : b);

//                               return sales.nombreRecharge.toDouble() == maxVal ? Colors.red : Color.fromARGB(223, 255, 115, 34);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Total Recharge TNDHT per date'),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           LineSeries<_SalesData, String>(
//                             color: Colors.orange,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeTNDHT)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHT,
//                             name: 'Total Recharge TNDHT',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                             markerSettings: MarkerSettings(isVisible: true), // Add markers to the line
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 300, // Increase the height of the bar chart
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         title: ChartTitle(
//                           text: 'Global option number and global option amount per date',
//                           textStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         legend: Legend(
//                           isVisible: true,
//                           overflowMode: LegendItemOverflowMode.wrap,
//                         ),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries>[
//                           ColumnSeries<_SalesData, String>(
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.montantOptionGlobal)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nbrOptionGlobal.toDouble(),
//                             name: 'Global option number',
//                             color: Colors.blue,
//                           ),
//                           ColumnSeries<_SalesData, String>(
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.montantOptionGlobal)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.montantOptionGlobal,
//                             name: 'Global option amount',
//                             color: Colors.orange,
//                           ),
//                           LineSeries<_SalesData, String>(
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.montantOptionGlobal)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nbrOptionGlobal.toDouble(),
//                             name: 'TrendLine Global option number',
//                             color: Colors.blue,
//                             markerSettings: MarkerSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.montantOptionGlobal)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.montantOptionGlobal,
//                             name: 'TrendLine global option amount',
//                             color: Colors.orange,
//                             markerSettings: MarkerSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         title: ChartTitle(
//                           text: 'Global Data Number and Global Data Amount per date',
//                           textStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         legend: Legend(
//                           isVisible: true,
//                           overflowMode: LegendItemOverflowMode.wrap,
//                         ),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries>[
//                           ScatterSeries<_SalesData, String>(
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.montantDataGlobal)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nbrDataGlobal.toDouble(),
//                             name: 'Global Data Number',
//                             color: Colors.blue,
//                             markerSettings: MarkerSettings(isVisible: true),
//                           ),
//                           ScatterSeries<_SalesData, String>(
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.montantDataGlobal)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.montantDataGlobal,
//                             name: 'Global Data Amount',
//                             color: Colors.orange,
//                             markerSettings: MarkerSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(
//     this.date,
//     this.nombreRecharge,
//     this.nbrOptionGlobal,
//     this.montantOptionGlobal,
//     this.nbrDataGlobal,
//     this.montantDataGlobal,
//     this.totalRechargeTNDHT,
//   );

//   final String date;
//   final int nombreRecharge;
//   final int nbrOptionGlobal;
//   final double montantOptionGlobal;
//   final int nbrDataGlobal;
//   final double montantDataGlobal;
//   final double totalRechargeTNDHT;
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:my_dash/services/RetrieveData_api.dart';

class PageB extends StatefulWidget {
  PageB({Key? key}) : super(key: key);

  @override
  PageBState createState() => PageBState();
}

class PageBState extends State<PageB> {
  List<_SalesData> data = [];
  List<String> dateList = [];
  List<String> selectedDates = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      ApiService apiService = ApiService();
      List<Fact> facts = await apiService.fetchFacts();

      data = facts
          .where((fact) => fact.fkTypeRecharge == 2)
          .map<_SalesData>((fact) => _SalesData(
                fact.date,
                fact.nombreRecharge,
                fact.nbrOptionDigital,
                fact.montantOptionDigital,
                fact.nbrDataDigital,
                fact.montantDataDigital,
                fact.totalRechargeTNDTTC_Digital,
              ))
          .toList();

      dateList = data.map((salesData) => salesData.date).toSet().toList();

      setState(() {
        loading = false;
        selectedDates = [];
      });
    } catch (e) {
      print("Error loading/processing data: $e");
    }
  }

  List<_SalesData> getTop5Data(List<_SalesData> list, double Function(_SalesData) getValue) {
    list.sort((a, b) => getValue(b).compareTo(getValue(a)));
    return list.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Digital Statistics Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                    selectedDates.remove(dateList[index]);
                                  } else {
                                    selectedDates.add(dateList[index]);
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: selectedDates.contains(dateList[index])
                                    ? Colors.black
                                    : null,
                              ),
                              child: Text(
                                dateList[index],
                                style: TextStyle(
                                  color: selectedDates.contains(dateList[index])
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 300,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(
                          text: selectedDates.isEmpty
                              ? 'Recharge number per date '
                              : 'Recharge number for ${selectedDates.join(", ")}',
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<_SalesData, String>>[
                          BarSeries<_SalesData, String>(
                            color: Color.fromARGB(223, 255, 115, 34),
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.nombreRecharge.toDouble())
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.nombreRecharge.toDouble(),
                            name: 'Recharge number',
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                            pointColorMapper: (_SalesData sales, _) {
                              double maxVal = selectedDates.isEmpty
                                  ? data.map((d) => d.nombreRecharge.toDouble()).reduce((a, b) => a > b ? a : b)
                                  : data
                                      .where((d) => selectedDates.contains(d.date))
                                      .map((d) => d.nombreRecharge.toDouble())
                                      .reduce((a, b) => a > b ? a : b);

                              return sales.nombreRecharge.toDouble() == maxVal ? Colors.red : Color.fromARGB(223, 255, 115, 34);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                        // title: ChartTitle(text: 'Total recharge TNDTTC digital per date'
                        // ),
                        title: ChartTitle(
      text: 'Total recharge TNDTTC digital per date',
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<_SalesData, String>>[
                          LineSeries<_SalesData, String>(
                            color: Color.fromARGB(223, 255, 115, 34),
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.totalRechargeTNDTTC_Digital)
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDTTC_Digital,
                            name: 'Total recharge TNDTTC digital',
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                            markerSettings: MarkerSettings(isVisible: true), // Add markers to the line
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300, // Increase the height of the bar chart
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(
                          text: 'Digital option number and digital option amount per date',
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        legend: Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap,
                        ),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries>[
                          ColumnSeries<_SalesData, String>(
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.montantOptionDigital)
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.nbrOptionDigital.toDouble(),
                            name: 'Digital option number',
                            color: Colors.blue,
                          ),
                          ColumnSeries<_SalesData, String>(
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.montantOptionDigital)
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.montantOptionDigital,
                            name: 'Digital option amount',
                            color: Color.fromARGB(223, 255, 115, 34),
                          ),
                          LineSeries<_SalesData, String>(
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.montantOptionDigital)
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.nbrOptionDigital.toDouble(),
                            name: 'TrendLine digital option number',
                            color: Colors.blue,
                            markerSettings: MarkerSettings(isVisible: true),
                          ),
                          LineSeries<_SalesData, String>(
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.montantOptionDigital)
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.montantOptionDigital,
                            name: 'TrendLine digital option amount',
                            color: Color.fromARGB(223, 255, 115, 34),
                            markerSettings: MarkerSettings(isVisible: true),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 300,
                    //   child: SfCartesianChart(
                    //     primaryXAxis: CategoryAxis(),
                    //     title: ChartTitle(
                    //       text: 'Digital Data Number and Digital Data Amount per date',
                    //       textStyle: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //     legend: Legend(
                    //       isVisible: true,
                    //       overflowMode: LegendItemOverflowMode.wrap,
                    //     ),
                    //     tooltipBehavior: TooltipBehavior(enable: true),
                    //     series: <CartesianSeries>[
                    //       ScatterSeries<_SalesData, String>(
                    //         dataSource: selectedDates.isEmpty
                    //             ? getTop5Data(data, (d) => d.montantDataDigital)
                    //             : data.where((d) => selectedDates.contains(d.date)).toList(),
                    //         xValueMapper: (_SalesData sales, _) => sales.date,
                    //         yValueMapper: (_SalesData sales, _) => sales.nbrDataDigital.toDouble(),
                    //         name: 'Digital Data Number',
                    //         color: Colors.blue,
                    //         markerSettings: MarkerSettings(isVisible: true),
                    //       ),
                    //       ScatterSeries<_SalesData, String>(
                    //         dataSource: selectedDates.isEmpty
                    //             ? getTop5Data(data, (d) => d.montantDataDigital)
                    //             : data.where((d) => selectedDates.contains(d.date)).toList(),
                    //         xValueMapper: (_SalesData sales, _) => sales.date,
                    //         yValueMapper: (_SalesData sales, _) => sales.montantDataDigital,
                    //         name: 'Digital Data Amount',
                    //         color: Colors.orange,
                    //         markerSettings: MarkerSettings(isVisible: true),
                    //       ),
                    //     ],
                    //   ),
                    // ),
//                     Container(
//   height: 300,
//   child: SfCartesianChart(
//     primaryXAxis: CategoryAxis(),
//     title: ChartTitle(
//       text: 'Digital Data Number and Digital Data Amount per date',
//       textStyle: TextStyle(
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     ),
//     legend: Legend(
//       isVisible: true,
//       overflowMode: LegendItemOverflowMode.wrap,
//     ),
//     tooltipBehavior: TooltipBehavior(enable: true),
//     series: <CartesianSeries>[
//       ColumnSeries<_SalesData, String>(
//         dataSource: selectedDates.isEmpty
//             ? getTop5Data(data, (d) => d.montantDataDigital)
//             : data.where((d) => selectedDates.contains(d.date)).toList(),
//         xValueMapper: (_SalesData sales, _) => sales.date,
//         yValueMapper: (_SalesData sales, _) => sales.nbrDataDigital.toDouble(),
//         name: 'Digital Data Number',
//         color: Colors.blue,
//         dataLabelSettings: DataLabelSettings(isVisible: true),
//       ),
//       ColumnSeries<_SalesData, String>(
//         dataSource: selectedDates.isEmpty
//             ? getTop5Data(data, (d) => d.montantDataDigital)
//             : data.where((d) => selectedDates.contains(d.date)).toList(),
//         xValueMapper: (_SalesData sales, _) => sales.date,
//         yValueMapper: (_SalesData sales, _) => sales.montantDataDigital,
//         name: 'Digital Data Amount',
//         color: Colors.orange,
//         dataLabelSettings: DataLabelSettings(isVisible: true),
//       ),
//     ],
//   ),
// ),
// Container(
//   height: 300,
//   child: SfCartesianChart(
//     primaryXAxis: CategoryAxis(),
//     title: ChartTitle(
//       text: 'Digital Data Number and Digital Data Amount per date',
//       textStyle: TextStyle(
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     ),
//     legend: Legend(
//       isVisible: true,
//       overflowMode: LegendItemOverflowMode.wrap,
//     ),
//     tooltipBehavior: TooltipBehavior(enable: true),
//     series: <CartesianSeries>[
//       RangeColumnSeries<_SalesData, String>(
//         dataSource: selectedDates.isEmpty
//             ? getTop5Data(data, (d) => d.montantDataDigital)
//             : data.where((d) => selectedDates.contains(d.date)).toList(),
//         xValueMapper: (_SalesData sales, _) => sales.date,
//         lowValueMapper: (_SalesData sales, _) => sales.nbrDataDigital.toDouble(),
//         highValueMapper: (_SalesData sales, _) => sales.montantDataDigital,
//         name: 'Digital Data Range',
//         color: Colors.blue,
//         dataLabelSettings: DataLabelSettings(isVisible: true),
//       ),
//     ],
//   ),
// ),
Container(
  height: 300,
  child: SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    title: ChartTitle(
      text: 'Digital data number and digital data amount per date',
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    legend: Legend(
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap,
    ),
    tooltipBehavior: TooltipBehavior(enable: true, builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
      final _SalesData salesData = data;
      return Container(
        padding: EdgeInsets.all(5),
        child: Text(
          'Date: ${salesData.date}\nDigital Data Number: ${salesData.nbrDataDigital}\nDigital Data Amount: ${salesData.montantDataDigital}',
          style: TextStyle(color: Colors.white),
        ),
      );
    }),
    series: <CartesianSeries>[
      RangeColumnSeries<_SalesData, String>(
        dataSource: selectedDates.isEmpty
            ? getTop5Data(data, (d) => d.montantDataDigital)
            : data.where((d) => selectedDates.contains(d.date)).toList(),
        xValueMapper: (_SalesData sales, _) => sales.date,
        lowValueMapper: (_SalesData sales, _) => sales.nbrDataDigital.toDouble(),
        highValueMapper: (_SalesData sales, _) => sales.montantDataDigital,
        name: 'Digital data guideline',
        color: Colors.blue,
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
    ],
  ),
),

                  ],
                ),
              ),
            ),
    );
  }
}

class _SalesData {
  _SalesData(
    this.date,
    this.nombreRecharge,
    this.nbrOptionDigital,
    this.montantOptionDigital,
    this.nbrDataDigital,
    this.montantDataDigital,
    this.totalRechargeTNDTTC_Digital,
  );

  final String date;
  final int nombreRecharge;
  final int nbrOptionDigital;
  final double montantOptionDigital;
  final int nbrDataDigital;
  final double montantDataDigital;
  final double totalRechargeTNDTTC_Digital;
}

