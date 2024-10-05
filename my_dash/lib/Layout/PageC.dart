
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart'; // Import for radial gauge
// import 'package:my_dash/services/RetrieveData_api.dart';

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
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<Fact> facts = await apiService.fetchFacts();

//       data = facts.map<_SalesData>((fact) => _SalesData(
//         fact.date,
//         fact.fkTypeRecharge == 1 ? fact.nombreRecharge : 0, // nombre Recharge global
//         fact.fkTypeRecharge == 2 ? fact.nombreRecharge : 0, // nombre Recharge digital
//         fact.nbrOptionGlobal,
//         fact.montantOptionGlobal,
//         fact.nbrDataGlobal,
//         fact.montantDataGlobal,
//         fact.totalRechargeTNDHT,
//         fact.pourcentageRechargeDigitalVsGlobal,
//       )).toList();

//       dateList = data.map((salesData) => salesData.date).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedDates = [];
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getTopData(List<_SalesData> list, double Function(_SalesData) getValue) {
//     list.sort((a, b) => getValue(b).compareTo(getValue(a)));
//     return list.take(1).toList(); // Take only the top value
//   }
//   double getMaxPourcentage(List<String> selectedDates) {
//   if (selectedDates.isEmpty) {
//     return data.fold<double>(0, (previousValue, element) =>
//         element.pourcentageRechargeDigitalVsGlobal > previousValue
//             ? element.pourcentageRechargeDigitalVsGlobal
//             : previousValue);
//   } else {
//     List<_SalesData> filteredData = data
//         .where((d) => selectedDates.contains(d.date))
//         .toList();

//     return filteredData.fold<double>(0, (previousValue, element) =>
//         element.pourcentageRechargeDigitalVsGlobal > previousValue
//             ? element.pourcentageRechargeDigitalVsGlobal
//             : previousValue);
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Global vs Digital Dashboard',
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
//                       child: SfCircularChart(
//                         title: ChartTitle(
//                           text: selectedDates.isEmpty
//                               ? ' Recharge number Global vs Digital'
//                               : 'Recharge number for ${selectedDates.join(", ")}',
//                           textStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         legend: Legend(isVisible: true),
//                         series: <CircularSeries>[
//                           PieSeries<_SalesData, String>(
//                             dataSource: getTopData(
//                               selectedDates.isEmpty
//                                   ? data
//                                   : data.where((d) => selectedDates.contains(d.date)).toList(),
//                               (d) => d.nombreRechargeGlobal.toDouble(),
//                             ),
//                             xValueMapper: (_SalesData sales, _) => 'Global recharge number',
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRechargeGlobal.toDouble(),
//                             pointColorMapper: (_SalesData sales, _) => Colors.blue,
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                           PieSeries<_SalesData, String>(
//                             dataSource: getTopData(
//                               selectedDates.isEmpty
//                                   ? data
//                                   : data.where((d) => selectedDates.contains(d.date)).toList(),
//                               (d) => d.nombreRechargeDigital.toDouble(),
//                             ),
//                             xValueMapper: (_SalesData sales, _) => 'Digital recharge number',
//                             yValueMapper: (_SalesData sales, _) => sales.nombreRechargeDigital.toDouble(),
//                             pointColorMapper: (_SalesData sales, _) => Colors.orange,
//                             dataLabelSettings: DataLabelSettings(isVisible: true),
//                           ),
//                         ],
//                       ),
//                     ),

//                     SizedBox(height: 20),

//                     Container(
//   height: 300,
//   child: Column(
//     children: [
//       Text(
//         'Recharge Digital vs Global percentage',
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       Expanded(
//         child: SfRadialGauge(
//           axes: <RadialAxis>[
//             RadialAxis(
//               minimum: 0,
//               maximum: 100,
//               startAngle: 180,
//               endAngle: 0,
//               ranges: <GaugeRange>[
//                 GaugeRange(
//                   startValue: 0,
//                   endValue: 50, // Adjust ranges as needed
//                   color: Colors.red,
//                 ),
//                 GaugeRange(
//                   startValue: 50,
//                   endValue: 100,
//                   color: Colors.green,
//                 ),
//               ],
//               pointers: <GaugePointer>[
//                 NeedlePointer(
//                   value: getMaxPourcentage(selectedDates),
//                 ),
//               ],
//               annotations: <GaugeAnnotation>[
//                 GaugeAnnotation(
//                   widget: Container(
//                     child: Text(
//                       '${getMaxPourcentage(selectedDates).toStringAsFixed(2)}%',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   angle: 0,
//                   positionFactor: 0.5,
//                 ),
//               ],
//             ),
//           ],
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
//     this.nombreRechargeGlobal,
//     this.nombreRechargeDigital,
//     this.nbrOptionGlobal,
//     this.montantOptionGlobal,
//     this.nbrDataGlobal,
//     this.montantDataGlobal,
//     this.totalRechargeTNDHT,
//     this.pourcentageRechargeDigitalVsGlobal,
//   );

//   final String date;
//   final int nombreRechargeGlobal;
//   final int nombreRechargeDigital;
//   final int nbrOptionGlobal;
//   final double montantOptionGlobal;
//   final int nbrDataGlobal;
//   final double montantDataGlobal;
//   final double totalRechargeTNDHT;
//   final double pourcentageRechargeDigitalVsGlobal;
// }
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // Import for radial gauge
import 'package:my_dash/services/RetrieveData_api.dart';

class PageC extends StatefulWidget {
  PageC({Key? key}) : super(key: key);

  @override
  PageCState createState() => PageCState();
}

class PageCState extends State<PageC> {
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

      data = facts.map<_SalesData>((fact) => _SalesData(
        fact.date,
        fact.fkTypeRecharge == 1 ? fact.nombreRecharge : 0, // nombre Recharge global
        fact.fkTypeRecharge == 2 ? fact.nombreRecharge : 0, // nombre Recharge digital
        fact.nbrOptionGlobal,
        fact.montantOptionGlobal,
        fact.nbrDataGlobal,
        fact.montantDataGlobal,
        fact.totalRechargeTNDHT,
        fact.pourcentageRechargeDigitalVsGlobal,
        fact.pourcentageNombreRechargeDigitalVsGlobal, // Added attribute
      )).toList();

      dateList = data.map((salesData) => salesData.date).toSet().toList();

      setState(() {
        loading = false;
        selectedDates = [];
      });
    } catch (e) {
      print("Error loading/processing data: $e");
    }
  }

  List<_SalesData> getTopData(List<_SalesData> list, double Function(_SalesData) getValue) {
    list.sort((a, b) => getValue(b).compareTo(getValue(a)));
    return list.take(1).toList(); // Take only the top value
  }

  double getMaxPourcentage(List<String> selectedDates) {
    if (selectedDates.isEmpty) {
      return data.fold<double>(0, (previousValue, element) =>
          element.pourcentageRechargeDigitalVsGlobal > previousValue
              ? element.pourcentageRechargeDigitalVsGlobal
              : previousValue);
    } else {
      List<_SalesData> filteredData = data
          .where((d) => selectedDates.contains(d.date))
          .toList();

      return filteredData.fold<double>(0, (previousValue, element) =>
          element.pourcentageRechargeDigitalVsGlobal > previousValue
              ? element.pourcentageRechargeDigitalVsGlobal
              : previousValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Global vs Digital Dashboard',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    
                    SizedBox(height: 20),

                    Container(
                      height: 300,
                      child: SfCircularChart(
                        title: ChartTitle(
                          text: selectedDates.isEmpty
                              ? ' Recharge number Global vs Digital'
                              : 'Recharge number for ${selectedDates.join(", ")}',
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        legend: Legend(isVisible: true),
                        series: <CircularSeries>[
                          PieSeries<_SalesData, String>(
                            dataSource: getTopData(
                              selectedDates.isEmpty
                                  ? data
                                  : data.where((d) => selectedDates.contains(d.date)).toList(),
                              (d) => d.nombreRechargeGlobal.toDouble(),
                            ),
                            xValueMapper: (_SalesData sales, _) => 'Global recharge number',
                            yValueMapper: (_SalesData sales, _) => sales.nombreRechargeGlobal.toDouble(),
                            pointColorMapper: (_SalesData sales, _) => Colors.blue,
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                          ),
                          PieSeries<_SalesData, String>(
                            dataSource: getTopData(
                              selectedDates.isEmpty
                                  ? data
                                  : data.where((d) => selectedDates.contains(d.date)).toList(),
                              (d) => d.nombreRechargeDigital.toDouble(),
                            ),
                            xValueMapper: (_SalesData sales, _) => 'Digital recharge number',
                            yValueMapper: (_SalesData sales, _) => sales.nombreRechargeDigital.toDouble(),
                            pointColorMapper: (_SalesData sales, _) => Colors.orange,
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

//                    Container(
//   height: 300,
//   padding: EdgeInsets.all(16),
//   child: SfCartesianChart(
//     primaryXAxis: CategoryAxis(),
//     title: ChartTitle(
//       text: 'Recharge Digital vs Global percentage by Date',
//       textStyle: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     legend: Legend(isVisible: true),
//     series: <CartesianSeries<dynamic, String>>[
//       LineSeries<_SalesData, String>(
//         dataSource: selectedDates.isEmpty
//             ? data
//             : data.where((d) => selectedDates.contains(d.date)).toList(),
//         xValueMapper: (_SalesData sales, _) => sales.date,
//         yValueMapper: (_SalesData sales, _) =>
//             sales.pourcentageNombreRechargeDigitalVsGlobal,
//         name: 'Digital vs Global percentage',
//         markerSettings: MarkerSettings(isVisible: true),
//       ),
//     ],
//   ),
// ),
// Container(
//   height: 300,
//   padding: EdgeInsets.all(16),
//   child: SfCartesianChart(
//     primaryXAxis: CategoryAxis(),
//     title: ChartTitle(
//       text: 'Recharge number Digital vs Global percentage by Date',
//       textStyle: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     legend: Legend(isVisible: true),
//     series: <CartesianSeries<dynamic, String>>[
//       LineSeries<_SalesData, String>(
//         dataSource: selectedDates.isEmpty
//             ? data.length > 3
//                 ? data.sublist(data.length - 3)
//                 : data
//             : data.where((d) => selectedDates.contains(d.date)).toList(),
//         xValueMapper: (_SalesData sales, _) => sales.date,
//         yValueMapper: (_SalesData sales, _) =>
//             sales.pourcentageNombreRechargeDigitalVsGlobal,
           
//         name: 'Digital vs Global percentage',
//         markerSettings: MarkerSettings(isVisible: true),
//         dataLabelSettings: DataLabelSettings(isVisible: true), // Show data labels
        
//       ),
//     ],
//   ),
// ),
Container(
  height: 300,
  padding: EdgeInsets.all(16),
  child: SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    title: ChartTitle(
      text: 'Recharge number Digital vs Global percentage by Date',
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    legend: Legend(isVisible: true),
    series: <CartesianSeries<dynamic, String>>[
      LineSeries<_SalesData, String>(
        dataSource: selectedDates.isEmpty
            ? data.length > 3
                ? data.sublist(data.length - 3)
                : data
            : data.where((d) => selectedDates.contains(d.date)).toList(),
        xValueMapper: (_SalesData sales, _) => sales.date,
        yValueMapper: (_SalesData sales, _) =>
            sales.pourcentageNombreRechargeDigitalVsGlobal,
        dataLabelMapper: (_SalesData sales, _) =>
            '${(sales.pourcentageNombreRechargeDigitalVsGlobal * 10).toStringAsFixed(2)}%', // Format as percentage
        name: 'Digital vs Global percentage',
        markerSettings: MarkerSettings(isVisible: true),
        dataLabelSettings: DataLabelSettings(isVisible: true), // Show data labels
      ),
    ],
  ),
),



                    SizedBox(height: 20),

                    Container(
                      height: 300,
                      child: Column(
                        children: [
                          Text(
                            'Total recharge Digital vs Global percentage',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  startAngle: 180,
                                  endAngle: 0,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: 0,
                                      endValue: 50, // Adjust ranges as needed
                                      color: Colors.red,
                                    ),
                                    GaugeRange(
                                      startValue: 50,
                                      endValue: 100,
                                      color: Colors.green,
                                    ),
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: getMaxPourcentage(selectedDates),
                                    ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                        child: Text(
                                          '${getMaxPourcentage(selectedDates).toStringAsFixed(2)}%',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      angle: 0,
                                      positionFactor: 0.5,
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
            ),
    );
  }
}

class _SalesData {
  _SalesData(
    this.date,
    this.nombreRechargeGlobal,
    this.nombreRechargeDigital,
    this.nbrOptionGlobal,
    this.montantOptionGlobal,
    this.nbrDataGlobal,
    this.montantDataGlobal,
    this.totalRechargeTNDHT,
    this.pourcentageRechargeDigitalVsGlobal,
    this.pourcentageNombreRechargeDigitalVsGlobal, // Added attribute
  );

  final String date;
  final int nombreRechargeGlobal;
  final int nombreRechargeDigital;
  final int nbrOptionGlobal;
  final double montantOptionGlobal;
  final int nbrDataGlobal;
  final double montantDataGlobal;
  final double totalRechargeTNDHT;
  final double pourcentageRechargeDigitalVsGlobal;
  final double pourcentageNombreRechargeDigitalVsGlobal; // New attribute
}
