import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:my_dash/services/activation_client_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PageChartDetailedPerf extends StatefulWidget {
  final String entityName;

  const PageChartDetailedPerf({Key? key, required this.entityName})
      : super(key: key);

  @override
  _PageChartDetailedPerfState createState() => _PageChartDetailedPerfState();
}

class _PageChartDetailedPerfState extends State<PageChartDetailedPerf> {
  List<_SalesData> data = [];
  List<String> activationDateList = [];
  List<String> selectedActivationDates = [];
  List<String> transactionDateList = [];
  List<String> selectedTransactionDates = [];
  List<String> offerNames = [];
  List<String> selectedOfferNames = [];
  List<String> entityTypeNames = [];
  List<String> selectedEntityTypeNames = [];
  bool loading = true;
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString('userRole') ?? '';
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://client-data-pwya.onrender.com/get-data/?entity_name=${widget.entityName}'));
      final Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> fetchedData = responseData['data'];

      data = fetchedData.map<_SalesData>((item) {
        return _SalesData(
          item['activation_date'] ?? '',
          item['trnsaction_date'] ?? '',
          item['tmcode'] ?? 0,
          item['offer_name'] ?? '',
          item['entity_type_name'] ?? '',
          item['entity_name'] ?? '',
          item['seller_id'] ?? '',
          item['nbr_transaction'] ?? 0,
          item['nbr_activation'] ?? 0,
          item['taux_conversion_global'] ?? 0.0,
        );
      }).toList();

      activationDateList =
          data.map((salesData) => salesData.activationDate).toSet().toList();
      transactionDateList =
          data.map((salesData) => salesData.transactionDate).toSet().toList();
      offerNames =
          data.map((salesData) => salesData.offerName).toSet().toList();
      entityTypeNames =
          data.map((salesData) => salesData.entityTypeName).toSet().toList();

      // Calculate the best entity type based on sum of nbrTransaction and nbrActivation
      Map<String, int> entityTypeTransactionSum = {};
      Map<String, int> entityTypeActivationSum = {};

      for (var entry in data) {
        if (entityTypeTransactionSum.containsKey(entry.entityTypeName)) {
          entityTypeTransactionSum[entry.entityTypeName] =
              entityTypeTransactionSum[entry.entityTypeName]! +
                  entry.nbrTransaction;
        } else {
          entityTypeTransactionSum[entry.entityTypeName] = entry.nbrTransaction;
        }

        if (entityTypeActivationSum.containsKey(entry.entityTypeName)) {
          entityTypeActivationSum[entry.entityTypeName] =
              entityTypeActivationSum[entry.entityTypeName]! +
                  entry.nbrActivation;
        } else {
          entityTypeActivationSum[entry.entityTypeName] = entry.nbrActivation;
        }
      }

      String bestEntityType =
          entityTypeNames.isNotEmpty ? entityTypeNames.first : '';
      int maxTransactionSum = 0;
      int maxActivationSum = 0;

      entityTypeTransactionSum.forEach((entityType, sum) {
        if (sum > maxTransactionSum) {
          maxTransactionSum = sum;
          bestEntityType = entityType;
        }
      });

      entityTypeActivationSum.forEach((entityType, sum) {
        if (sum > maxActivationSum) {
          maxActivationSum = sum;
          bestEntityType = entityType;
        }
      });

      // Get the dates from 2024-06-20 to 2024-06-24
      List<String> initialDates = transactionDateList.where((date) {
        return date.compareTo('2024-06-20') >= 0 &&
            date.compareTo('2024-06-24') <= 0;
      }).toList();

