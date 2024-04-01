// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';

// class PageC extends StatefulWidget {
//   PageC({Key? key}) : super(key: key);

//   @override
//   PageCState createState() => PageCState();
// }

// class PageCState extends State<PageC> {
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';

class PageC extends StatefulWidget {
  PageC({Key? key}) : super(key: key);

  @override
  PageCState createState() => PageCState();
}

class PageCState extends State<PageC> {
  List<MyDataModel> data = [];
  List<String> dateList = [];
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

      data = jsonData.map<MyDataModel>((chartData) {
        String date = chartData['date'] ?? '';
        double totalRechargeJourJ = (chartData["total_recharge_jour_j"] ?? 0).toDouble();
        double totalRechargeJourJ7 = (chartData["total_recharge_jour_j_7"] ?? 0).toDouble();
        double totalRechargeJourM1 = (chartData["total_recharge_jour_m_1"] ?? 0).toDouble();
        double totalRechargeJourY1 = (chartData["total_recharge_jour_y_1"] ?? 0).toDouble();
        double totalRechargeCummulM = (chartData["total_recharge_cummul_m"] ?? 0).toDouble();
        double totalRechargeCummulM1 = (chartData["total_recharge_cummul_m_1"] ?? 0).toDouble();
        double totalRechargeCummulY1 = (chartData["total_recharge_cummul_y_1"] ?? 0).toDouble();

        return MyDataModel(
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
      });
    } catch (e) {
      print("Error loading/processing data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bar Chart from JSON Data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total Recharge by Dates',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Total Recharge')),
                      series: _buildBarSeries(),
                      tooltipBehavior: TooltipBehavior(enable: true),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  List<BarSeries<MyDataModel, String>> _buildBarSeries() {
    return [
      BarSeries<MyDataModel, String>(
        dataSource: data,
        xValueMapper: (datum, _) => datum.date,
        yValueMapper: (datum, _) => datum.totalRechargeJourJ,
        name: 'Total Recharge Jour J',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
      BarSeries<MyDataModel, String>(
        dataSource: data,
        xValueMapper: (datum, _) => datum.date,
        yValueMapper: (datum, _) => datum.totalRechargeJourJ7,
        name: 'Total Recharge Jour J-7',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
      BarSeries<MyDataModel, String>(
        dataSource: data,
        xValueMapper: (datum, _) => datum.date,
        yValueMapper: (datum, _) => datum.totalRechargeJourM1,
        name: 'Total Recharge Jour M-1',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
      BarSeries<MyDataModel, String>(
        dataSource: data,
        xValueMapper: (datum, _) => datum.date,
        yValueMapper: (datum, _) => datum.totalRechargeJourY1,
        name: 'Total Recharge Jour Y-1',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
      BarSeries<MyDataModel, String>(
        dataSource: data,
        xValueMapper: (datum, _) => datum.date,
        yValueMapper: (datum, _) => datum.totalRechargeCummulM,
        name: 'Total Recharge Cummul M',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
      BarSeries<MyDataModel, String>(
        dataSource: data,
        xValueMapper: (datum, _) => datum.date,
        yValueMapper: (datum, _) => datum.totalRechargeCummulM1,
        name: 'Total Recharge Cummul M-1',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
      BarSeries<MyDataModel, String>(
        dataSource: data,
        xValueMapper: (datum, _) => datum.date,
        yValueMapper: (datum, _) => datum.totalRechargeCummulY1,
        name: 'Total Recharge Cummul Y-1',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
    ];
  }
}

class MyDataModel {
  MyDataModel(
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
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:fl_chart/fl_chart.dart';

// class PageC extends StatefulWidget {
//   PageC({Key? key}) : super(key: key);

//   @override
//   PageCState createState() => PageCState();
// }

// class PageCState extends State<PageC> {
//   List<MyDataModel> data = [];
//   List<String> dateList = [];
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

//       data = jsonData.map<MyDataModel>((chartData) {
//         String date = chartData['date'] ?? '';
//         double totalRechargeJourJ = (chartData["total_recharge_jour_j"] ?? 0).toDouble();
//         double totalRechargeJourJ7 = (chartData["total_recharge_jour_j_7"] ?? 0).toDouble();
//         double totalRechargeJourM1 = (chartData["total_recharge_jour_m_1"] ?? 0).toDouble();
//         double totalRechargeJourY1 = (chartData["total_recharge_jour_y_1"] ?? 0).toDouble();
//         double totalRechargeCummulM = (chartData["total_recharge_cummul_m"] ?? 0).toDouble();
//         double totalRechargeCummulM1 = (chartData["total_recharge_cummul_m_1"] ?? 0).toDouble();
//         double totalRechargeCummulY1 = (chartData["total_recharge_cummul_y_1"] ?? 0).toDouble();

//         return MyDataModel(
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

//       dateList = data.map((salesData) => salesData.date).toList();

//       setState(() {
//         loading = false;
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(
//         'Bar Chart from JSON Data',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//     body: loading
//         ? Center(child: CircularProgressIndicator())
//         : Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Total Recharge by Dates',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: dateList.isNotEmpty
//                       ? BarChart(
//                           BarChartData(
//                             alignment: BarChartAlignment.center,
//                             groupsSpace: 20,
//                             barTouchData: BarTouchData(enabled: false),
//                             titlesData: FlTitlesData(
//                               bottomTitles: SideTitles(
//                                 showTitles: true,
//                                 getTextStyles: (_) => TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                                 margin: 10,
//                                 getTitles: (double value) {
//                                   return dateList[value.toInt()];
//                                 },
//                               ),
//                             ),
//                             borderData: FlBorderData(show: false),
//                             barGroups: _buildBarGroups(),
//                           ),
//                         )
//                       : Center(
//                           child: Text(
//                             'No data available.',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                 ),
//               ],
//             ),
//           ),
//   );
// }

//   List<BarChartGroupData> _buildBarGroups() {
//     List<BarChartGroupData> barGroups = [];
//     for (int i = 0; i < dateList.length; i++) {
//       List<double> values = [
//         data[i].totalRechargeJourJ,
//         data[i].totalRechargeJourJ7,
//         data[i].totalRechargeJourM1,
//         data[i].totalRechargeJourY1,
//         data[i].totalRechargeCummulM,
//         data[i].totalRechargeCummulM1,
//         data[i].totalRechargeCummulY1,
//       ];
//       List<BarChartRodData> rods = values.map((value) => BarChartRodData(y: value, color: Colors.blue)).toList();

//       barGroups.add(BarChartGroupData(x: i, barsSpace: 4, barRods: rods));
//     }
//     return barGroups;
//   }
// }

// class MyDataModel {
//   MyDataModel(
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
