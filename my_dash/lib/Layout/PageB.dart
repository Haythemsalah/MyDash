
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
//                     // Bar chart
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//                             name: 'Total Recharge Jour J',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourJ7)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
//                             name: 'Total Recharge Jour J-7',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourM1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
//                             name: 'totalRechargeJourM-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.red,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourY1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
//                             name: 'Total Recharge Jour Y-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Line chart
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           LineSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//                             name: 'Total Recharge Jour J',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourJ7)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
//                             name: 'Total Recharge Jour J-7',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourM1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
//                             name: 'totalRechargeJourM-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.red,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourY1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
//                             name: 'Total Recharge Jour Y-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Bar chart
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Comparaison de total Recharge Cummulé par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulM)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM,
//                             name: 'Total Recharge Cummul M',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulM1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM1,
//                             name: 'Total Recharge Cummul M-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulY1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulY1,
//                             name: 'Total Recharge Cummul Y-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Line chart
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Comparaison de total Recharge Cummulé par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           LineSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulM)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM,
//                             name: 'Total Recharge Cummul M',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulM1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM1,
//                             name: 'Total Recharge Cummul M-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulY1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulY1,
//                             name: 'Total Recharge Cummul Y-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
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
//                     // Bar chart
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//                             name: 'Total Recharge Jour J',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourJ7)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
//                             name: 'Total Recharge Jour J-7',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourM1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
//                             name: 'totalRechargeJourM-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.red,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourY1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
//                             name: 'Total Recharge Jour Y-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Line chart
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           LineSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//                             name: 'Total Recharge Jour J',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourJ7)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
//                             name: 'Total Recharge Jour J-7',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourM1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
//                             name: 'totalRechargeJourM-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.red,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeJourY1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
//                             name: 'Total Recharge Jour Y-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Bar chart
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Comparaison de total Recharge Cummulé par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulM)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM,
//                             name: 'Total Recharge Cummul M',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulM1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM1,
//                             name: 'Total Recharge Cummul M-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulY1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulY1,
//                             name: 'Total Recharge Cummul Y-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Line chart
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         primaryYAxis: NumericAxis(),
//                         title: ChartTitle(text: 'Comparaison de total Recharge Cummulé par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           LineSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulM)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM,
//                             name: 'Total Recharge Cummul M',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulM1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM1,
//                             name: 'Total Recharge Cummul M-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           LineSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeCummulY1)
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulY1,
//                             name: 'Total Recharge Cummul Y-1',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                    // Bubble chart
// Container(
//   height: 300,
//   child: SfCartesianChart(
//     title: ChartTitle(text: 'Bubble Chart'),
//     legend: Legend(isVisible: true),
//     tooltipBehavior: TooltipBehavior(enable: true),
//     series: <CartesianSeries>[
//       BubbleSeries<_SalesData, num>(
//         dataSource: selectedDates.isEmpty
//             ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//             : data.where((d) => selectedDates.contains(d.date)).toList(),
//         xValueMapper: (_SalesData sales, _) => dateList.indexOf(sales.date), // Convert date to index
//         yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//         sizeValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//         name: 'Bubble Series',
//         color: Color.fromARGB(255, 31, 75, 138),
//       ),
//     ],
//   ),
// ),
// Container(
//   height: 300,
//   child: SfCartesianChart(
//     primaryXAxis: CategoryAxis(), // Use CategoryAxis for vertical bars
//     primaryYAxis: NumericAxis(), // Use NumericAxis for the value axis
//     title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
//     legend: Legend(isVisible: true),
//     tooltipBehavior: TooltipBehavior(enable: true),
//     series: <CartesianSeries>[
//       BarSeries<_SalesData, String>(
//         color: Colors.purple, // Change color as desired
//         dataSource: selectedDates.isEmpty
//             ? getTop5Data(data, (d) => d.totalRechargeJourM1) // Data source for the new chart
//             : data.where((d) => selectedDates.contains(d.date)).toList(),
//         xValueMapper: (_SalesData sales, _) => sales.date,
//         yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1, // Corrected yValueMapper
//         name: 'Total Recharge Jour M-1', // Name of the new chart
//         dataLabelSettings: DataLabelSettings(isVisible: true),
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
//                     // Candlestick chart
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
//                           Text('Candlestick Chart'),
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
//                                   CandleSeries<_SalesData, String>(
//                                     dataSource: selectedDates.isEmpty
//                                         ? getTop5Data(data, (d) => d.totalRechargeJourJ)
//                                         : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                     xValueMapper: (_SalesData sales, _) => sales.date,
//                                     lowValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
//                                     highValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
//                                     openValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
//                                     closeValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
//                                   ),
//                                 ],
//                               ),
//                             ),
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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';

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
    fetchData("assets/RechargeGlobal.json");
  }

  Future<void> fetchData(String jsonFileName) async {
    try {
      String jsonString = await rootBundle.loadString(jsonFileName);
      final jsonData = json.decode(jsonString);

      data = jsonData.map<_SalesData>((chartData) {
        String date = chartData['date'] ?? '';
        double totalRechargeJourJ = (chartData["total_recharge_jour_j"] ?? 0).toDouble();
        double totalRechargeJourJ7 = (chartData["total_recharge_jour_j_7"] ?? 0).toDouble();
        double totalRechargeJourM1 = (chartData["total_recharge_jour_m_1"] ?? 0).toDouble();
        double totalRechargeJourY1 = (chartData["total_recharge_jour_y_1"] ?? 0).toDouble();
        double totalRechargeCummulM = (chartData["total_recharge_cummul_m"] ?? 0).toDouble();
        double totalRechargeCummulM1 = (chartData["total_recharge_cummul_m_1"] ?? 0).toDouble();
        double totalRechargeCummulY1 = (chartData["total_recharge_cummul_y_1"] ?? 0).toDouble();

        return _SalesData(
          date,
          totalRechargeJourJ,
          totalRechargeJourJ7,
          totalRechargeJourM1,
          totalRechargeJourY1,
          totalRechargeCummulM,
          totalRechargeCummulM1,
          totalRechargeCummulY1,
        );
      }).toList();

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
          'KPIs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 3,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Date filter buttons
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
                                primary: selectedDates.contains(dateList[index]) ? Colors.black : null,
                              ),
                              child: Text(
                                dateList[index],
                                style: TextStyle(
                                  color: selectedDates.contains(dateList[index]) ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Bar chart
                    Container(
                      height: 350,
                      margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white, // Gray background color
                      ),
                      child: Column(
                        children: [
                          Text('Bar Chart'),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(),
                                title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CartesianSeries<_SalesData, String>>[
                                  BarSeries<_SalesData, String>(
                                    color: Color.fromARGB(223, 255, 115, 34),
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeJourJ)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
                                    name: 'Total Recharge Jour J',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  BarSeries<_SalesData, String>(
                                    color: Colors.blue,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeJourJ7)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
                                    name: 'Total Recharge Jour J-7',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  BarSeries<_SalesData, String>(
                                    color: Colors.green,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeJourM1)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
                                    name: 'totalRechargeJourM-1',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  BarSeries<_SalesData, String>(
                                    color: Colors.red,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeJourY1)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
                                    name: 'Total Recharge Jour Y-1',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Line chart
                    Container(
                      height: 350,
                      margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white, // Gray background color
                      ),
                      child: Column(
                        children: [
                          Text('Line Chart'),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(),
                                title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CartesianSeries<_SalesData, String>>[
                                  LineSeries<_SalesData, String>(
                                    color: Color.fromARGB(223, 255, 115, 34),
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeJourJ)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ,
                                    name: 'Total Recharge Jour J',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  LineSeries<_SalesData, String>(
                                    color: Colors.blue,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeJourJ7)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
                                    name: 'Total Recharge Jour J-7',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  LineSeries<_SalesData, String>(
                                    color: Colors.green,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeJourM1)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourM1,
                                    name: 'totalRechargeJourM-1',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  LineSeries<_SalesData, String>(
                                    color: Colors.red,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeJourY1)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1,
                                    name: 'Total Recharge Jour Y-1',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Bar chart for total Recharge Cummulé
                    Container(
                      height: 350,
                      margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white, // Gray background color
                      ),
                      child: Column(
                        children: [
                          Text('Bar Chart for Total Recharge Cummulé'),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(),
                                title: ChartTitle(text: 'Comparaison de total Recharge Cummulé par dates '),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CartesianSeries<_SalesData, String>>[
                                  BarSeries<_SalesData, String>(
                                    color: Color.fromARGB(223, 255, 115, 34),
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeCummulM)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM,
                                    name: 'Total Recharge Cummul M',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  BarSeries<_SalesData, String>(
                                    color: Colors.blue,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeCummulM1)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM1,
                                    name: 'Total Recharge Cummul M-1',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  BarSeries<_SalesData, String>(
                                    color: Colors.green,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeCummulY1)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulY1,
                                    name: 'Total Recharge Cummul Y-1',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Line chart for total Recharge Cummulé
                    Container(
                      height: 350,
                      margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white, // Gray background color
                      ),
                      child: Column(
                        children: [
                          Text('Line Chart for Total Recharge Cummulé'),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(),
                                title: ChartTitle(text: 'Comparaison de total Recharge Cummulé par dates '),
                                legend: Legend(isVisible: true),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CartesianSeries<_SalesData, String>>[
                                  LineSeries<_SalesData, String>(
                                    color: Color.fromARGB(223, 255, 115, 34),
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeCummulM)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM,
                                    name: 'Total Recharge Cummul M',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  LineSeries<_SalesData, String>(
                                    color: Colors.blue,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeCummulM1)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulM1,
                                    name: 'Total Recharge Cummul M-1',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                  LineSeries<_SalesData, String>(
                                    color: Colors.green,
                                    dataSource: selectedDates.isEmpty
                                        ? getTop5Data(data, (d) => d.totalRechargeCummulY1)
                                        : data.where((d) => selectedDates.contains(d.date)).toList(),
                                    xValueMapper: (_SalesData sales, _) => sales.date,
                                    yValueMapper: (_SalesData sales, _) => sales.totalRechargeCummulY1,
                                    name: 'Total Recharge Cummul Y-1',
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                   // Candlestick chart
Container(
  height: 350,
  margin: EdgeInsets.only(bottom: 20), // Add margin to the bottom
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(10),
    color: Colors.white, // Gray background color
  ),
  child: Column(
    children: [
      Text('Candlestick Chart'),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            title: ChartTitle(text: 'Comparaison de total Recharge par dates '),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<_SalesData, String>>[
              CandleSeries<_SalesData, String>(
                dataSource: selectedDates.isEmpty
                    ? getTop5Data(data, (d) => d.totalRechargeJourJ)
                    : data.where((d) => selectedDates.contains(d.date)).toList(),
                xValueMapper: (_SalesData sales, _) => sales.date,
                lowValueMapper: (_SalesData sales, _) => 
                  sales.totalRechargeJourY1 < sales.totalRechargeJourJ ? sales.totalRechargeJourY1 : sales.totalRechargeJourJ,
                highValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ7,
                openValueMapper: (_SalesData sales, _) => sales.totalRechargeJourY1, // Set open value to totalRechargeJourY1
                closeValueMapper: (_SalesData sales, _) => sales.totalRechargeJourJ, // Set close value to totalRechargeJourJ
                bearColor: Colors.red, // Red color for bearish candles
                bullColor: Colors.green, // Green color for bullish candles
              ),
            ],
          ),
        ),
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
    this.totalRechargeJourJ,
    this.totalRechargeJourJ7,
    this.totalRechargeJourM1,
    this.totalRechargeJourY1,
    this.totalRechargeCummulM,
    this.totalRechargeCummulM1,
    this.totalRechargeCummulY1,
  );

  final String date;
  final double totalRechargeJourJ;
  final double totalRechargeJourJ7;
  final double totalRechargeJourM1;
  final double totalRechargeJourY1;
  final double totalRechargeCummulM;
  final double totalRechargeCummulM1;
  final double totalRechargeCummulY1;
}