      setState(() {
        loading = false;
        selectedActivationDates = [];
        selectedTransactionDates =
            initialDates; // Set initial dates to specified range
        selectedOfferNames = [];
        //selectedEntityTypeNames = userRole == 'restricted' ? ['FRANCHISE'] : [bestEntityType]; // Set initial entity type based on role
      });
    } catch (e) {
      print("Error loading/processing data: $e");
    }
  }

  List<_SalesData> getFilteredData() {
    return data.where((d) {
      bool activationDateCondition = selectedActivationDates.isEmpty ||
          selectedActivationDates.contains(d.activationDate);
      bool transactionDateCondition = selectedTransactionDates.isEmpty ||
          selectedTransactionDates.contains(d.transactionDate);
      bool offerCondition = selectedOfferNames.isEmpty ||
          selectedOfferNames.contains(d.offerName);
      bool entityTypeCondition = selectedEntityTypeNames.isEmpty ||
          selectedEntityTypeNames.contains(d.entityTypeName);
      return activationDateCondition &&
          transactionDateCondition &&
          offerCondition &&
          entityTypeCondition;
    }).toList();
  }

  List<_PieData> getPieChartData() {
    List<_SalesData> filteredData = getFilteredData();
    int totalTransactions = 0;
    int totalActivations = 0;

    for (var entry in filteredData) {
      totalTransactions += entry.nbrTransaction;
      totalActivations += entry.nbrActivation;
    }

    return [
      _PieData('Nbr Transaction', totalTransactions.toDouble(), Colors.blue,
          'Nbr Transaction'),
      _PieData('Nbr Activation', totalActivations.toDouble(), Colors.orange,
          'Nbr Activation'),
    ];
  }

  List<_LineData> getLineChartData() {
    List<_SalesData> filteredData = getFilteredDataByDate();
    Map<String, double> lineDataMap = {};

    for (var entry in filteredData) {
      if (lineDataMap.containsKey(entry.transactionDate)) {
        lineDataMap[entry.transactionDate] =
            lineDataMap[entry.transactionDate]! + entry.tauxConversionGlobal;
      } else {
        lineDataMap[entry.transactionDate] = entry.tauxConversionGlobal;
      }
    }

    return lineDataMap.entries.map((e) => _LineData(e.key, e.value)).toList();
  }

  List<_SalesData> getFilteredDataByDate() {
    return getFilteredData()
        .where((d) => selectedTransactionDates.contains(d.transactionDate))
        .toList();
  }

  List<_BarData> getBarChartData() {
    List<_SalesData> filteredData = getFilteredDataByDate();
    Map<String, _BarData> barDataMap = {};

    for (var entry in filteredData) {
      if (barDataMap.containsKey(entry.transactionDate)) {
        barDataMap[entry.transactionDate]!.nbrTransaction +=
            entry.nbrTransaction.toDouble();
        barDataMap[entry.transactionDate]!.nbrActivation +=
            entry.nbrActivation.toDouble();
      } else {
        barDataMap[entry.transactionDate] = _BarData(entry.transactionDate,
            entry.nbrTransaction.toDouble(), entry.nbrActivation.toDouble());
      }
    }

    return barDataMap.values.toList();
  }

  // List<_DoughnutData> getDoughnutChartData() {
  //   List<_SalesData> filteredData = getFilteredDataByDate();
  //   Map<String, double> doughnutDataMap = {};

  //   for (var entry in filteredData) {
  //     if (doughnutDataMap.containsKey(entry.transactionDate)) {
  //       doughnutDataMap[entry.transactionDate] =
  //           doughnutDataMap[entry.transactionDate]! +
  //               entry.tauxConversionGlobal;
  //     } else {
  //       doughnutDataMap[entry.transactionDate] = entry.tauxConversionGlobal;
  //     }
  //   }

  //   return doughnutDataMap.entries
  //       .map((e) => _DoughnutData(e.key, e.value))
  //       .toList();
  // }
