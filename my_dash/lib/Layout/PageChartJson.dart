// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   List<String> selectedDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityNames = [];
//   List<String> selectedEntityNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'],
//           item['tmcode'],
//           item['offer_name'],
//           item['entity_type_name'],
//           item['entity_name'],
//           item['seller_id'],
//           item['nb_count'],
//         );
//       }).toList();

//       dateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityNames = data.map((salesData) => salesData.entityName).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedDates = [];
//         selectedOfferNames = [];
//         selectedEntityNames = [];
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool dateCondition = selectedDates.isEmpty || selectedDates.contains(d.activationDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityCondition = userRole == 'full' || d.entityName == 'Franchise Mourouj 4';
//       return dateCondition && offerCondition && entityCondition;
//     }).toList();
//   }

//   List<_SalesData> getTop5Data(List<_SalesData> list, double Function(_SalesData) getValue) {
//     list.sort((a, b) => getValue(b).compareTo(getValue(a)));
//     return list.take(5).toList();
//   }

//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text(
//         'KPIs',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//     body: loading
//         ? const Center(child: CircularProgressIndicator())
//         : Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Dates filter (unchanged)
//               Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       'Dates:',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: dateList.map((date) {
//                           bool isSelected = selectedDates.contains(date);
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   if (isSelected) {
//                                     selectedDates.remove(date);
//                                   } else {
//                                     selectedDates.add(date);
//                                   }
//                                 });
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 primary: isSelected ? Colors.black : null,
//                               ),
//                               child: Text(
//                                 date,
//                                 style: TextStyle(
//                                   color: isSelected ? Colors.white : Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Offers filter (unchanged)
//               Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       'Offers:',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: offerNames.map((offer) {
//                           bool isSelected = selectedOfferNames.contains(offer);
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   if (isSelected) {
//                                     selectedOfferNames.remove(offer);
//                                   } else {
//                                     selectedOfferNames.add(offer);
//                                   }
//                                 });
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 primary: isSelected ? Colors.black : null,
//                               ),
//                               child: Text(
//                                 offer,
//                                 style: TextStyle(
//                                   color: isSelected ? Colors.white : Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Entity name filter (conditionally shown)
//               if (userRole != 'restricted')
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Entity name:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: entityNames.map((entity) {
//                             bool isSelected = selectedEntityNames.contains(entity);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedEntityNames.remove(entity);
//                                     } else {
//                                       selectedEntityNames.add(entity);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   entity,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Charts
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Bar chart based on selected dates and selected offer names
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(
//                               text: selectedDates.isEmpty
//                                   ? 'Offer count by Seller'
//                                   : 'Bar Chart for ${selectedDates.join(", ")}',
//                             ),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 255, 115, 34),
//                                 dataSource: getFilteredData()
//                                     .where((d) => selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName))
//                                     .toList(),
//                                 xValueMapper: (_SalesData sales, _) => sales.sellerId,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbCount.toDouble(),
//                                 name: 'Offer Count',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 pointColorMapper: (_SalesData sales, _) {
//                                   double maxVal = selectedDates.isEmpty
//                                       ? data.map((d) => d.nbCount.toDouble()).reduce((a, b) => a > b ? a : b)
//                                       : data.where((d) => selectedDates.contains(d.activationDate))
//                                           .map((d) => d.nbCount.toDouble())
//                                           .reduce((a, b) => a > b ? a : b);

//                                   return sales.nbCount.toDouble() == maxVal ? Colors.red : Color.fromARGB(223, 255, 115, 34);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Line chart
//                         Container(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(text: 'Offer count by Seller'),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               LineSeries<_SalesData, String>(
//                                 dataSource: getFilteredData(),
//                                 xValueMapper: (_SalesData sales, _) => sales.sellerId,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbCount.toDouble(),
//                                 name: 'Offer Name Count',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Another bar chart based on selected dates and selected entity names
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(
//                               text: selectedDates.isEmpty
//                                   ? 'Offer count by Entity'
//                                   : 'Bar Chart for ${selectedDates.join(", ")} by Entity',
//                             ),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 61, 150, 215), // Adjust color as needed
//                                 dataSource: getFilteredData()
//                                     .where((d) => selectedEntityNames.isEmpty || selectedEntityNames.contains(d.entityName))
//                                     .toList(),
//                                 xValueMapper: (_SalesData sales, _) => sales.entityName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbCount.toDouble(),
//                                 name: 'Offer Count by Entity',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Pie chart classifying entity_name by entity_type_name
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCircularChart(
//                             title: ChartTitle(text: 'Entity Classification by Type'),
//                             legend: Legend(isVisible: true),
//                             series: <CircularSeries<_SalesData, String>>[
//                               PieSeries<_SalesData, String>(
//                                 dataSource: getEntityTypeSummary(),
//                                 xValueMapper: (_SalesData data, _) => data.entityTypeName,
//                                 yValueMapper: (_SalesData data, _) => data.nbCount.toDouble(),
//                                 dataLabelMapper: (_SalesData data, _) => data.entityTypeName,
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   List<_SalesData> getEntityTypeSummary() {
//     Map<String, int> entityTypeCounts = {};
//     for (var entry in data) {
//       entityTypeCounts.update(entry.entityTypeName, (value) => value + entry.nbCount, ifAbsent: () => entry.nbCount);
//     }
//     return entityTypeCounts.entries
//         .map((entry) => _SalesData('', 0, '', entry.key, '', '', entry.value))
//         .toList();
//   }
// }

// class _SalesData {
//   _SalesData(
//     this.activationDate,
//     this.tmcode,
//     this.offerName,
//     this.entityTypeName,
//     this.entityName,
//     this.sellerId,
//     this.nbCount,
//   );

//   final String activationDate;
//   final int tmcode;
//   final String offerName;
//   final String entityTypeName;
//   final String entityName;
//   final String sellerId;
//   final int nbCount;
// }




// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> dateList = [];
//   List<String> selectedDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityNames = [];
//   List<String> selectedEntityNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'],
//           item['tmcode'],
//           item['offer_name'],
//           item['entity_type_name'],
//           item['entity_name'],
//           item['seller_id'],
//           item['nbr_transaction'],
//         );
//       }).toList();

//       dateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityNames = data.map((salesData) => salesData.entityName).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedDates = [];
//         selectedOfferNames = [];
//         selectedEntityNames = [];
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool dateCondition = selectedDates.isEmpty || selectedDates.contains(d.activationDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityCondition = userRole == 'full' || d.entityName == 'Franchise Mourouj 4';
//       return dateCondition && offerCondition && entityCondition;
//     }).toList();
//   }

//   List<_SalesData> getTop5Data(List<_SalesData> list, double Function(_SalesData) getValue) {
//     list.sort((a, b) => getValue(b).compareTo(getValue(a)));
//     return list.take(5).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Dates filter (unchanged)
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Activation Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: dateList.map((date) {
//                             bool isSelected = selectedDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedDates.remove(date);
//                                     } else {
//                                       selectedDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
              
//                 // Entity name filter (conditionally shown)
//                 if (userRole != 'restricted')
//                   Container(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Entity name:',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 8.0),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: entityNames.map((entity) {
//                               bool isSelected = selectedEntityNames.contains(entity);
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       if (isSelected) {
//                                         selectedEntityNames.remove(entity);
//                                       } else {
//                                         selectedEntityNames.add(entity);
//                                       }
//                                     });
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: isSelected ? Colors.black : null,
//                                   ),
//                                   child: Text(
//                                     entity,
//                                     style: TextStyle(
//                                       color: isSelected ? Colors.white : Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Charts
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           // Bar chart based on selected dates and selected offer names
//                           Container(
//                             height: 300,
//                             padding: const EdgeInsets.all(8.0),
//                             child: SfCartesianChart(
//                               primaryXAxis: CategoryAxis(),
//                               title: ChartTitle(
//                                 text: selectedDates.isEmpty
//                                     ? 'Offer count by Seller'
//                                     : 'Bar Chart for ${selectedDates.join(", ")}',
//                               ),
//                               legend: Legend(isVisible: true),
//                               tooltipBehavior: TooltipBehavior(enable: true),
//                               series: <CartesianSeries<_SalesData, String>>[
//                                 BarSeries<_SalesData, String>(
//                                   color: Color.fromARGB(223, 255, 115, 34),
//                                   dataSource: getFilteredData()
//                                       .where((d) => selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName))
//                                       .toList(),
//                                   xValueMapper: (_SalesData sales, _) => sales.sellerId,
//                                   yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                   name: 'Offer Count',
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                   pointColorMapper: (_SalesData sales, _) {
//                                     double maxVal = selectedDates.isEmpty
//                                         ? data.map((d) => d.nbrTransaction.toDouble()).reduce((a, b) => a > b ? a : b)
//                                         : data.where((d) => selectedDates.contains(d.activationDate))
//                                             .map((d) => d.nbrTransaction.toDouble())
//                                             .reduce((a, b) => a > b ? a : b);

//                                     return sales.nbrTransaction.toDouble() == maxVal ? Colors.red : Color.fromARGB(223, 255, 115, 34);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Line chart
//                           Container(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SfCartesianChart(
//                               primaryXAxis: CategoryAxis(),
//                               title: ChartTitle(text: 'Offer count by Seller'),
//                               legend: Legend(isVisible: true),
//                               tooltipBehavior: TooltipBehavior(enable: true),
//                               series: <CartesianSeries<_SalesData, String>>[
//                                 LineSeries<_SalesData, String>(
//                                   dataSource: getFilteredData(),
//                                   xValueMapper: (_SalesData sales, _) => sales.sellerId,
//                                   yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                   name: 'Offer Name Count',
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Another bar chart based on selected dates and selected entity names
//                           Container(
//                             height: 300,
//                             padding: const EdgeInsets.all(8.0),
//                             child: SfCartesianChart(
//                               primaryXAxis: CategoryAxis(),
//                               title: ChartTitle(
//                                 text: selectedDates.isEmpty
//                                     ? 'Offer count by Entity'
//                                     : 'Bar Chart for ${selectedDates.join(", ")} by Entity',
//                               ),
//                               legend: Legend(isVisible: true),
//                               tooltipBehavior: TooltipBehavior(enable: true),
//                               series: <CartesianSeries<_SalesData, String>>[
//                                 BarSeries<_SalesData, String>(
//                                   color: Color.fromARGB(223, 61, 150, 215), // Adjust color as needed
//                                   dataSource: getFilteredData()
//                                       .where((d) => selectedEntityNames.isEmpty || selectedEntityNames.contains(d.entityName))
//                                       .toList(),
//                                   xValueMapper: (_SalesData sales, _) => sales.entityName,
//                                   yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                   name: 'Offer Count by Entity',
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Pie chart classifying entity_name by entity_type_name
//                           Container(
//                             height: 300,
//                             padding: const EdgeInsets.all(8.0),
//                             child: SfCircularChart(
//                               title: ChartTitle(text: 'Entity Classification by Type'),
//                               legend: Legend(isVisible: true),
//                               series: <CircularSeries<_SalesData, String>>[
//                                 PieSeries<_SalesData, String>(
//                                   dataSource: getEntityTypeSummary(),
//                                   xValueMapper: (_SalesData data, _) => data.entityTypeName,
//                                   yValueMapper: (_SalesData data, _) => data.nbrTransaction.toDouble(),
//                                   dataLabelMapper: (_SalesData data, _) => data.entityTypeName,
//                                   dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       );
//     }

//     List<_SalesData> getEntityTypeSummary() {
//       Map<String, int> entityTypeCounts = {};
//       for (var entry in data) {
//         entityTypeCounts.update(entry.entityTypeName, (value) => value + entry.nbrTransaction, ifAbsent: () => entry.nbrTransaction);
//       }
//       return entityTypeCounts.entries
//           .map((entry) => _SalesData('', 0, '', entry.key, '', '', entry.value))
//           .toList();
//     }
//   }

//   class _SalesData {
//     _SalesData(
//       this.activationDate,
//       this.tmcode,
//       this.offerName,
//       this.entityTypeName,
//       this.entityName,
//       this.sellerId,
//       this.nbrTransaction,
//     );

//     final String activationDate;
//     final int tmcode;
//     final String offerName;
//     final String entityTypeName;
//     final String entityName;
//     final String sellerId;
//     final int nbrTransaction;
//   }

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> activationDateList = [];
//   List<String> selectedActivationDates = [];
//   List<String> transactionDateList = [];
//   List<String> selectedTransactionDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityNames = [];
//   List<String> selectedEntityNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'] ?? '', // Default to empty string if null
//           item['trnsaction_date'] ?? '', // Corrected the typo and added null check
//           item['tmcode'] ?? 0, // Default to 0 if null
//           item['offer_name'] ?? '', // Default to empty string if null
//           item['entity_type_name'] ?? '', // Default to empty string if null
//           item['entity_name'] ?? '', // Default to empty string if null
//           item['seller_id'] ?? '', // Default to empty string if null
//           item['nbr_transaction'] ?? 0, // Default to 0 if null
//           item['nbr_activation'] ?? 0, // Default to 0 if null
//         );
//       }).toList();

//       activationDateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       transactionDateList = data.map((salesData) => salesData.transactionDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityNames = data.map((salesData) => salesData.entityName).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedActivationDates = [];
//         selectedTransactionDates = [];
//         selectedOfferNames = [];
//         selectedEntityNames = [];
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool activationDateCondition = selectedActivationDates.isEmpty || selectedActivationDates.contains(d.activationDate);
//       bool transactionDateCondition = selectedTransactionDates.isEmpty || selectedTransactionDates.contains(d.transactionDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityCondition = userRole == 'full' || d.entityName == 'Franchise Mourouj 4';
//       return activationDateCondition && transactionDateCondition && offerCondition && entityCondition;
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Activation Dates filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Activation Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: activationDateList.map((date) {
//                             bool isSelected = selectedActivationDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedActivationDates.remove(date);
//                                     } else {
//                                       selectedActivationDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Transaction Dates filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Transaction Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: transactionDateList.map((date) {
//                             bool isSelected = selectedTransactionDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedTransactionDates.remove(date);
//                                     } else {
//                                       selectedTransactionDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Entity name filter (conditionally shown)
//                 if (userRole != 'restricted')
//                   Container(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Entity name:',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 8.0),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: entityNames.map((entity) {
//                               bool isSelected = selectedEntityNames.contains(entity);
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       if (isSelected) {
//                                         selectedEntityNames.remove(entity);
//                                       } else {
//                                         selectedEntityNames.add(entity);
//                                       }
//                                     });
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: isSelected ? Colors.black : null,
//                                   ),
//                                   child: Text(
//                                     entity,
//                                     style: TextStyle(
//                                       color: isSelected ? Colors.white : Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 // Charts
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Bar chart based on selected dates and selected offer names
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(
//                               text: selectedActivationDates.isEmpty && selectedTransactionDates.isEmpty
//                                   ? 'Seller performance by offer count'
//                                   : 'Bar Chart for ${selectedActivationDates.join(", ")} and ${selectedTransactionDates.join(", ")}',
//                             ),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 255, 115, 34),
//                                 dataSource: getFilteredData()
//                                     .where((d) => selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName))
//                                     .toList(),
//                                 xValueMapper: (_SalesData sales, _) => sales.sellerId,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                 name: 'Offer Count',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                                 pointColorMapper: (_SalesData sales, _) {
//                                   double maxVal = selectedActivationDates.isEmpty && selectedTransactionDates.isEmpty
//                                       ? data.map((d) => d.nbrTransaction.toDouble()).reduce((a, b) => a > b ? a : b)
//                                       : getFilteredData()
//                                           .where((d) => selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName))
//                                           .map((d) => d.nbrTransaction.toDouble())
//                                           .reduce((a, b) => a > b ? a : b);
//                                   return sales.nbrTransaction.toDouble() == maxVal ? Color.fromARGB(223, 255, 115, 34) : Color.fromARGB(223, 255, 115, 34);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Bar chart for offer_name by nbr_transaction and nbr_activation
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(text: 'Performance by Offer Name'),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 61, 150, 215),
//                                 dataSource: getFilteredData(),
//                                 xValueMapper: (_SalesData sales, _) => sales.offerName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                 name: 'Transaction Count',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 34, 150, 34),
//                                 dataSource: getFilteredData(),
//                                 xValueMapper: (_SalesData sales, _) => sales.offerName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrActivation.toDouble(),
//                                 name: 'Activation Count',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Another bar chart based on selected dates and selected entity names
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(
//                               text: selectedActivationDates.isEmpty
//                                   ? 'Offer count by Entity'
//                                   : 'Bar Chart for ${selectedActivationDates.join(", ")} by Entity',
//                             ),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 61, 150, 215), // Adjust color as needed
//                                 dataSource: getFilteredData()
//                                     .where((d) => selectedEntityNames.isEmpty || selectedEntityNames.contains(d.entityName))
//                                     .toList(),
//                                 xValueMapper: (_SalesData sales, _) => sales.entityName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                 name: 'Offer Count by Entity',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Pie chart classifying entity_name by entity_type_name
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCircularChart(
//                             title: ChartTitle(text: 'Entity Classification by Type'),
//                             legend: Legend(isVisible: true),
//                             series: <CircularSeries<_SalesData, String>>[
//                               PieSeries<_SalesData, String>(
//                                 dataSource: getEntityTypeSummary(),
//                                 xValueMapper: (_SalesData data, _) => data.entityTypeName,
//                                 yValueMapper: (_SalesData data, _) => data.nbrTransaction.toDouble(),
//                                 dataLabelMapper: (_SalesData data, _) => data.entityTypeName,
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   List<_SalesData> getEntityTypeSummary() {
//     Map<String, int> entityTypeCounts = {};
//     for (var entry in data) {
//       entityTypeCounts.update(entry.entityTypeName, (value) => value + entry.nbrTransaction, ifAbsent: () => entry.nbrTransaction);
//     }
//     return entityTypeCounts.entries
//         .map((entry) => _SalesData('', '', 0, '', entry.key, '', '', entry.value, 0))
//         .toList();
//   }
// }

// class _SalesData {
//   _SalesData(
//     this.activationDate,
//     this.transactionDate,
//     this.tmcode,
//     this.offerName,
//     this.entityTypeName,
//     this.entityName,
//     this.sellerId,
//     this.nbrTransaction,
//     this.nbrActivation,
//   );

//   final String activationDate;
//   final String transactionDate;
//   final int tmcode;
//   final String offerName;
//   final String entityTypeName;
//   final String entityName;
//   final String sellerId;
//   final int nbrTransaction;
//   final int nbrActivation;
// }


// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> activationDateList = [];
//   List<String> selectedActivationDates = [];
//   List<String> transactionDateList = [];
//   List<String> selectedTransactionDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityNames = [];
//   List<String> selectedEntityNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'] ?? '', // Default to empty string if null
//           item['trnsaction_date'] ?? '', // Corrected the typo and added null check
//           item['tmcode'] ?? 0, // Default to 0 if null
//           item['offer_name'] ?? '', // Default to empty string if null
//           item['entity_type_name'] ?? '', // Default to empty string if null
//           item['entity_name'] ?? '', // Default to empty string if null
//           item['seller_id'] ?? '', // Default to empty string if null
//           item['nbr_transaction'] ?? 0, // Default to 0 if null
//           item['nbr_activation'] ?? 0, // Default to 0 if null
//         );
//       }).toList();

//       activationDateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       transactionDateList = data.map((salesData) => salesData.transactionDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityNames = data.map((salesData) => salesData.entityName).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedActivationDates = [];
//         selectedTransactionDates = [];
//         selectedOfferNames = [];
//         selectedEntityNames = [];
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool activationDateCondition = selectedActivationDates.isEmpty || selectedActivationDates.contains(d.activationDate);
//       bool transactionDateCondition = selectedTransactionDates.isEmpty || selectedTransactionDates.contains(d.transactionDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityCondition = userRole == 'full' || d.entityName == 'Franchise Mourouj 4';
//       return activationDateCondition && transactionDateCondition && offerCondition && entityCondition;
//     }).toList();
//   }

//   List<_SalesData> getFilteredDataByEntity() {
//     return getFilteredData().where((d) => selectedEntityNames.contains(d.entityName)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Transaction Dates filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Transaction Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: transactionDateList.map((date) {
//                             bool isSelected = selectedTransactionDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedTransactionDates.remove(date);
//                                     } else {
//                                       selectedTransactionDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Entity name filter (conditionally shown)
//                 if (userRole != 'restricted')
//                   Container(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Entity name:',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 8.0),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: entityNames.map((entity) {
//                               bool isSelected = selectedEntityNames.contains(entity);
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       if (isSelected) {
//                                         selectedEntityNames.remove(entity);
//                                       } else {
//                                         selectedEntityNames.add(entity);
//                                       }
//                                     });
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: isSelected ? Colors.black : null,
//                                   ),
//                                   child: Text(
//                                     entity,
//                                     style: TextStyle(
//                                       color: isSelected ? Colors.white : Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 // Charts
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Pie chart for selected entity names
//                        Container(
//   height: 300,
//   padding: const EdgeInsets.all(8.0),
//   child: SfCircularChart(
//     title: ChartTitle(
//       text: selectedEntityNames.isEmpty
//           ? 'Entity Performance'
//           : 'Performance for ${selectedEntityNames.join(", ")}',
//     ),
//     legend: Legend(isVisible: true),
//     tooltipBehavior: TooltipBehavior(enable: true),
//     series: <CircularSeries<_SalesData, String>>[
//       // Pie series for nbrTransaction
//       PieSeries<_SalesData, String>(
//         dataSource: getFilteredDataByEntity(),
//         xValueMapper: (_SalesData sales, _) => sales.entityName,
//         yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//         pointColorMapper: (_SalesData sales, _) => Color.fromARGB(223, 61, 150, 215), // Color for Transactions
//         dataLabelSettings: DataLabelSettings(isVisible: true),
//         dataLabelMapper: (_SalesData sales, _) => '${sales.entityName}: ${sales.nbrTransaction} Transactions',
//       ),
//       // Pie series for nbrActivation
//       PieSeries<_SalesData, String>(
//         dataSource: getFilteredDataByEntity(),
//         xValueMapper: (_SalesData sales, _) => sales.entityName,
//         yValueMapper: (_SalesData sales, _) => sales.nbrActivation.toDouble(),
//         pointColorMapper: (_SalesData sales, _) => Color.fromARGB(223, 255, 115, 34), // Color for Activations
//         dataLabelSettings: DataLabelSettings(isVisible: true),
//         dataLabelMapper: (_SalesData sales, _) => '${sales.entityName}: ${sales.nbrActivation} Activations',
//       ),
//     ],
//   ),
// ),

//                         // Bar chart for offer_name by nbr_transaction and nbr_activation
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(text: 'Performance by Offer Name'),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 61, 150, 215),
//                                 dataSource: getFilteredData(),
//                                 xValueMapper: (_SalesData sales, _) => sales.offerName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                 name: 'Transaction Count',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 34, 150, 34),
//                                 dataSource: getFilteredData(),
//                                 xValueMapper: (_SalesData sales, _) => sales.offerName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrActivation.toDouble(),
//                                 name: 'Activation Count',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Another bar chart based on selected dates and selected entity names
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(
//                               text: selectedTransactionDates.isEmpty
//                                   ? 'Offer count by Entity'
//                                   : 'Bar Chart for ${selectedTransactionDates.join(", ")} by Entity',
//                             ),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 61, 150, 215), // Adjust color as needed
//                                 dataSource: getFilteredData()
//                                     .where((d) => selectedEntityNames.isEmpty || selectedEntityNames.contains(d.entityName))
//                                     .toList(),
//                                 xValueMapper: (_SalesData sales, _) => sales.entityName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                 name: 'Offer Count by Entity',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Pie chart classifying entity_name by entity_type_name
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCircularChart(
//                             title: ChartTitle(text: 'Entity Classification by Type'),
//                             legend: Legend(isVisible: true),
//                             series: <CircularSeries<_SalesData, String>>[
//                               PieSeries<_SalesData, String>(
//                                 dataSource: getEntityTypeSummary(),
//                                 xValueMapper: (_SalesData data, _) => data.entityTypeName,
//                                 yValueMapper: (_SalesData data, _) => data.nbrTransaction.toDouble(),
//                                 dataLabelMapper: (_SalesData data, _) => data.entityTypeName,
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   List<_SalesData> getEntityTypeSummary() {
//     Map<String, int> entityTypeCounts = {};
//     for (var entry in data) {
//       entityTypeCounts.update(entry.entityTypeName, (value) => value + entry.nbrTransaction, ifAbsent: () => entry.nbrTransaction);
//     }
//     return entityTypeCounts.entries
//         .map((entry) => _SalesData('', '', 0, '', entry.key, '', '', entry.value, 0))
//         .toList();
//   }
// }

// class _SalesData {
//   _SalesData(
//     this.activationDate,
//     this.transactionDate,
//     this.tmcode,
//     this.offerName,
//     this.entityTypeName,
//     this.entityName,
//     this.sellerId,
//     this.nbrTransaction,
//     this.nbrActivation,
//   );

//   final String activationDate;
//   final String transactionDate;
//   final int tmcode;
//   final String offerName;
//   final String entityTypeName;
//   final String entityName;
//   final String sellerId;
//   final int nbrTransaction;
//   final int nbrActivation;
// }



// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> activationDateList = [];
//   List<String> selectedActivationDates = [];
//   List<String> transactionDateList = [];
//   List<String> selectedTransactionDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityNames = [];
//   List<String> selectedEntityNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'] ?? '', // Default to empty string if null
//           item['trnsaction_date'] ?? '', // Corrected the typo and added null check
//           item['tmcode'] ?? 0, // Default to 0 if null
//           item['offer_name'] ?? '', // Default to empty string if null
//           item['entity_type_name'] ?? '', // Default to empty string if null
//           item['entity_name'] ?? '', // Default to empty string if null
//           item['seller_id'] ?? '', // Default to empty string if null
//           item['nbr_transaction'] ?? 0, // Default to 0 if null
//           item['nbr_activation'] ?? 0, // Default to 0 if null
//         );
//       }).toList();

//       activationDateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       transactionDateList = data.map((salesData) => salesData.transactionDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityNames = data.map((salesData) => salesData.entityName).toSet().toList();

//       setState(() {
//         loading = false;
//         selectedActivationDates = [];
//         selectedTransactionDates = [];
//         selectedOfferNames = [];
//         selectedEntityNames = [];
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool activationDateCondition = selectedActivationDates.isEmpty || selectedActivationDates.contains(d.activationDate);
//       bool transactionDateCondition = selectedTransactionDates.isEmpty || selectedTransactionDates.contains(d.transactionDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityCondition = userRole == 'full' || d.entityName == 'Franchise Mourouj 4';
//       return activationDateCondition && transactionDateCondition && offerCondition && entityCondition;
//     }).toList();
//   }

//   List<_SalesData> getFilteredDataByEntity() {
//     return getFilteredData().where((d) => selectedEntityNames.contains(d.entityName)).toList();
//   }

//   List<_PieData> getPieChartData() {
//     List<_SalesData> filteredData = getFilteredDataByEntity();
//     List<_PieData> pieData = [];

//     for (var entry in filteredData) {
//       pieData.add(_PieData('${entry.entityName} Transactions', entry.nbrTransaction.toDouble(), Colors.blue));
//       pieData.add(_PieData('${entry.entityName} Activations', entry.nbrActivation.toDouble(), Colors.orange));
//     }

//     return pieData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Transaction Dates filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Transaction Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: transactionDateList.map((date) {
//                             bool isSelected = selectedTransactionDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedTransactionDates.remove(date);
//                                     } else {
//                                       selectedTransactionDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Entity name filter (conditionally shown)
//                 if (userRole != 'restricted')
//                   Container(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Entity name:',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 8.0),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: entityNames.map((entity) {
//                               bool isSelected = selectedEntityNames.contains(entity);
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       if (isSelected) {
//                                         selectedEntityNames.remove(entity);
//                                       } else {
//                                         selectedEntityNames.add(entity);
//                                       }
//                                     });
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: isSelected ? Colors.black : null,
//                                   ),
//                                   child: Text(
//                                     entity,
//                                     style: TextStyle(
//                                       color: isSelected ? Colors.white : Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 // Charts
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Pie chart for selected entity names
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCircularChart(
//                             title: ChartTitle(
//                               text: selectedEntityNames.isEmpty
//                                   ? 'Entity Performance'
//                                   : 'Performance for ${selectedEntityNames.join(", ")}',
//                             ),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CircularSeries<_PieData, String>>[
//                               PieSeries<_PieData, String>(
//                                 dataSource: getPieChartData(),
//                                 xValueMapper: (_PieData data, _) => data.entityName,
//                                 yValueMapper: (_PieData data, _) => data.value,
//                                 pointColorMapper: (_PieData data, _) => data.color,
//                                 dataLabelMapper: (_PieData data, _) => '${data.entityName}: ${data.value}',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Bar chart for offer_name by nbr_transaction and nbr_activation
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCartesianChart(
//                             primaryXAxis: CategoryAxis(),
//                             title: ChartTitle(text: 'Performance by Offer Name'),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CartesianSeries<_SalesData, String>>[
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(223, 61, 150, 215),
//                                 dataSource: getFilteredData(),
//                                 xValueMapper: (_SalesData sales, _) => sales.offerName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                                 name: 'Nbr Transaction',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                               BarSeries<_SalesData, String>(
//                                 color: Color.fromARGB(191, 239, 94, 19),
//                                 dataSource: getFilteredData(),
//                                 xValueMapper: (_SalesData sales, _) => sales.offerName,
//                                 yValueMapper: (_SalesData sales, _) => sales.nbrActivation.toDouble(),
//                                 name: 'Nbr Activation',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.activationDate, this.transactionDate, this.tmcode, this.offerName, this.entityTypeName, this.entityName, this.sellerId, this.nbrTransaction, this.nbrActivation);
//   final String activationDate;
//   final String transactionDate;
//   final int tmcode;
//   final String offerName;
//   final String entityTypeName;
//   final String entityName;
//   final String sellerId;
//   final int nbrTransaction;
//   final int nbrActivation;
// }

// class _PieData {
//   _PieData(this.entityName, this.value, this.color);
//   final String entityName;
//   final double value;
//   final Color color;
// }


// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> activationDateList = [];
//   List<String> selectedActivationDates = [];
//   List<String> transactionDateList = [];
//   List<String> selectedTransactionDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityNames = [];
//   List<String> selectedEntityNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'] ?? '',
//           item['trnsaction_date'] ?? '',
//           item['tmcode'] ?? 0,
//           item['offer_name'] ?? '',
//           item['entity_type_name'] ?? '',
//           item['entity_name'] ?? '',
//           item['seller_id'] ?? '',
//           item['nbr_transaction'] ?? 0,
//           item['nbr_activation'] ?? 0,
//         );
//       }).toList();

//       activationDateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       transactionDateList = data.map((salesData) => salesData.transactionDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityNames = data.map((salesData) => salesData.entityName).toSet().toList();

//       // Calculate the best entity based on sum of nbrTransaction and nbrActivation
//       Map<String, int> entityTransactionSum = {};
//       Map<String, int> entityActivationSum = {};

//       for (var entry in data) {
//         if (entityTransactionSum.containsKey(entry.entityName)) {
//           entityTransactionSum[entry.entityName] = entityTransactionSum[entry.entityName]! + entry.nbrTransaction;
//         } else {
//           entityTransactionSum[entry.entityName] = entry.nbrTransaction;
//         }

//         if (entityActivationSum.containsKey(entry.entityName)) {
//           entityActivationSum[entry.entityName] = entityActivationSum[entry.entityName]! + entry.nbrActivation;
//         } else {
//           entityActivationSum[entry.entityName] = entry.nbrActivation;
//         }
//       }

//       String bestEntity = entityNames.isNotEmpty ? entityNames.first : '';
//       int maxTransactionSum = 0;
//       int maxActivationSum = 0;

//       entityTransactionSum.forEach((entity, sum) {
//         if (sum > maxTransactionSum) {
//           maxTransactionSum = sum;
//           bestEntity = entity;
//         }
//       });

//       entityActivationSum.forEach((entity, sum) {
//         if (sum > maxActivationSum) {
//           maxActivationSum = sum;
//           bestEntity = entity;
//         }
//       });

//       // Get the dates from 2024-06-20 to 2024-06-24
//       List<String> initialDates = transactionDateList.where((date) {
//         return date.compareTo('2024-06-20') >= 0 && date.compareTo('2024-06-24') <= 0;
//       }).toList();

//       setState(() {
//         loading = false;
//         selectedActivationDates = [];
//         selectedTransactionDates = initialDates; // Set initial dates to specified range
//         selectedOfferNames = [];
//         selectedEntityNames = userRole == 'restricted' ? ['Franchise Mourouj 4'] : [bestEntity]; // Set initial entity based on role
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool activationDateCondition = selectedActivationDates.isEmpty || selectedActivationDates.contains(d.activationDate);
//       bool transactionDateCondition = selectedTransactionDates.isEmpty || selectedTransactionDates.contains(d.transactionDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityCondition = userRole == 'full' || d.entityName == 'Franchise Mourouj 4';
//       return activationDateCondition && transactionDateCondition && offerCondition && entityCondition;
//     }).toList();
//   }

//   List<_SalesData> getFilteredDataByEntity() {
//     return getFilteredData().where((d) => selectedEntityNames.contains(d.entityName)).toList();
//   }

//   List<_PieData> getPieChartData() {
//     List<_SalesData> filteredData = getFilteredDataByEntity();
//     Map<String, _PieData> pieDataMap = {};

//     for (var entry in filteredData) {
//       String transactionKey = '${entry.entityName}_Transaction';
//       String activationKey = '${entry.entityName}_Activation';

//       if (pieDataMap.containsKey(transactionKey)) {
//         pieDataMap[transactionKey]!.value += entry.nbrTransaction;
//       } else {
//         pieDataMap[transactionKey] = _PieData(entry.entityName, entry.nbrTransaction.toDouble(), Colors.blue, 'Nbr Transaction');
//       }

//       if (pieDataMap.containsKey(activationKey)) {
//         pieDataMap[activationKey]!.value += entry.nbrActivation;
//       } else {
//         pieDataMap[activationKey] = _PieData(entry.entityName, entry.nbrActivation.toDouble(), Colors.orange, 'Nbr Activation');
//       }
//     }

//     return pieDataMap.values.toList();
//   }

//   List<_SalesData> getFilteredDataByDate() {
//     return getFilteredData().where((d) => selectedTransactionDates.contains(d.transactionDate)).toList();
//   }

//   List<_LineData> getLineChartData() {
//     List<_SalesData> filteredData = getFilteredDataByDate();
//     List<_LineData> lineData = [];

//     for (var entry in filteredData) {
//       lineData.add(_LineData(entry.transactionDate, entry.nbrTransaction.toDouble(), entry.nbrActivation.toDouble()));
//     }

//     return lineData;
//   }

//   // List<_BarData> getBarChartData() {
//   //   List<_SalesData> filteredData = getFilteredDataByDate();
//   //   Map<String, _BarData> barDataMap = {};

//   //   for (var entry in filteredData) {
//   //     if (barDataMap.containsKey(entry.transactionDate)) {
//   //       barDataMap[entry.transactionDate]!.nbrTransaction += entry.nbrTransaction.toDouble();
//   //       barDataMap[entry.transactionDate]!.nbrActivation += entry.nbrActivation.toDouble();
//   //     } else {
//   //       barDataMap[entry.transactionDate] = _BarData(entry.transactionDate, entry.nbrTransaction.toDouble(), entry.nbrActivation.toDouble());
//   //     }
//   //   }

//   //   return barDataMap.values.toList();
//   // }
// List<_BarData> getBarChartData() {
//   List<_SalesData> filteredData = getFilteredDataByDate();
//   filteredData = filteredData.where((d) => selectedEntityNames.contains(d.entityName)).toList();
//   Map<String, _BarData> barDataMap = {};

//   for (var entry in filteredData) {
//     if (barDataMap.containsKey(entry.transactionDate)) {
//       barDataMap[entry.transactionDate]!.nbrTransaction += entry.nbrTransaction.toDouble();
//       barDataMap[entry.transactionDate]!.nbrActivation += entry.nbrActivation.toDouble();
//     } else {
//       barDataMap[entry.transactionDate] = _BarData(entry.transactionDate, entry.nbrTransaction.toDouble(), entry.nbrActivation.toDouble());
//     }
//   }

//   return barDataMap.values.toList();
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Transaction Dates filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Transaction Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: transactionDateList.map((date) {
//                             bool isSelected = selectedTransactionDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedTransactionDates.remove(date);
//                                     } else {
//                                       selectedTransactionDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Entity name filter (conditionally shown)
//                 if (userRole != 'restricted')
//                   Container(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Entity name:',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 8.0),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: entityNames.map((entity) {
//                               bool isSelected = selectedEntityNames.contains(entity);
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       if (isSelected) {
//                                         selectedEntityNames.remove(entity);
//                                       } else {
//                                         selectedEntityNames.add(entity);
//                                       }
//                                     });
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: isSelected ? Colors.black : null,
//                                   ),
//                                   child: Text(
//                                     entity,
//                                     style: TextStyle(
//                                       color: isSelected ? Colors.white : Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 // Filtered data display
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Pie chart for entity performance
//                         Container(
//                           height: 300,
//                           padding: const EdgeInsets.all(8.0),
//                           child: SfCircularChart(
//                             title: ChartTitle(
//                               text: selectedEntityNames.isEmpty
//                                   ? 'Entity Performance'
//                                   : 'Performance for ${selectedEntityNames.join(", ")}',
//                             ),
//                             legend: Legend(isVisible: true),
//                             tooltipBehavior: TooltipBehavior(enable: true),
//                             series: <CircularSeries<_PieData, String>>[
//                               PieSeries<_PieData, String>(
//                                 dataSource: getPieChartData(),
//                                 xValueMapper: (_PieData data, _) => '${data.entityName} - ${data.type}',
//                                 yValueMapper: (_PieData data, _) => data.value,
//                                 pointColorMapper: (_PieData data, _) => data.color,
//                                 dataLabelMapper: (_PieData data, _) => '${data.entityName} (${data.type}): ${data.value}',
//                                 dataLabelSettings: DataLabelSettings(isVisible: true),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Bar chart for offer_name by nbr_transaction and nbr_activation
//                         // Container(
//                         //   height: 300,
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: SfCartesianChart(
//                         //     primaryXAxis: CategoryAxis(),
//                         //     title: ChartTitle(text: 'Performance by Offer Name'),
//                         //     legend: Legend(isVisible: true),
//                         //     tooltipBehavior: TooltipBehavior(enable: true),
//                         //     series: <CartesianSeries<_SalesData, String>>[
//                         //       BarSeries<_SalesData, String>(
//                         //         color: Color.fromARGB(223, 61, 150, 215),
//                         //         dataSource: getFilteredData(),
//                         //         xValueMapper: (_SalesData sales, _) => sales.offerName,
//                         //         yValueMapper: (_SalesData sales, _) => sales.nbrTransaction.toDouble(),
//                         //         name: 'Nbr Transaction',
//                         //         dataLabelSettings: DataLabelSettings(isVisible: true),
//                         //       ),
//                         //       BarSeries<_SalesData, String>(
//                         //         color: Color.fromARGB(191, 239, 94, 19),
//                         //         dataSource: getFilteredData(),
//                         //         xValueMapper: (_SalesData sales, _) => sales.offerName,
//                         //         yValueMapper: (_SalesData sales, _) => sales.nbrActivation.toDouble(),
//                         //         name: 'Nbr Activation',
//                         //         dataLabelSettings: DataLabelSettings(isVisible: true),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                         // Combined bar and line chart for nbrTransaction and nbrActivation by date
//                         Container(
//   height: 300,
//   padding: const EdgeInsets.all(8.0),
//   child: SfCartesianChart(
//     primaryXAxis: CategoryAxis(),
//     title: ChartTitle(text: 'Performance by Date'),
//     legend: Legend(isVisible: true),
//     tooltipBehavior: TooltipBehavior(enable: true),
//     series: <CartesianSeries<_BarData, String>>[
//       ColumnSeries<_BarData, String>(
//         dataSource: getBarChartData(),
//         xValueMapper: (_BarData data, _) => data.date,
//         yValueMapper: (_BarData data, _) => data.nbrTransaction,
//         name: 'Nbr Transaction',
//         dataLabelSettings: DataLabelSettings(isVisible: true),
//       ),
//       ColumnSeries<_BarData, String>(
//         dataSource: getBarChartData(),
//         xValueMapper: (_BarData data, _) => data.date,
//         yValueMapper: (_BarData data, _) => data.nbrActivation,
//         name: 'Nbr Activation',
//         dataLabelSettings: DataLabelSettings(isVisible: true),
//       ),
//       LineSeries<_BarData, String>(
//         dataSource: getBarChartData(),
//         xValueMapper: (_BarData data, _) => data.date,
//         yValueMapper: (_BarData data, _) {
//           return (data.nbrTransaction + data.nbrActivation) / 2; // Adjust as per your data structure
//         },
//         name: 'Trend',
//         markerSettings: MarkerSettings(isVisible: true),
//       ),
//     ],
//   ),
// ),

//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(this.activationDate, this.transactionDate, this.tmcode, this.offerName, this.entityTypeName, this.entityName, this.sellerId, this.nbrTransaction, this.nbrActivation);
//   final String activationDate;
//   final String transactionDate;
//   final int tmcode;
//   final String offerName;
//   final String entityTypeName;
//   final String entityName;
//   final String sellerId;
//   final int nbrTransaction;
//   final int nbrActivation;
// }

// class _PieData {
//   _PieData(this.entityName, this.value, this.color, this.type);
//   final String entityName;
//   double value;
//   final Color color;
//   final String type;
// }

// class _LineData {
//   _LineData(this.transactionDate, this.nbrTransaction, this.nbrActivation)
//       : value = (nbrTransaction + nbrActivation).toDouble();
//   final String transactionDate;
//   final double nbrTransaction;
//   final double nbrActivation;
//   final double value;
// }

// class _BarData {
//   _BarData(this.date, this.nbrTransaction, this.nbrActivation)
//       : sum = nbrTransaction + nbrActivation;
//   final String date;
//   double nbrTransaction;
//   double nbrActivation;
//   final double sum;
// }

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> activationDateList = [];
//   List<String> selectedActivationDates = [];
//   List<String> transactionDateList = [];
//   List<String> selectedTransactionDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityTypeNames = [];
//   List<String> selectedEntityTypeNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'] ?? '',
//           item['trnsaction_date'] ?? '',
//           item['tmcode'] ?? 0,
//           item['offer_name'] ?? '',
//           item['entity_type_name'] ?? '',
//           item['entity_name'] ?? '',
//           item['seller_id'] ?? '',
//           item['nbr_transaction'] ?? 0,
//           item['nbr_activation'] ?? 0,
//         );
//       }).toList();

//       activationDateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       transactionDateList = data.map((salesData) => salesData.transactionDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityTypeNames = data.map((salesData) => salesData.entityTypeName).toSet().toList();

//       // Calculate the best entity type based on sum of nbrTransaction and nbrActivation
//       Map<String, int> entityTypeTransactionSum = {};
//       Map<String, int> entityTypeActivationSum = {};

//       for (var entry in data) {
//         if (entityTypeTransactionSum.containsKey(entry.entityTypeName)) {
//           entityTypeTransactionSum[entry.entityTypeName] = entityTypeTransactionSum[entry.entityTypeName]! + entry.nbrTransaction;
//         } else {
//           entityTypeTransactionSum[entry.entityTypeName] = entry.nbrTransaction;
//         }

//         if (entityTypeActivationSum.containsKey(entry.entityTypeName)) {
//           entityTypeActivationSum[entry.entityTypeName] = entityTypeActivationSum[entry.entityTypeName]! + entry.nbrActivation;
//         } else {
//           entityTypeActivationSum[entry.entityTypeName] = entry.nbrActivation;
//         }
//       }

//       String bestEntityType = entityTypeNames.isNotEmpty ? entityTypeNames.first : '';
//       int maxTransactionSum = 0;
//       int maxActivationSum = 0;

//       entityTypeTransactionSum.forEach((entityType, sum) {
//         if (sum > maxTransactionSum) {
//           maxTransactionSum = sum;
//           bestEntityType = entityType;
//         }
//       });

//       entityTypeActivationSum.forEach((entityType, sum) {
//         if (sum > maxActivationSum) {
//           maxActivationSum = sum;
//           bestEntityType = entityType;
//         }
//       });

//       // Get the dates from 2024-06-20 to 2024-06-24
//       List<String> initialDates = transactionDateList.where((date) {
//         return date.compareTo('2024-06-20') >= 0 && date.compareTo('2024-06-24') <= 0;
//       }).toList();

//       setState(() {
//         loading = false;
//         selectedActivationDates = [];
//         selectedTransactionDates = initialDates; // Set initial dates to specified range
//         selectedOfferNames = [];
//         selectedEntityTypeNames = userRole == 'restricted' ? ['FRANCHISE'] : [bestEntityType]; // Set initial entity type based on role
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool activationDateCondition = selectedActivationDates.isEmpty || selectedActivationDates.contains(d.activationDate);
//       bool transactionDateCondition = selectedTransactionDates.isEmpty || selectedTransactionDates.contains(d.transactionDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityTypeCondition = selectedEntityTypeNames.isEmpty || selectedEntityTypeNames.contains(d.entityTypeName);
//       return activationDateCondition && transactionDateCondition && offerCondition && entityTypeCondition;
//     }).toList();
//   }

//   List<_PieData> getPieChartData() {
//     List<_SalesData> filteredData = getFilteredData();
//     Map<String, _PieData> pieDataMap = {};

//     for (var entry in filteredData) {
//       String transactionKey = '${entry.entityTypeName}_Transaction';
//       String activationKey = '${entry.entityTypeName}_Activation';

//       if (pieDataMap.containsKey(transactionKey)) {
//         pieDataMap[transactionKey]!.value += entry.nbrTransaction;
//       } else {
//         pieDataMap[transactionKey] = _PieData(entry.entityTypeName, entry.nbrTransaction.toDouble(), Colors.blue, 'Nbr Transaction');
//       }

//       if (pieDataMap.containsKey(activationKey)) {
//         pieDataMap[activationKey]!.value += entry.nbrActivation;
//       } else {
//         pieDataMap[activationKey] = _PieData(entry.entityTypeName, entry.nbrActivation.toDouble(), Colors.orange, 'Nbr Activation');
//       }
//     }

//     return pieDataMap.values.toList();
//   }

//   List<_SalesData> getFilteredDataByDate() {
//     return getFilteredData().where((d) => selectedTransactionDates.contains(d.transactionDate)).toList();
//   }

//   List<_BarData> getBarChartData() {
//     List<_SalesData> filteredData = getFilteredDataByDate();
//     Map<String, _BarData> barDataMap = {};

//     for (var entry in filteredData) {
//       if (barDataMap.containsKey(entry.transactionDate)) {
//         barDataMap[entry.transactionDate]!.nbrTransaction += entry.nbrTransaction.toDouble();
//         barDataMap[entry.transactionDate]!.nbrActivation += entry.nbrActivation.toDouble();
//       } else {
//         barDataMap[entry.transactionDate] = _BarData(entry.transactionDate, entry.nbrTransaction.toDouble(), entry.nbrActivation.toDouble());
//       }
//     }

//     return barDataMap.values.toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Transaction Dates filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Transaction Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: transactionDateList.map((date) {
//                             bool isSelected = selectedTransactionDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedTransactionDates.remove(date);
//                                     } else {
//                                       selectedTransactionDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Entity type name filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Entity Type Name:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: entityTypeNames.map((entityType) {
//                             bool isSelected = selectedEntityTypeNames.contains(entityType);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedEntityTypeNames.remove(entityType);
//                                     } else {
//                                       selectedEntityTypeNames.add(entityType);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   entityType,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Pie Chart
//                 Expanded(
//                   child: SfCircularChart(
//                     title: ChartTitle(text: 'Performance by Entity Type'),
//                     legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
//                     series: <CircularSeries>[
//                       PieSeries<_PieData, String>(
//                         dataSource: getPieChartData(),
//                         pointColorMapper: (_PieData data, _) => data.color,
//                         xValueMapper: (_PieData data, _) => '${data.label} (${data.category})',
//                         yValueMapper: (_PieData data, _) => data.value,
//                         dataLabelMapper: (_PieData data, _) => '${data.label} (${data.category})',
//                         dataLabelSettings: const DataLabelSettings(isVisible: true),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Bar Chart
//                 Expanded(
//                   child: SfCartesianChart(
//                     primaryXAxis: CategoryAxis(),
//                     title: ChartTitle(text: 'Performance by Date'),
//                     legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
//                     tooltipBehavior: TooltipBehavior(enable: true),
//                     series: <CartesianSeries>[
//                       ColumnSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrTransaction,
//                         name: 'Nbr Transaction',
//                         color: Colors.blue,
//                       ),
//                       ColumnSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrActivation,
//                         name: 'Nbr Activation',
//                         color: Colors.orange,
//                       ),
//                       // Trend line for transactions
//                       LineSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrTransaction,
//                         name: 'Transaction Trend',
//                         color: Colors.green,
//                         markerSettings: MarkerSettings(isVisible: true),
//                       ),
//                       // Trend line for activations
//                       LineSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrActivation,
//                         name: 'Activation Trend',
//                         color: Colors.red,
//                         markerSettings: MarkerSettings(isVisible: true),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// class _SalesData {
//   final String activationDate;
//   final String transactionDate;
//   final int tmcode;
//   final String offerName;
//   final String entityTypeName;
//   final String entityName;
//   final String sellerId;
//   final int nbrTransaction;
//   final int nbrActivation;

//   _SalesData(
//     this.activationDate,
//     this.transactionDate,
//     this.tmcode,
//     this.offerName,
//     this.entityTypeName,
//     this.entityName,
//     this.sellerId,
//     this.nbrTransaction,
//     this.nbrActivation,
//   );
// }

// class _PieData {
//   final String label;
//   double value;
//   final Color color;
//   final String category;

//   _PieData(this.label, this.value, this.color, this.category);
// }

// class _BarData {
//   final String date;
//   double nbrTransaction;
//   double nbrActivation;

//   _BarData(this.date, this.nbrTransaction, this.nbrActivation);
// }

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> activationDateList = [];
//   List<String> selectedActivationDates = [];
//   List<String> transactionDateList = [];
//   List<String> selectedTransactionDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityTypeNames = [];
//   List<String> selectedEntityTypeNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'] ?? '',
//           item['trnsaction_date'] ?? '',
//           item['tmcode'] ?? 0,
//           item['offer_name'] ?? '',
//           item['entity_type_name'] ?? '',
//           item['entity_name'] ?? '',
//           item['seller_id'] ?? '',
//           item['nbr_transaction'] ?? 0,
//           item['nbr_activation'] ?? 0,
//         );
//       }).toList();

//       activationDateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       transactionDateList = data.map((salesData) => salesData.transactionDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityTypeNames = data.map((salesData) => salesData.entityTypeName).toSet().toList();

//       // Calculate the best entity type based on sum of nbrTransaction and nbrActivation
//       Map<String, int> entityTypeTransactionSum = {};
//       Map<String, int> entityTypeActivationSum = {};

//       for (var entry in data) {
//         if (entityTypeTransactionSum.containsKey(entry.entityTypeName)) {
//           entityTypeTransactionSum[entry.entityTypeName] = entityTypeTransactionSum[entry.entityTypeName]! + entry.nbrTransaction;
//         } else {
//           entityTypeTransactionSum[entry.entityTypeName] = entry.nbrTransaction;
//         }

//         if (entityTypeActivationSum.containsKey(entry.entityTypeName)) {
//           entityTypeActivationSum[entry.entityTypeName] = entityTypeActivationSum[entry.entityTypeName]! + entry.nbrActivation;
//         } else {
//           entityTypeActivationSum[entry.entityTypeName] = entry.nbrActivation;
//         }
//       }

//       String bestEntityType = entityTypeNames.isNotEmpty ? entityTypeNames.first : '';
//       int maxTransactionSum = 0;
//       int maxActivationSum = 0;

//       entityTypeTransactionSum.forEach((entityType, sum) {
//         if (sum > maxTransactionSum) {
//           maxTransactionSum = sum;
//           bestEntityType = entityType;
//         }
//       });

//       entityTypeActivationSum.forEach((entityType, sum) {
//         if (sum > maxActivationSum) {
//           maxActivationSum = sum;
//           bestEntityType = entityType;
//         }
//       });

//       // Get the dates from 2024-06-20 to 2024-06-24
//       List<String> initialDates = transactionDateList.where((date) {
//         return date.compareTo('2024-06-20') >= 0 && date.compareTo('2024-06-24') <= 0;
//       }).toList();

//       setState(() {
//         loading = false;
//         selectedActivationDates = [];
//         selectedTransactionDates = initialDates; // Set initial dates to specified range
//         selectedOfferNames = [];
//         //selectedEntityTypeNames = userRole == 'restricted' ? ['FRANCHISE'] : [bestEntityType]; // Set initial entity type based on role
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool activationDateCondition = selectedActivationDates.isEmpty || selectedActivationDates.contains(d.activationDate);
//       bool transactionDateCondition = selectedTransactionDates.isEmpty || selectedTransactionDates.contains(d.transactionDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityTypeCondition = selectedEntityTypeNames.isEmpty || selectedEntityTypeNames.contains(d.entityTypeName);
//       return activationDateCondition && transactionDateCondition && offerCondition && entityTypeCondition;
//     }).toList();
//   }

//   List<_PieData> getPieChartData() {
//     List<_SalesData> filteredData = getFilteredData();
//     int totalTransactions = 0;
//     int totalActivations = 0;

//     for (var entry in filteredData) {
//       totalTransactions += entry.nbrTransaction;
//       totalActivations += entry.nbrActivation;
//     }

//     return [
//       _PieData('Nbr Transaction', totalTransactions.toDouble(), Colors.blue, 'Nbr Transaction'),
//       _PieData('Nbr Activation', totalActivations.toDouble(), Colors.orange, 'Nbr Activation'),
//     ];
//   }

//   List<_SalesData> getFilteredDataByDate() {
//     return getFilteredData().where((d) => selectedTransactionDates.contains(d.transactionDate)).toList();
//   }

//   List<_BarData> getBarChartData() {
//     List<_SalesData> filteredData = getFilteredDataByDate();
//     Map<String, _BarData> barDataMap = {};

//     for (var entry in filteredData) {
//       if (barDataMap.containsKey(entry.transactionDate)) {
//         barDataMap[entry.transactionDate]!.nbrTransaction += entry.nbrTransaction.toDouble();
//         barDataMap[entry.transactionDate]!.nbrActivation += entry.nbrActivation.toDouble();
//       } else {
//         barDataMap[entry.transactionDate] = _BarData(entry.transactionDate, entry.nbrTransaction.toDouble(), entry.nbrActivation.toDouble());
//       }
//     }

//     return barDataMap.values.toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Transaction Dates filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Transaction Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: transactionDateList.map((date) {
//                             bool isSelected = selectedTransactionDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedTransactionDates.remove(date);
//                                     } else {
//                                       selectedTransactionDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Entity type name filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Entity Type Name:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: entityTypeNames.map((entityTypeName) {
//                             bool isSelected = selectedEntityTypeNames.contains(entityTypeName);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedEntityTypeNames.remove(entityTypeName);
//                                     } else {
//                                       selectedEntityTypeNames.add(entityTypeName);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   entityTypeName,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
               
//                 Expanded(
//   child: Container(
//     height: 600, // Increase the height of the pie chart
//     child: SfCircularChart(
//       title: ChartTitle(
//         text: 'Nbr Transaction and Activation',
//         textStyle: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//       legend: Legend(
//         isVisible: true,
//         overflowMode: LegendItemOverflowMode.wrap,
//       ),
//       series: <CircularSeries<_PieData, String>>[
//         PieSeries<_PieData, String>(
//           dataSource: getPieChartData(),
//           xValueMapper: (_PieData data, _) => data.xData,
//           yValueMapper: (_PieData data, _) => data.value,
//           dataLabelMapper: (_PieData data, _) => '${data.text}: ${data.value}',
//           dataLabelSettings: DataLabelSettings(
//             isVisible: true,
//             textStyle: TextStyle(
//               color: Colors.black, // Set the color of the data labels to black
//             ),
//           ),
//           pointColorMapper: (_PieData data, _) => data.color,
//         ),
//       ],
//     ),
//   ),
// ),
          
//                 // Bar Chart
//                 Expanded(
//                   child: SfCartesianChart(
//                     primaryXAxis: CategoryAxis(),
//                     title: ChartTitle(text: 'Performance by Date'),
//                     legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
//                     tooltipBehavior: TooltipBehavior(enable: true),
//                     series: <CartesianSeries>[
//                       ColumnSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrTransaction,
//                         name: 'Nbr Transaction',
//                         color: Colors.blue,
//                       ),
//                       ColumnSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrActivation,
//                         name: 'Nbr Activation',
//                         color: Colors.orange,
//                       ),
//                       // Trend line for transactions
//                       LineSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrTransaction,
//                         name: 'Transaction Trend',
//                         color: Colors.green,
//                         markerSettings: MarkerSettings(isVisible: true),
//                       ),
//                       // Trend line for activations
//                       LineSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrActivation,
//                         name: 'Activation Trend',
//                         color: Colors.red,
//                         markerSettings: MarkerSettings(isVisible: true),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(
//     this.activationDate,
//     this.transactionDate,
//     this.tmCode,
//     this.offerName,
//     this.entityTypeName,
//     this.entityName,
//     this.sellerId,
//     this.nbrTransaction,
//     this.nbrActivation,
//   );

//   final String activationDate;
//   final String transactionDate;
//   final int tmCode;
//   final String offerName;
//   final String entityTypeName;
//   final String entityName;
//   final String sellerId;
//   final int nbrTransaction;
//   final int nbrActivation;
// }

// class _PieData {
//   _PieData(this.xData, this.value, this.color, this.text);

//   final String xData;
//   double value;
//   final Color color;
//   final String text;
// }

// class _BarData {
//   _BarData(this.date, this.nbrTransaction, this.nbrActivation);

//   final String date;
//   double nbrTransaction;
//   double nbrActivation;
// }
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:my_dash/services/activation_client_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key}) : super(key: key);

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<_SalesData> data = [];
//   List<String> activationDateList = [];
//   List<String> selectedActivationDates = [];
//   List<String> transactionDateList = [];
//   List<String> selectedTransactionDates = [];
//   List<String> offerNames = [];
//   List<String> selectedOfferNames = [];
//   List<String> entityTypeNames = [];
//   List<String> selectedEntityTypeNames = [];
//   bool loading = true;
//   String userRole = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   Future<void> _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('userRole') ?? '';
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       ApiService apiService = ApiService();
//       List<dynamic> fetchedData = await apiService.fetchData();

//       data = fetchedData.map<_SalesData>((item) {
//         return _SalesData(
//           item['activation_date'] ?? '',
//           item['trnsaction_date'] ?? '',
//           item['tmcode'] ?? 0,
//           item['offer_name'] ?? '',
//           item['entity_type_name'] ?? '',
//           item['entity_name'] ?? '',
//           item['seller_id'] ?? '',
//           item['nbr_transaction'] ?? 0,
//           item['nbr_activation'] ?? 0,
//           item['taux_conversion_global'] ?? 0.0,
//         );
//       }).toList();

//       activationDateList = data.map((salesData) => salesData.activationDate).toSet().toList();
//       transactionDateList = data.map((salesData) => salesData.transactionDate).toSet().toList();
//       offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
//       entityTypeNames = data.map((salesData) => salesData.entityTypeName).toSet().toList();

//       // Calculate the best entity type based on sum of nbrTransaction and nbrActivation
//       Map<String, int> entityTypeTransactionSum = {};
//       Map<String, int> entityTypeActivationSum = {};

//       for (var entry in data) {
//         if (entityTypeTransactionSum.containsKey(entry.entityTypeName)) {
//           entityTypeTransactionSum[entry.entityTypeName] = entityTypeTransactionSum[entry.entityTypeName]! + entry.nbrTransaction;
//         } else {
//           entityTypeTransactionSum[entry.entityTypeName] = entry.nbrTransaction;
//         }

//         if (entityTypeActivationSum.containsKey(entry.entityTypeName)) {
//           entityTypeActivationSum[entry.entityTypeName] = entityTypeActivationSum[entry.entityTypeName]! + entry.nbrActivation;
//         } else {
//           entityTypeActivationSum[entry.entityTypeName] = entry.nbrActivation;
//         }
//       }

//       String bestEntityType = entityTypeNames.isNotEmpty ? entityTypeNames.first : '';
//       int maxTransactionSum = 0;
//       int maxActivationSum = 0;

//       entityTypeTransactionSum.forEach((entityType, sum) {
//         if (sum > maxTransactionSum) {
//           maxTransactionSum = sum;
//           bestEntityType = entityType;
//         }
//       });

//       entityTypeActivationSum.forEach((entityType, sum) {
//         if (sum > maxActivationSum) {
//           maxActivationSum = sum;
//           bestEntityType = entityType;
//         }
//       });

//       // Get the dates from 2024-06-20 to 2024-06-24
//       List<String> initialDates = transactionDateList.where((date) {
//         return date.compareTo('2024-06-20') >= 0 && date.compareTo('2024-06-24') <= 0;
//       }).toList();

//       setState(() {
//         loading = false;
//         selectedActivationDates = [];
//         selectedTransactionDates = initialDates; // Set initial dates to specified range
//         selectedOfferNames = [];
//         //selectedEntityTypeNames = userRole == 'restricted' ? ['FRANCHISE'] : [bestEntityType]; // Set initial entity type based on role
//       });
//     } catch (e) {
//       print("Error loading/processing data: $e");
//     }
//   }

//   List<_SalesData> getFilteredData() {
//     return data.where((d) {
//       bool activationDateCondition = selectedActivationDates.isEmpty || selectedActivationDates.contains(d.activationDate);
//       bool transactionDateCondition = selectedTransactionDates.isEmpty || selectedTransactionDates.contains(d.transactionDate);
//       bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
//       bool entityTypeCondition = selectedEntityTypeNames.isEmpty || selectedEntityTypeNames.contains(d.entityTypeName);
//       return activationDateCondition && transactionDateCondition && offerCondition && entityTypeCondition;
//     }).toList();
//   }

//   List<_PieData> getPieChartData() {
//     List<_SalesData> filteredData = getFilteredData();
//     int totalTransactions = 0;
//     int totalActivations = 0;

//     for (var entry in filteredData) {
//       totalTransactions += entry.nbrTransaction;
//       totalActivations += entry.nbrActivation;
//     }

//     return [
//       _PieData('Nbr Transaction', totalTransactions.toDouble(), Colors.blue, 'Nbr Transaction'),
//       _PieData('Nbr Activation', totalActivations.toDouble(), Colors.orange, 'Nbr Activation'),
//     ];
//   }

//   List<_SalesData> getFilteredDataByDate() {
//     return getFilteredData().where((d) => selectedTransactionDates.contains(d.transactionDate)).toList();
//   }

//   List<_BarData> getBarChartData() {
//     List<_SalesData> filteredData = getFilteredDataByDate();
//     Map<String, _BarData> barDataMap = {};

//     for (var entry in filteredData) {
//       if (barDataMap.containsKey(entry.transactionDate)) {
//         barDataMap[entry.transactionDate]!.nbrTransaction += entry.nbrTransaction.toDouble();
//         barDataMap[entry.transactionDate]!.nbrActivation += entry.nbrActivation.toDouble();
//       } else {
//         barDataMap[entry.transactionDate] = _BarData(entry.transactionDate, entry.nbrTransaction.toDouble(), entry.nbrActivation.toDouble());
//       }
//     }

//     return barDataMap.values.toList();
//   }

//   List<_DoughnutData> getDoughnutChartData() {
//     List<_SalesData> filteredData = getFilteredDataByDate();
//     Map<String, double> doughnutDataMap = {};

//     for (var entry in filteredData) {
//       if (doughnutDataMap.containsKey(entry.transactionDate)) {
//         doughnutDataMap[entry.transactionDate] = doughnutDataMap[entry.transactionDate]! + entry.tauxConversionGlobal;
//       } else {
//         doughnutDataMap[entry.transactionDate] = entry.tauxConversionGlobal;
//       }
//     }

//     return doughnutDataMap.entries.map((e) => _DoughnutData(e.key, e.value)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'KPIs',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Transaction Dates filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Transaction Dates:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: transactionDateList.map((date) {
//                             bool isSelected = selectedTransactionDates.contains(date);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedTransactionDates.remove(date);
//                                     } else {
//                                       selectedTransactionDates.add(date);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   date,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Entity type name filter
//                 Container(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Entity Type Name:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: entityTypeNames.map((entityTypeName) {
//                             bool isSelected = selectedEntityTypeNames.contains(entityTypeName);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if (isSelected) {
//                                       selectedEntityTypeNames.remove(entityTypeName);
//                                     } else {
//                                       selectedEntityTypeNames.add(entityTypeName);
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: isSelected ? Colors.black : null,
//                                 ),
//                                 child: Text(
//                                   entityTypeName,
//                                   style: TextStyle(
//                                     color: isSelected ? Colors.white : Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Pie Chart
//                 Expanded(
//                   child: Container(
//                     height: 600, // Increase the height of the pie chart
//                     child: SfCircularChart(
//                       title: ChartTitle(
//                         text: 'Nbr Transaction and Activation',
//                         textStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       legend: Legend(
//                         isVisible: true,
//                         overflowMode: LegendItemOverflowMode.wrap,
//                       ),
//                       series: <CircularSeries<_PieData, String>>[
//                         PieSeries<_PieData, String>(
//                           dataSource: getPieChartData(),
//                           xValueMapper: (_PieData data, _) => data.xData,
//                           yValueMapper: (_PieData data, _) => data.value,
//                           dataLabelMapper: (_PieData data, _) => '${data.text}: ${data.value}',
//                           dataLabelSettings: DataLabelSettings(
//                             isVisible: true,
//                             textStyle: TextStyle(
//                               color: Colors.black, // Set the color of the data labels to black
//                             ),
//                           ),
//                           pointColorMapper: (_PieData data, _) => data.color,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Doughnut Chart
//                 Expanded(
//                   child: SfCircularChart(
//                     title: ChartTitle(
//                       text: 'Taux Conversion Global by Date',
//                       textStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     legend: Legend(
//                       isVisible: true,
//                       overflowMode: LegendItemOverflowMode.wrap,
//                     ),
//                     series: <CircularSeries<_DoughnutData, String>>[
//                       DoughnutSeries<_DoughnutData, String>(
//                         dataSource: getDoughnutChartData(),
//                         xValueMapper: (_DoughnutData data, _) => data.date,
//                         yValueMapper: (_DoughnutData data, _) => data.value,
//                         dataLabelMapper: (_DoughnutData data, _) => '${data.date}: ${data.value}',
//                         dataLabelSettings: DataLabelSettings(
//                           isVisible: true,
//                           textStyle: TextStyle(
//                             color: Colors.black, // Set the color of the data labels to black
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Bar Chart
//                 Expanded(
//                   child: SfCartesianChart(
//                     primaryXAxis: CategoryAxis(),
//                     title: ChartTitle(text: 'Performance by Date'),
//                     legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
//                     tooltipBehavior: TooltipBehavior(enable: true),
//                     series: <CartesianSeries>[
//                       ColumnSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrTransaction,
//                         name: 'Nbr Transaction',
//                         color: Colors.blue,
//                       ),
//                       ColumnSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrActivation,
//                         name: 'Nbr Activation',
//                         color: Colors.orange,
//                       ),
//                       // Trend line for transactions
//                       LineSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrTransaction,
//                         name: 'Transaction Trend',
//                         color: Colors.green,
//                         markerSettings: MarkerSettings(isVisible: true),
//                       ),
//                       // Trend line for activations
//                       LineSeries<_BarData, String>(
//                         dataSource: getBarChartData(),
//                         xValueMapper: (_BarData sales, _) => sales.date,
//                         yValueMapper: (_BarData sales, _) => sales.nbrActivation,
//                         name: 'Activation Trend',
//                         color: Colors.red,
//                         markerSettings: MarkerSettings(isVisible: true),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// class _SalesData {
//   _SalesData(
//     this.activationDate,
//     this.transactionDate,
//     this.tmCode,
//     this.offerName,
//     this.entityTypeName,
//     this.entityName,
//     this.sellerId,
//     this.nbrTransaction,
//     this.nbrActivation,
//     this.tauxConversionGlobal,
//   );

//   final String activationDate;
//   final String transactionDate;
//   final int tmCode;
//   final String offerName;
//   final String entityTypeName;
//   final String entityName;
//   final String sellerId;
//   final int nbrTransaction;
//   final int nbrActivation;
//   final double tauxConversionGlobal;
// }

// class _PieData {
//   _PieData(this.xData, this.value, this.color, this.text);

//   final String xData;
//   double value;
//   final Color color;
//   final String text;
// }

// class _BarData {
//   _BarData(this.date, this.nbrTransaction, this.nbrActivation);

//   final String date;
//   double nbrTransaction;
//   double nbrActivation;
// }

// class _DoughnutData {
//   _DoughnutData(this.date, this.value);

//   final String date;
//   final double value;
// }
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:my_dash/services/activation_client_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  Page2State createState() => Page2State();
}

class Page2State extends State<Page2> {
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
      ApiService apiService = ApiService();
      List<dynamic> fetchedData = await apiService.fetchData();

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

      activationDateList = data.map((salesData) => salesData.activationDate).toSet().toList();
      transactionDateList = data.map((salesData) => salesData.transactionDate).toSet().toList();
      offerNames = data.map((salesData) => salesData.offerName).toSet().toList();
      entityTypeNames = data.map((salesData) => salesData.entityTypeName).toSet().toList();

      // Calculate the best entity type based on sum of nbrTransaction and nbrActivation
      Map<String, int> entityTypeTransactionSum = {};
      Map<String, int> entityTypeActivationSum = {};

      for (var entry in data) {
        if (entityTypeTransactionSum.containsKey(entry.entityTypeName)) {
          entityTypeTransactionSum[entry.entityTypeName] = entityTypeTransactionSum[entry.entityTypeName]! + entry.nbrTransaction;
        } else {
          entityTypeTransactionSum[entry.entityTypeName] = entry.nbrTransaction;
        }

        if (entityTypeActivationSum.containsKey(entry.entityTypeName)) {
          entityTypeActivationSum[entry.entityTypeName] = entityTypeActivationSum[entry.entityTypeName]! + entry.nbrActivation;
        } else {
          entityTypeActivationSum[entry.entityTypeName] = entry.nbrActivation;
        }
      }

      String bestEntityType = entityTypeNames.isNotEmpty ? entityTypeNames.first : '';
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
        return date.compareTo('2024-06-20') >= 0 && date.compareTo('2024-06-24') <= 0;
      }).toList();

      setState(() {
        loading = false;
        selectedActivationDates = [];
        selectedTransactionDates = initialDates; // Set initial dates to specified range
        selectedOfferNames = [];
        //selectedEntityTypeNames = userRole == 'restricted' ? ['FRANCHISE'] : [bestEntityType]; // Set initial entity type based on role
      });
    } catch (e) {
      print("Error loading/processing data: $e");
    }
  }

  List<_SalesData> getFilteredData() {
    return data.where((d) {
      bool activationDateCondition = selectedActivationDates.isEmpty || selectedActivationDates.contains(d.activationDate);
      bool transactionDateCondition = selectedTransactionDates.isEmpty || selectedTransactionDates.contains(d.transactionDate);
      bool offerCondition = selectedOfferNames.isEmpty || selectedOfferNames.contains(d.offerName);
      bool entityTypeCondition = selectedEntityTypeNames.isEmpty || selectedEntityTypeNames.contains(d.entityTypeName);
      return activationDateCondition && transactionDateCondition && offerCondition && entityTypeCondition;
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
      _PieData('Nbr Transaction', totalTransactions.toDouble(), Colors.blue, 'Nbr Transaction'),
      _PieData('Nbr Activation', totalActivations.toDouble(), Colors.orange, 'Nbr Activation'),
    ];
  }

  List<_SalesData> getFilteredDataByDate() {
    return getFilteredData().where((d) => selectedTransactionDates.contains(d.transactionDate)).toList();
  }

  List<_BarData> getBarChartData() {
    List<_SalesData> filteredData = getFilteredDataByDate();
    Map<String, _BarData> barDataMap = {};

    for (var entry in filteredData) {
      if (barDataMap.containsKey(entry.transactionDate)) {
        barDataMap[entry.transactionDate]!.nbrTransaction += entry.nbrTransaction.toDouble();
        barDataMap[entry.transactionDate]!.nbrActivation += entry.nbrActivation.toDouble();
      } else {
        barDataMap[entry.transactionDate] = _BarData(entry.transactionDate, entry.nbrTransaction.toDouble(), entry.nbrActivation.toDouble());
      }
    }

    return barDataMap.values.toList();
  }

  List<_DoughnutData> getDoughnutChartData() {
    List<_SalesData> filteredData = getFilteredDataByDate();
    Map<String, double> doughnutDataMap = {};

    for (var entry in filteredData) {
      if (doughnutDataMap.containsKey(entry.transactionDate)) {
        doughnutDataMap[entry.transactionDate] = doughnutDataMap[entry.transactionDate]! + entry.tauxConversionGlobal;
      } else {
        doughnutDataMap[entry.transactionDate] = entry.tauxConversionGlobal;
      }
    }

    return doughnutDataMap.entries.map((e) => _DoughnutData(e.key, e.value)).toList();
  }
List<_LineData> getLineChartData() {
  List<_SalesData> filteredData = getFilteredDataByDate();
  Map<String, double> lineDataMap = {};

  for (var entry in filteredData) {
    if (lineDataMap.containsKey(entry.transactionDate)) {
      lineDataMap[entry.transactionDate] = lineDataMap[entry.transactionDate]! + entry.tauxConversionGlobal;
    } else {
      lineDataMap[entry.transactionDate] = entry.tauxConversionGlobal;
    }
  }

  return lineDataMap.entries.map((e) => _LineData(e.key, e.value)).toList();
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
          : SingleChildScrollView( // Add vertical scrolling
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                              bool isSelected = selectedTransactionDates.contains(date);
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                                    primary: isSelected ? Colors.black : null,
                                  ),
                                  child: Text(
                                    date,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
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
                              bool isSelected = selectedEntityTypeNames.contains(entityTypeName);
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedEntityTypeNames.remove(entityTypeName);
                                      } else {
                                        selectedEntityTypeNames.add(entityTypeName);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: isSelected ? Colors.black : null,
                                  ),
                                  child: Text(
                                    entityTypeName,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
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
                          dataLabelMapper: (_PieData data, _) => '${data.text}: ${data.value}',
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                              color: Colors.black, // Set the color of the data labels to black
                            ),
                          ),
                          pointColorMapper: (_PieData data, _) => data.color,
                        ),
                      ],
                    ),
                  ),
                  // Doughnut Chart
                 Container(
  height: 300,
  child: SfCircularChart(
    title: ChartTitle(
      text: 'Conversion Rate By Date',
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
        xValueMapper: (_DoughnutData data, _) => data.date,
        yValueMapper: (_DoughnutData data, _) => data.value,
        // dataLabelMapper: (_DoughnutData data, _) => '${data.date}: ${data.value.toStringAsFixed(2)}', // Format value to two decimal places
        dataLabelMapper: (_DoughnutData data, _) => '${data.date}: ${data.value.toStringAsFixed(2)}%',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            color: Colors.black,
          ),
        ),
       
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
                      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        ColumnSeries<_BarData, String>(
                          dataSource: getBarChartData(),
                          xValueMapper: (_BarData sales, _) => sales.date,
                          yValueMapper: (_BarData sales, _) => sales.nbrTransaction,
                          name: 'Nbr Transaction',
                          color: Colors.blue,
                        ),
                        ColumnSeries<_BarData, String>(
                          dataSource: getBarChartData(),
                          xValueMapper: (_BarData sales, _) => sales.date,
                          yValueMapper: (_BarData sales, _) => sales.nbrActivation,
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
        name: 'Taux Conversion Global',
        dataLabelMapper: (_LineData data, _) => '${data.value.toStringAsFixed(2)}%',
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

class _DoughnutData {
  _DoughnutData(this.date, this.value);

  final String date;
  final double value;
}
class _LineData {
  _LineData(this.date, this.value);
  final String date;
  final double value;
}
