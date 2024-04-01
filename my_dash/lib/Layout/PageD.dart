
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';

class PageD extends StatefulWidget {
  PageD({Key? key}) : super(key: key);

  @override
  PageDState createState() => PageDState();
}

class PageDState extends State<PageD> {
  List<_SalesData> data = [];
  List<String> dateList = [];
  List<String> selectedDates = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData("assets/RechargeOrange.json");
  }

  Future<void> fetchData(String jsonFileName) async {
    try {
      String jsonString = await rootBundle.loadString(jsonFileName);
      final jsonData = json.decode(jsonString);

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
        double pourcentageRechargeDigital = chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] != null
            ? (chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] is int
                ? (chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] as int).toDouble()
                : chartData["Pourcentage du recharge (Digital) par rapport au (Global)"])
            : 0.0;
        double pourcentageNombreRechargeDigital = chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] != null
            ? (chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] is int
                ? (chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] as int).toDouble()
                : chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"])
            : 0.0;

        return _SalesData(
          date,
          totalRechargeTNDHTGlobal,
          nombreRechargeGlobal,
          totalRechargeTNDDigital,
          nombreRechargeDigital,
          pourcentageRechargeDigital,
          pourcentageNombreRechargeDigital,
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
                              ? 'Total Recharge TND HT Global par dates '
                              : 'Bar Chart for ${selectedDates.join(", ")}',
                        ),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<_SalesData, String>>[
                          BarSeries<_SalesData, String>(
                            color: Color.fromARGB(223, 255, 115, 34),
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.totalRechargeTNDHTGlobal)
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHTGlobal,
                            name: 'Total Recharge TND HT Global',
                            dataLabelSettings: DataLabelSettings(isVisible: true),
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
                    ),
                    Container(
                      height: 300,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                        title: ChartTitle(text: 'Comparaison de Nombre Recharge par dates '),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<_SalesData, String>>[
                          BarSeries<_SalesData, String>(
                            color: Color.fromARGB(223, 255, 115, 34),
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.nombreRechargeGlobal.toDouble())
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.nombreRechargeGlobal.toDouble(),
                            name: 'Nombre Recharge Global',
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                          ),
                          BarSeries<_SalesData, String>(
                            color: Colors.blue,
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.nombreRechargeDigital.toDouble())
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.nombreRechargeDigital.toDouble(),
                            name: 'Nombre Recharge Digital',
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 300,
                            child: SfCircularChart(
                              title: ChartTitle(text: 'Pourcentage du Nombre de recharge (Digital) par rapport au (Global) par dates'),
                              legend: Legend(isVisible: true),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CircularSeries<_SalesData, String>>[
                                PieSeries<_SalesData, String>(
                                  dataSource: selectedDates.isEmpty
                                      ? getTop5Data(data, (d) => d.pourcentageRechargeDigital)
                                      : data.where((d) => selectedDates.contains(d.date)).toList(),
                                  xValueMapper: (_SalesData sales, _) => sales.date,
                                  yValueMapper: (_SalesData sales, _) => sales.pourcentageRechargeDigital,
                                  name: 'Pourcentage Recharge Digital',
                                  dataLabelSettings: DataLabelSettings(isVisible: true),
                                ),
                                PieSeries<_SalesData, String>(
                                  dataSource: selectedDates.isEmpty
                                      ? getTop5Data(data, (d) => d.pourcentageNombreRechargeDigital)
                                      : data.where((d) => selectedDates.contains(d.date)).toList(),
                                  xValueMapper: (_SalesData sales, _) => sales.date,
                                  yValueMapper: (_SalesData sales, _) => sales.pourcentageNombreRechargeDigital,
                                  name: 'Pourcentage de Nombre de Recharge Digital par rapport au Global',
                                  dataLabelSettings: DataLabelSettings(isVisible: true),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            child: SfCircularChart(
                              title: ChartTitle(text: ' Pourcentage de Recharge Digital par rapport au Recharge Global'),
                              legend: Legend(isVisible: true),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CircularSeries<_SalesData, String>>[
                                DoughnutSeries<_SalesData, String>(
                                  dataSource: selectedDates.isEmpty
                                      ? getTop5Data(data, (d) => d.pourcentageRechargeDigital)
                                      : data.where((d) => selectedDates.contains(d.date)).toList(),
                                  xValueMapper: (_SalesData sales, _) => sales.date,
                                  yValueMapper: (_SalesData sales, _) => sales.pourcentageRechargeDigital,
                                  dataLabelSettings: DataLabelSettings(isVisible: true),
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
    this.pourcentageRechargeDigital,
    this.pourcentageNombreRechargeDigital,
  );

  final String date;
  final double totalRechargeTNDHTGlobal;
  final int nombreRechargeGlobal;
  final double totalRechargeTNDDigital;
  final int nombreRechargeDigital;
  final double pourcentageRechargeDigital;
  final double pourcentageNombreRechargeDigital;
}




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class PageD extends StatefulWidget {
//   PageD({Key? key}) : super(key: key);

//   @override
//   PageDState createState() => PageDState();
// }

// class PageDState extends State<PageD> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   List<String> selectedDates = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData("assets/RechargeOrange.json");
//   }

//   Future<void> fetchData(String jsonFileName) async {
//     try {
//       String jsonString = await rootBundle.loadString(jsonFileName);
//       final jsonData = json.decode(jsonString);

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
//         double pourcentageRechargeDigital = chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] != null
//             ? (chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] is int
//                 ? (chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] as int).toDouble()
//                 : chartData["Pourcentage du recharge (Digital) par rapport au (Global)"])
//             : 0.0;
//         double pourcentageNombreRechargeDigital = chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] != null
//             ? (chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] is int
//                 ? (chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] as int).toDouble()
//                 : chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"])
//             : 0.0;

//         return _SalesData(
//           date,
//           totalRechargeTNDHTGlobal,
//           nombreRechargeGlobal,
//           totalRechargeTNDDigital,
//           nombreRechargeDigital,
//           pourcentageRechargeDigital,
//           pourcentageNombreRechargeDigital,
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
//                               ? 'Bar Chart for all dates'
//                               : 'Bar Chart for ${selectedDates.join(", ")}',
//                         ),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? data
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHTGlobal,
//                             name: 'Total Recharge TND HT Global',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                             pointColorMapper: (_SalesData sales, _) {
//                               double maxVal = selectedDates.isEmpty
//                                   ? data.map((d) => d.totalRechargeTNDHTGlobal).reduce((a, b) => a > b ? a : b)
//                                   : data
//                                       .where((d) => selectedDates.contains(d.date))
//                                       .map((d) => d.totalRechargeTNDHTGlobal)
//                                       .reduce((a, b) => a > b ? a : b);

//                               return sales.totalRechargeTNDHTGlobal == maxVal ? Colors.red : Color.fromARGB(223, 255, 115, 34);
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
//                         title: ChartTitle(text: 'Nombre Recharge Comparison'),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? data
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRechargeGlobal.toDouble(),
//                             name: 'Nombre Recharge Global',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? data
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRechargeDigital.toDouble(),
//                             name: 'Nombre Recharge Digital',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 300,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             height: 300,
//                             child: SfCircularChart(
//                               title: ChartTitle(text: 'Pourcentage Recharge Digital Comparison'),
//                               legend: Legend(isVisible: true),
//                               tooltipBehavior: TooltipBehavior(enable: true),
//                               series: <CircularSeries<_SalesData, String>>[
//                                 PieSeries<_SalesData, String>(
//                                   dataSource: selectedDates.isEmpty
//                                       ? data
//                                       : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                   xValueMapper: (_SalesData sales, _) => sales.date,
//                                   yValueMapper: (_SalesData sales, _) => sales.pourcentageRechargeDigital,
//                                   name: 'Pourcentage Recharge Digital',
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 300,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Pourcentage Nombre Recharge Digital',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 10),
//                                 SfLinearGauge(
//                                   minimum: 0,
//                                   maximum: 100,
//                                   orientation: LinearGaugeOrientation.horizontal,
//                                   ranges: [
//                                     LinearGaugeRange(
//                                       startValue: 0,
//                                       endValue: selectedDates.isEmpty
//                                           ? data.map((d) => d.pourcentageNombreRechargeDigital).reduce((a, b) => a > b ? a : b)
//                                           : data
//                                               .where((d) => selectedDates.contains(d.date))
//                                               .map((d) => d.pourcentageNombreRechargeDigital)
//                                               .reduce((a, b) => a > b ? a : b),
//                                       color: const Color(0xFFFFD700),
//                                     ),
//                                   ],
//                                   barPointers: [
//                                     LinearBarPointer(
//                                       value: selectedDates.isEmpty
//                                           ? data.map((d) => d.pourcentageNombreRechargeDigital).reduce((a, b) => a > b ? a : b)
//                                           : data
//                                               .where((d) => selectedDates.contains(d.date))
//                                               .map((d) => d.pourcentageNombreRechargeDigital)
//                                               .reduce((a, b) => a > b ? a : b),
//                                       color: const Color(0xFFFFD700),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   '${selectedDates.isEmpty ? data.map((d) => d.pourcentageNombreRechargeDigital).reduce((a, b) => a > b ? a : b) : data.where((d) => selectedDates.contains(d.date)).map((d) => d.pourcentageNombreRechargeDigital).reduce((a, b) => a > b ? a : b).toStringAsFixed(2)}%',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         title: ChartTitle(text: 'Pourcentage Nombre Recharge Digital Line Chart'),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           LineSeries<_SalesData, String>(
//                             color: Colors.green,
//                             dataSource: selectedDates.isEmpty
//                                 ? data
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.pourcentageNombreRechargeDigital,
//                             name: 'Pourcentage Nombre Recharge Digital',
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
//     this.totalRechargeTNDHTGlobal,
//     this.nombreRechargeGlobal,
//     this.totalRechargeTNDDigital,
//     this.nombreRechargeDigital,
//     this.pourcentageRechargeDigital,
//     this.pourcentageNombreRechargeDigital,
//   );

//   final String date;
//   final double totalRechargeTNDHTGlobal;
//   final int nombreRechargeGlobal;
//   final double totalRechargeTNDDigital;
//   final int nombreRechargeDigital;
//   final double pourcentageRechargeDigital;
//   final double pourcentageNombreRechargeDigital;
// }

//mohawla filter
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:syncfusion_flutter_charts/charts.dart';

// class PageD extends StatefulWidget {
//   PageD({Key? key}) : super(key: key);

//   @override
//   PageDState createState() => PageDState();
// }

// class PageDState extends State<PageD> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   List<String> selectedDates = [];
//   bool loading = true;
//   DateTime? selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     fetchData("assets/RechargeOrange.json");
//   }

//   Future<void> fetchData(String jsonFileName) async {
//     try {
//       String jsonString = await rootBundle.loadString(jsonFileName);
//       final jsonData = json.decode(jsonString);

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
//         double pourcentageRechargeDigital = chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] != null
//             ? (chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] is int
//                 ? (chartData["Pourcentage du recharge (Digital) par rapport au (Global)"] as int).toDouble()
//                 : chartData["Pourcentage du recharge (Digital) par rapport au (Global)"])
//             : 0.0;
//         double pourcentageNombreRechargeDigital = chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] != null
//             ? (chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] is int
//                 ? (chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"] as int).toDouble()
//                 : chartData["Pourcentage du Nombre de recharge (Digital) par rapport au (Global)"])
//             : 0.0;

//         return _SalesData(
//           date,
//           totalRechargeTNDHTGlobal,
//           nombreRechargeGlobal,
//           totalRechargeTNDDigital,
//           nombreRechargeDigital,
//           pourcentageRechargeDigital,
//           pourcentageNombreRechargeDigital,
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

//   Future<void> _selectDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         // Filter data for the selected date
//         selectedDates = data
//             .where((d) => DateTime.parse(d.date).isAtSameMomentAs(selectedDate!))
//             .map((d) => d.date)
//             .toList();
//       });
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
//               length: 3,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: _selectDate,
//                           child: Text('Select Date'),
//                         ),
//                         if (selectedDate != null)
//                           Text(
//                             'Selected Date: ${selectedDate!.toLocal()}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                       ],
//                     ),
//                     Container(
//                       height: 300,
//                       child: SfCartesianChart(
//                         primaryXAxis: CategoryAxis(),
//                         title: ChartTitle(
//                           text: selectedDates.isEmpty
//                               ? 'Bar Chart for all dates'
//                               : 'Bar Chart for ${selectedDates.join(", ")}',
//                         ),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? data
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHTGlobal,
//                             name: 'Total Recharge TND HT Global',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                             pointColorMapper: (_SalesData sales, _) {
//                               double maxVal = selectedDates.isEmpty
//                                   ? data.map((d) => d.totalRechargeTNDHTGlobal).reduce((a, b) => a > b ? a : b)
//                                   : data
//                                       .where((d) => selectedDates.contains(d.date))
//                                       .map((d) => d.totalRechargeTNDHTGlobal)
//                                       .reduce((a, b) => a > b ? a : b);

//                               return sales.totalRechargeTNDHTGlobal == maxVal ? Colors.red : Color.fromARGB(223, 255, 115, 34);
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
//                         title: ChartTitle(text: 'Nombre Recharge Comparison'),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? data
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRechargeGlobal.toDouble(),
//                             name: 'Nombre Recharge Global',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? data
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRechargeDigital.toDouble(),
//                             name: 'Nombre Recharge Digital',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 300,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             height: 300,
//                             child: SfCircularChart(
//                               title: ChartTitle(text: 'Pourcentage Comparison'),
//                               legend: Legend(isVisible: true),
//                               tooltipBehavior: TooltipBehavior(enable: true),
//                               series: <CircularSeries<_SalesData, String>>[
//                                 PieSeries<_SalesData, String>(
//                                   dataSource: selectedDates.isEmpty
//                                       ? data
//                                       : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                   xValueMapper: (_SalesData sales, _) => sales.date,
//                                   yValueMapper: (_SalesData sales, _) => sales.pourcentageRechargeDigital,
//                                   name: 'Pourcentage Recharge Digital',
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 ),
//                                 PieSeries<_SalesData, String>(
//                                   dataSource: selectedDates.isEmpty
//                                       ? data
//                                       : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                   xValueMapper: (_SalesData sales, _) => sales.date,
//                                   yValueMapper: (_SalesData sales, _) => sales.pourcentageNombreRechargeDigital,
//                                   name: 'Pourcentage Nombre Recharge Digital',
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 ),
//                               ],
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
//     this.totalRechargeTNDHTGlobal,
//     this.nombreRechargeGlobal,
//     this.totalRechargeTNDDigital,
//     this.nombreRechargeDigital,
//     this.pourcentageRechargeDigital,
//     this.pourcentageNombreRechargeDigital,
//   );

//   final String date;
//   final double totalRechargeTNDHTGlobal;
//   final int nombreRechargeGlobal;
//   final double totalRechargeTNDDigital;
//   final int nombreRechargeDigital;
//   final double pourcentageRechargeDigital;
//   final double pourcentageNombreRechargeDigital;
// }