List<_DoughnutData> getDoughnutChartData() {
  List<_SalesData> filteredData = getFilteredData();
  int totalTransactions = 0;
  int totalActivations = 0;

  for (var entry in filteredData) {
    totalTransactions += entry.nbrTransaction;
    totalActivations += entry.nbrActivation;
  }

  double conversionRate = totalActivations > 0 ? (totalActivations / totalTransactions) * 100 : 0.0;
  double noConversionRate = 100 - conversionRate;

  return [
    _DoughnutData('Conversion Rate', conversionRate, Colors.green),
    _DoughnutData('No Conversion Rate', noConversionRate, Colors.red),
  ];
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KPIs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // Add vertical scrolling
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Unselect all button
Container(
  padding: EdgeInsets.all(8.0),
  child: ElevatedButton(
    onPressed: () {
      setState(() {
        selectedActivationDates.clear();
        selectedTransactionDates.clear();
        selectedOfferNames.clear();
        selectedEntityTypeNames.clear();
      });
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.black; // Button color when pressed
        }
        return Colors.white; // Default button color
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.white; // Text color when pressed
        }
        return Colors.black; // Default text color
      }),
    ),
    child: Text(
      'Unselect all',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
                  // Transaction Dates filter
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Transaction Dates:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: transactionDateList.map((date) {
                              bool isSelected =
                                  selectedTransactionDates.contains(date);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedTransactionDates.remove(date);
                                      } else {
                                        selectedTransactionDates.add(date);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isSelected ? Colors.black : null,
                                  ),
                                  child: Text(
                                    date,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Entity type name filter
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Entity Type Name:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: entityTypeNames.map((entityTypeName) {
                              bool isSelected = selectedEntityTypeNames
                                  .contains(entityTypeName);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedEntityTypeNames
                                            .remove(entityTypeName);
                                      } else {
                                        selectedEntityTypeNames
                                            .add(entityTypeName);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isSelected ? Colors.black : null,
                                  ),
                                  child: Text(
                                    entityTypeName,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Pie Chart
                  Container(
                    height: 300, // Increase the height of the pie chart
                    child: SfCircularChart(
                      title: ChartTitle(
                        text: ' Transaction And Activation Values By Date',
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                      ),
                      series: <CircularSeries<_PieData, String>>[
                        PieSeries<_PieData, String>(
                          dataSource: getPieChartData(),
                          xValueMapper: (_PieData data, _) => data.xData,
                          yValueMapper: (_PieData data, _) => data.value,
                          dataLabelMapper: (_PieData data, _) =>
                              '${data.text}: ${data.value}',
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                              color: Colors
                                  .black, // Set the color of the data labels to black
                            ),
                          ),
                          pointColorMapper: (_PieData data, _) => data.color,
                        ),
                      ],
                    ),
                  ),
                  // Doughnut Chart
                  // Container(
                  //   height: 300,
                  //   child: SfCircularChart(
                  //     title: ChartTitle(
                  //       text: 'Conversion Rate By Date',
                  //       textStyle: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     legend: Legend(
                  //       isVisible: true,
                  //       overflowMode: LegendItemOverflowMode.wrap,
                  //     ),
                  //     series: <CircularSeries<_DoughnutData, String>>[
                  //       DoughnutSeries<_DoughnutData, String>(
                  //         dataSource: getDoughnutChartData(),
                  //         xValueMapper: (_DoughnutData data, _) => data.date,
                  //         yValueMapper: (_DoughnutData data, _) => data.value,
                  //         // dataLabelMapper: (_DoughnutData data, _) => '${data.date}: ${data.value.toStringAsFixed(2)}', // Format value to two decimal places
                  //         dataLabelMapper: (_DoughnutData data, _) =>
                  //            '${(data.value * 10).toStringAsFixed(1)}%', // '${data.date}: ${data.value.toStringAsFixed(2)}%',
                  //         dataLabelSettings: DataLabelSettings(
                  //           isVisible: true,
                  //           textStyle: TextStyle(
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
Container(
  height: 300,
  child: SfCircularChart(
    title: ChartTitle(
      text: 'Conversion Rate VS No Conversion Rate',
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    legend: Legend(
      isVisible: true,
      overflowMode: LegendItemOverflowMode.wrap,
    ),
    series: <CircularSeries<_DoughnutData, String>>[
      DoughnutSeries<_DoughnutData, String>(
        dataSource: getDoughnutChartData(),
        xValueMapper: (_DoughnutData data, _) => data.label,
        yValueMapper: (_DoughnutData data, _) => data.value,
        dataLabelMapper: (_DoughnutData data, _) => ' ${data.value.toStringAsFixed(2)}%',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        pointColorMapper: (_DoughnutData data, _) => data.color,
      ),
    ],
  ),
),
                  // Bar Chart
                  Container(
                    height: 300, // Increase the height of the bar chart
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Performance By Date'),
                      legend: Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        ColumnSeries<_BarData, String>(
                          dataSource: getBarChartData(),
                          xValueMapper: (_BarData sales, _) => sales.date,
                          yValueMapper: (_BarData sales, _) =>
                              sales.nbrTransaction,
                          name: 'Nbr Transaction',
                          color: Colors.blue,
                        ),
                        ColumnSeries<_BarData, String>(
                          dataSource: getBarChartData(),
                          xValueMapper: (_BarData sales, _) => sales.date,
                          yValueMapper: (_BarData sales, _) =>
                              sales.nbrActivation,
                          name: 'Nbr Activation',
                          color: Colors.orange,
                        ),
                        // Trend line for transactions
                        // LineSeries<_BarData, String>(
                        //   dataSource: getBarChartData(),
                        //   xValueMapper: (_BarData sales, _) => sales.date,
                        //   yValueMapper: (_BarData sales, _) => sales.nbrTransaction,
                        //   name: 'Transaction Trend',
                        //   color: Colors.green,
                        //   markerSettings: MarkerSettings(isVisible: true),
                        // ),
                        // Trend line for activations
                        // LineSeries<_BarData, String>(
                        //   dataSource: getBarChartData(),
                        //   xValueMapper: (_BarData sales, _) => sales.date,
                        //   yValueMapper: (_BarData sales, _) => sales.nbrActivation,
                        //   name: 'Activation Trend',
                        //   color: Colors.red,
                        //   markerSettings: MarkerSettings(isVisible: true),
                        // ),
                      ],
                    ),
                  ),

                  Container(
                    height: 250,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Conversion Rate By Date'),
                      primaryYAxis: NumericAxis(),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<dynamic, dynamic>>[
                        LineSeries<_LineData, String>(
                          dataSource: getLineChartData(),
                          xValueMapper: (_LineData data, _) => data.date,
                          yValueMapper: (_LineData data, _) => data.value,
                          name: ' Global Conversion Rate ',
                           color: Colors.green,
                          dataLabelMapper: (_LineData data, _) =>
                              // '${data.value.toStringAsFixed(2)}%',
                              '${(data.value * 10).toStringAsFixed(1)}%',

                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'NO Conversion Rate By Date'),
                      primaryYAxis: NumericAxis(),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<dynamic, dynamic>>[
                        LineSeries<_LineData, String>(
                          dataSource: getLineChartData(),
                          xValueMapper: (_LineData data, _) => data.date,
                          yValueMapper: (_LineData data, _) => (100-(data.value * 10)),
                          name: 'NO Conversion Rate',
                           color: Colors.red,
                          dataLabelMapper: (_LineData data, _) =>
                              // '${data.value.toStringAsFixed(2)}%',
                              '${(100-(data.value * 10)).toStringAsFixed(1)}%',

                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class _SalesData {
  _SalesData(
    this.activationDate,
    this.transactionDate,
    this.tmCode,
    this.offerName,
    this.entityTypeName,
    this.entityName,
    this.sellerId,
    this.nbrTransaction,
    this.nbrActivation,
    this.tauxConversionGlobal,
  );

  final String activationDate;
  final String transactionDate;
  final int tmCode;
  final String offerName;
  final String entityTypeName;
  final String entityName;
  final String sellerId;
  final int nbrTransaction;
  final int nbrActivation;
  final double tauxConversionGlobal;
}

class _PieData {
  _PieData(this.xData, this.value, this.color, this.text);

  final String xData;
  double value;
  final Color color;
  final String text;
}

class _BarData {
  _BarData(this.date, this.nbrTransaction, this.nbrActivation);

  final String date;
  double nbrTransaction;
  double nbrActivation;
}

// class _DoughnutData {
//   _DoughnutData(this.date, this.value);

//   final String date;
//   final double value;
// }
class _DoughnutData {
  _DoughnutData(this.label, this.value, this.color);

  final String label;
  final double value;
  final Color color;
}

class _LineData {
  _LineData(this.date, this.value);
  final String date;
  final double value;
}
