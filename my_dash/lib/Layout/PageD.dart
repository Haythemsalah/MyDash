
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
//                               ? 'Total Recharge TND HT Global par dates '
//                               : 'Bar Chart for ${selectedDates.join(", ")}',
//                         ),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.totalRechargeTNDHTGlobal)
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
//                         title: ChartTitle(text: 'Comparaison de Nombre Recharge par dates '),
//                         legend: Legend(isVisible: true),
//                         tooltipBehavior: TooltipBehavior(enable: true),
//                         series: <CartesianSeries<_SalesData, String>>[
//                           BarSeries<_SalesData, String>(
//                             color: Color.fromARGB(223, 255, 115, 34),
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.nombreRechargeGlobal.toDouble())
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRechargeGlobal.toDouble(),
//                             name: 'Nombre Recharge Global',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           BarSeries<_SalesData, String>(
//                             color: Colors.blue,
//                             dataSource: selectedDates.isEmpty
//                                 ? getTop5Data(data, (d) => d.nombreRechargeDigital.toDouble())
//                                 : data.where((d) => selectedDates.contains(d.date)).toList(),
//                             xValueMapper: (_SalesData sales, _) => sales.date,
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRechargeDigital.toDouble(),
//                             name: 'Nombre Recharge Digital',
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             height: 300,
//                             child: SfCircularChart(
//                               title: ChartTitle(text: 'Pourcentage du Nombre de recharge (Digital) par rapport au (Global) par dates'),
//                               legend: Legend(isVisible: true),
//                               tooltipBehavior: TooltipBehavior(enable: true),
//                               series: <CircularSeries<_SalesData, String>>[
//                                 PieSeries<_SalesData, String>(
//                                   dataSource: selectedDates.isEmpty
//                                       ? getTop5Data(data, (d) => d.pourcentageRechargeDigital)
//                                       : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                   xValueMapper: (_SalesData sales, _) => sales.date,
//                                   yValueMapper: (_SalesData sales, _) => sales.pourcentageRechargeDigital,
//                                   name: 'Pourcentage Recharge Digital',
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 ),
//                                 PieSeries<_SalesData, String>(
//                                   dataSource: selectedDates.isEmpty
//                                       ? getTop5Data(data, (d) => d.pourcentageNombreRechargeDigital)
//                                       : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                   xValueMapper: (_SalesData sales, _) => sales.date,
//                                   yValueMapper: (_SalesData sales, _) => sales.pourcentageNombreRechargeDigital,
//                                   name: 'Pourcentage de Nombre de Recharge Digital par rapport au Global',
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 300,
//                             child: SfCircularChart(
//                               title: ChartTitle(text: ' Pourcentage de Recharge Digital par rapport au Recharge Global'),
//                               legend: Legend(isVisible: true),
//                               tooltipBehavior: TooltipBehavior(enable: true),
//                               series: <CircularSeries<_SalesData, String>>[
//                                 DoughnutSeries<_SalesData, String>(
//                                   dataSource: selectedDates.isEmpty
//                                       ? getTop5Data(data, (d) => d.pourcentageRechargeDigital)
//                                       : data.where((d) => selectedDates.contains(d.date)).toList(),
//                                   xValueMapper: (_SalesData sales, _) => sales.date,
//                                   yValueMapper: (_SalesData sales, _) => sales.pourcentageRechargeDigital,
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




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:my_dash/services/RetrieveData_api.dart';

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
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      ApiService apiService = ApiService();
      List<Fact> facts = await apiService.fetchFacts();

      data = facts
          .where((fact) => fact.typeRecharge == "Global")
          .map<_SalesData>((fact) => _SalesData(
                fact.date,
                fact.nombreRecharge,
                fact.nbrOptionGlobal,
                fact.montantOptionGlobal,
                fact.nbrDataGlobal,
                fact.montantDataGlobal,
                fact.totalRechargeTNDHT,
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
          'KPIs',
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
                              ? 'Nombre Recharge par dates '
                              : 'Bar Chart for ${selectedDates.join(", ")}',
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
                            name: 'Nombre Recharge',
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
                        title: ChartTitle(text: 'NbrOptionGlobal et MontantOptionGlobal par dates'),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<_SalesData, String>>[
                          BarSeries<_SalesData, String>(
                            color: Colors.blue,
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.nbrOptionGlobal.toDouble())
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.nbrOptionGlobal.toDouble(),
                            name: 'NbrOptionGlobal',
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                          ),
                          BarSeries<_SalesData, String>(
                            color: Colors.green,
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.montantOptionGlobal)
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.montantOptionGlobal,
                            name: 'MontantOptionGlobal',
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                          ),
                        ],
                      ),
                    ),
                    Container(
  height: 300,
  child: SfCircularChart(
    title: ChartTitle(text: 'DataGlobal Distribution'),
    legend: Legend(isVisible: true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CircularSeries<_SalesData, String>>[
      PieSeries<_SalesData, String>(
        dataSource: selectedDates.isEmpty
            ? getTop5Data(data, (d) => d.nbrDataGlobal.toDouble())
            : data.where((d) => selectedDates.contains(d.date)).toList(),
        xValueMapper: (_SalesData sales, _) => sales.date,
        yValueMapper: (_SalesData sales, _) => sales.nbrDataGlobal.toDouble(),
        pointColorMapper: (_SalesData sales, _) => Colors.orange,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
          labelIntersectAction: LabelIntersectAction.none,
         // labelStyle: TextStyle(fontSize: 12),
          connectorLineSettings: ConnectorLineSettings(
            type: ConnectorType.curve,
            length: '10%',
          ),
        ),
        name: 'NbrDataGlobal',
      ),
      DoughnutSeries<_SalesData, String>(
        dataSource: selectedDates.isEmpty
            ? getTop5Data(data, (d) => d.montantDataGlobal)
            : data.where((d) => selectedDates.contains(d.date)).toList(),
        xValueMapper: (_SalesData sales, _) => sales.date,
        yValueMapper: (_SalesData sales, _) => sales.montantDataGlobal,
        pointColorMapper: (_SalesData sales, _) => const Color.fromARGB(255, 56, 56, 56),
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
          labelIntersectAction: LabelIntersectAction.none,
          //labelStyle: TextStyle(fontSize: 12),
          connectorLineSettings: ConnectorLineSettings(
            type: ConnectorType.curve,
            length: '10%',
          ),
        ),
        name: 'MontantDataGlobal',
      ),
    ],
  ),
),


                    Container(
                      height: 300,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                        title: ChartTitle(text: 'TotalRechargeTNDHT par dates '),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<_SalesData, String>>[
                          BarSeries<_SalesData, String>(
                            color: Colors.orange,
                            dataSource: selectedDates.isEmpty
                                ? getTop5Data(data, (d) => d.totalRechargeTNDHT)
                                : data.where((d) => selectedDates.contains(d.date)).toList(),
                            xValueMapper: (_SalesData sales, _) => sales.date,
                            yValueMapper: (_SalesData sales, _) => sales.totalRechargeTNDHT,
                            name: 'TotalRechargeTNDHT',
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
    this.nbrOptionGlobal,
    this.montantOptionGlobal,
    this.nbrDataGlobal,
    this.montantDataGlobal,
    this.totalRechargeTNDHT,
  );

  final String date;
  final int nombreRecharge;
  final int nbrOptionGlobal;
  final double montantOptionGlobal;
  final int nbrDataGlobal;
  final double montantDataGlobal;
  final double totalRechargeTNDHT;
}





