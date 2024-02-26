
// import 'package:flutter/material.dart';

// class Page2 extends StatelessWidget {
//   @override
//    Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       // Your content for Page 0
//       child: ListView.builder(
//         itemCount: 10, // Adjust the number of items as needed
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'assets/Orange_small_logo.png', // Replace with the correct asset path
//               height: 100, // Set the desired height
//               width: 100,  // Set the desired width
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fl_chart/fl_chart.dart';

// class Page2 extends StatefulWidget {
//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<Map<String, dynamic>> _peopleData = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadJsonData();
//   }

//   Future<void> _loadJsonData() async {
//     try {
//       // Load JSON from assets
//       String jsonString = await rootBundle.loadString('assets/data.json');
//       // Parse JSON
//       List<Map<String, dynamic>> peopleData = json.decode(jsonString).cast<Map<String, dynamic>>();
//       // Set state to trigger a rebuild with the loaded data
//       setState(() {
//         _peopleData = peopleData;
//       });
//     } catch (e) {
//       print("Error loading JSON data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bar Chart Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Age Distribution'),
//             SizedBox(height: 16),
//             // Display Bar Chart
//             Container(
//               height: 300,
//               width: 300,
//               child: BarChart(
//                 BarChartData(
//                   alignment: BarChartAlignment.spaceAround,
//                   groupsSpace: 12,
                 
//                   borderData: FlBorderData(
//                     show: true,
//                     border: Border.all(color: const Color(0xff37434d), width: 1),
//                   ),
//                   barGroups: _getBarGroups(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<BarChartGroupData> _getBarGroups() {
//     return List.generate(
//       _peopleData.length,
//       (index) => BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             fromY: _peopleData[index]['age']?.toDouble() ?? 0.0,
//             color: Colors.blue, toY: 1,
//           ),
//         ],
//         showingTooltipIndicators: [0],
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Event {
//   final String title;
//   final DateTime date;
//   final String description;

//   Event({
//     required this.title,
//     required this.date,
//     required this.description,
//   });

//   factory Event.fromJson(Map<String, dynamic> json) {
//     return Event(
//       title: json['title'],
//       date: DateTime.parse(json['date']),
//       description: json['description'],
//     );
//   }
// }

// class EventDataProvider {
//   Future<List<Event>> loadEvents() async {
//     try {
//       String jsonString = await rootBundle.loadString('assets/event.json');
//       List<dynamic> jsonList = json.decode(jsonString);
//       return jsonList.map((json) => Event.fromJson(json)).toList();
//     } catch (e) {
//       print("Error loading events data: $e");
//       return [];
//     }
//   }
// }

// class Page2 extends StatefulWidget {
//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<Event> events = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadEvents();
//   }

//   Future<void> _loadEvents() async {
//     final dataProvider = EventDataProvider();
//     events = await dataProvider.loadEvents();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Timeline Chart'),
//       ),
//       body: Center(
//         child: events.isNotEmpty
//             ? TimelineChart(events: events, onDateSelected: _handleDateSelected)
//             : CircularProgressIndicator(),
//       ),
//     );
//   }

//   void _handleDateSelected(DateTime selectedDate) {
//     // Handle the selected date, you can update the UI or perform any other action
//     print('Selected Date: $selectedDate');
//   }
// }

// class TimelineChart extends StatelessWidget {
//   final List<Event> events;
//   final ValueChanged<DateTime> onDateSelected;

//   TimelineChart({required this.events, required this.onDateSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SfCartesianChart(
//         primaryXAxis: CategoryAxis(),
//         primaryYAxis: NumericAxis(),
//         series: <LineSeries<Event, String>>[
//           LineSeries<Event, String>(
//             dataSource: events,
//             xValueMapper: (Event event, _) => event.title,
//             yValueMapper: (Event event, _) => event.date.day.toDouble(), // You can customize this based on your data
//             markerSettings: MarkerSettings(isVisible: true),
//             dataLabelSettings: DataLabelSettings(isVisible: true),
//             enableTooltip: true,
//           ),
//         ],
//         onPointTapped: (PointTapArgs args) {
//           final int touchedSpotIndex = args.pointIndex;
//           if (touchedSpotIndex != -1) {
//             final DateTime selectedDate = events[touchedSpotIndex].date;
//             onDateSelected(selectedDate);
//           }
//         },
//       ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:k_chart/chart_translations.dart';
// import 'package:k_chart/flutter_k_chart.dart';

// class Page2 extends StatefulWidget {
//   Page2({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<KLineEntity>? datas;
//   bool showLoading = true;
//   MainState _mainState = MainState.MA;
//   bool _volHidden = false;
//   SecondaryState _secondaryState = SecondaryState.MACD;
//   bool isLine = true;
//   bool isChinese = true;
//   bool _hideGrid = false;
//   bool _showNowPrice = true;
//   List<DepthEntity>? _bids, _asks;
//   bool isChangeUI = false;
//   bool _isTrendLine = false;
//   bool _priceLeft = true;
//   VerticalTextAlignment _verticalTextAlignment = VerticalTextAlignment.left;

//   ChartStyle chartStyle = ChartStyle();
//   ChartColors chartColors = ChartColors();

//   @override
//   void initState() {
//     super.initState();
//     getData('1day');
//     rootBundle.loadString('assets/depth.json').then((result) {
//       final parseJson = json.decode(result);
//       final tick = parseJson['tick'] as Map<String, dynamic>;
//       final List<DepthEntity> bids = (tick['bids'] as List<dynamic>)
//           .map<DepthEntity>(
//               (item) => DepthEntity(item[0] as double, item[1] as double))
//           .toList();
//       final List<DepthEntity> asks = (tick['asks'] as List<dynamic>)
//           .map<DepthEntity>(
//               (item) => DepthEntity(item[0] as double, item[1] as double))
//           .toList();
//       initDepth(bids, asks);
//     });
//   }

//   void initDepth(List<DepthEntity>? bids, List<DepthEntity>? asks) {
//     if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
//     _bids = [];
//     _asks = [];
//     double amount = 0.0;
//     bids.sort((left, right) => left.price.compareTo(right.price));
//     //累加买入委托量
//     bids.reversed.forEach((item) {
//       amount += item.vol;
//       item.vol = amount;
//       _bids!.insert(0, item);
//     });

//     amount = 0.0;
//     asks.sort((left, right) => left.price.compareTo(right.price));
//     //累加卖出委托量
//     asks.forEach((item) {
//       amount += item.vol;
//       item.vol = amount;
//       _asks!.add(item);
//     });
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: <Widget>[
//         Stack(children: <Widget>[
//           Container(
//             height: 450,
//             width: double.infinity,
//             child: KChartWidget(
//               datas,
//               chartStyle,
//               chartColors,
//               isLine: isLine,
//               onSecondaryTap: () {
//                 print('Secondary Tap');
//               },
//               isTrendLine: _isTrendLine,
//               mainState: _mainState,
//               volHidden: _volHidden,
//               secondaryState: _secondaryState,
//               fixedLength: 2,
//               timeFormat: TimeFormat.YEAR_MONTH_DAY,
//               translations: kChartTranslations,
//               showNowPrice: _showNowPrice,
//               //`isChinese` is Deprecated, Use `translations` instead.
//               isChinese: isChinese,
//               hideGrid: _hideGrid,
//               isTapShowInfoDialog: false,
//               verticalTextAlignment: _verticalTextAlignment,
//               maDayList: [1, 100, 1000],
//             ),
//           ),
//           if (showLoading)
//             Container(
//                 width: double.infinity,
//                 height: 450,
//                 alignment: Alignment.center,
//                 child: const CircularProgressIndicator()),
//         ]),
//         buildButtons(),
//         if (_bids != null && _asks != null)
//           Container(
//             height: 230,
//             width: double.infinity,
//             child: DepthChart(_bids!, _asks!, chartColors),
//           )
//       ],
//     );
//   }

//   Widget buildButtons() {
//     return Wrap(
//       alignment: WrapAlignment.spaceEvenly,
//       children: <Widget>[
//         button("Time Mode", onPressed: () => isLine = true),
//         button("K Line Mode", onPressed: () => isLine = false),
//         button("TrendLine", onPressed: () => _isTrendLine = !_isTrendLine),
//         button("Line:MA", onPressed: () => _mainState = MainState.MA),
//         button("Line:BOLL", onPressed: () => _mainState = MainState.BOLL),
//         button("Hide Line", onPressed: () => _mainState = MainState.NONE),
//         button("Secondary Chart:MACD",
//             onPressed: () => _secondaryState = SecondaryState.MACD),
//         button("Secondary Chart:KDJ",
//             onPressed: () => _secondaryState = SecondaryState.KDJ),
//         button("Secondary Chart:RSI",
//             onPressed: () => _secondaryState = SecondaryState.RSI),
//         button("Secondary Chart:WR",
//             onPressed: () => _secondaryState = SecondaryState.WR),
//         button("Secondary Chart:CCI",
//             onPressed: () => _secondaryState = SecondaryState.CCI),
//         button("Secondary Chart:Hide",
//             onPressed: () => _secondaryState = SecondaryState.NONE),
//         button(_volHidden ? "Show Vol" : "Hide Vol",
//             onPressed: () => _volHidden = !_volHidden),
//         button("Change Language", onPressed: () => isChinese = !isChinese),
//         button(_hideGrid ? "Show Grid" : "Hide Grid",
//             onPressed: () => _hideGrid = !_hideGrid),
//         button(_showNowPrice ? "Hide Now Price" : "Show Now Price",
//             onPressed: () => _showNowPrice = !_showNowPrice),
//         button("Customize UI", onPressed: () {
//           setState(() {
//             this.isChangeUI = !this.isChangeUI;
//             if (this.isChangeUI) {
//               chartColors.selectBorderColor = Colors.red;
//               chartColors.selectFillColor = Colors.red;
//               chartColors.lineFillColor = Colors.red;
//               chartColors.kLineColor = Colors.yellow;
//             } else {
//               chartColors.selectBorderColor = Color(0xff6C7A86);
//               chartColors.selectFillColor = Color(0xff0D1722);
//               chartColors.lineFillColor = Color(0x554C86CD);
//               chartColors.kLineColor = Color(0xff4C86CD);
//             }
//           });
//         }),
//         button("Change PriceTextPaint",
//             onPressed: () => setState(() {
//               _priceLeft = !_priceLeft;
//               if (_priceLeft) {
//                 _verticalTextAlignment = VerticalTextAlignment.left;
//               } else {
//                 _verticalTextAlignment = VerticalTextAlignment.right;
//               }
//             })),
//       ],
//     );
//   }

//   Widget button(String text, {VoidCallback? onPressed}) {
//     return TextButton(
//       onPressed: () {
//         if (onPressed != null) {
//           onPressed();
//           setState(() {});
//         }
//       },
//       child: Text(text),
//       style: TextButton.styleFrom(
//         primary: Colors.white,
//         minimumSize: const Size(88, 44),
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(2.0)),
//         ),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }

//   void getData(String period) {
//     /*
//      * 可以翻墙使用方法1加载数据，不可以翻墙使用方法2加载数据，默认使用方法1加载最新数据
//      */
//     final Future<String> future = getChatDataFromInternet(period);
//     //final Future<String> future = getChatDataFromJson();
//     future.then((String result) {
//       solveChatData(result);
//     }).catchError((_) {
//       showLoading = false;
//       setState(() {});
//       print('### datas error $_');
//     });
//   }

//   //获取火币数据，需要翻墙
//   Future<String> getChatDataFromInternet(String? period) async {
//     var url =
//         'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=btcusdt';
//     late String result;
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       result = response.body;
//     } else {
//       print('Failed getting IP address');
//     }
//     return result;
//   }

//   // 如果你不能翻墙，可以使用这个方法加载数据
//   Future<String> getChatDataFromJson() async {
//     return rootBundle.loadString('assets/chatData.json');
//   }

//   void solveChatData(String result) {
//     final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
//     final list = parseJson['data'] as List<dynamic>;
//     datas = list
//         .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
//         .toList()
//         .reversed
//         .toList()
//         .cast<KLineEntity>();
//     DataUtil.calculate(datas!);
//     showLoading = false;
//     setState(() {});
//   }
// }
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:k_chart/flutter_k_chart.dart';

// class Page2  extends StatefulWidget {
//   @override
//   Page2State createState() => Page2State();
// }

// class Page2State extends State<Page2> {
//   List<KLineEntity>? datas;
//   bool showLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     getData('1day');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: <Widget>[
//         Stack(
//           children: <Widget>[
//             Container(
//               height: 450,
//               width: double.infinity,
//               child: KChartWidget(
//                 datas,
//                 isLine: true,
//                 showNowPrice: true,
//                 timeFormat: TimeFormat.YEAR_MONTH_DAY,
//               ),
//             ),
//             if (showLoading)
//               Container(
//                 width: double.infinity,
//                 height: 450,
//                 alignment: Alignment.center,
//                 child: const CircularProgressIndicator(),
//               ),
//           ],
//         ),
//         buildButtons(),
//       ],
//     );
//   }

//   Widget buildButtons() {
//     return Wrap(
//       alignment: WrapAlignment.spaceEvenly,
//       children: <Widget>[
//         button("Time Mode", onPressed: () => isLine = true),
//         button("K Line Mode", onPressed: () => isLine = false),
//       ],
//     );
//   }

//   Widget button(String text, {VoidCallback? onPressed}) {
//     return TextButton(
//       onPressed: () {
//         if (onPressed != null) {
//           onPressed();
//           setState(() {});
//         }
//       },
//       child: Text(text),
//       style: TextButton.styleFrom(
//         primary: Colors.white,
//         minimumSize: const Size(88, 44),
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(2.0)),
//         ),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }

//   void getData(String period) {
//     final Future<String> future = getChatDataFromInternet(period);
//     future.then((String result) {
//       solveChatData(result);
//     }).catchError((_) {
//       showLoading = false;
//       setState(() {});
//       print('### datas error $_');
//     });
//   }

//   Future<String> getChatDataFromInternet(String? period) async {
//     var url =
//         'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=btcusdt';
//     late String result;
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       result = response.body;
//     } else {
//       print('Failed getting IP address');
//     }
//     return result;
//   }

//   void solveChatData(String result) {
//     final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
//     final list = parseJson['data'] as List<dynamic>;
//     datas = list
//         .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
//         .toList()
//         .reversed
//         .toList()
//         .cast<KLineEntity>();
//     DataUtil.calculate(datas!);
//     showLoading = false;
//     setState(() {});
//   }
// }
// import 'package:d_chart/commons/data_model.dart';
// import 'package:d_chart/ordinal/bar.dart';
// import 'package:flutter/material.dart';


// class Page2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('D\'Chart')),
//       backgroundColor: Colors.white,
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           AspectRatio(
//             aspectRatio: 16 / 9,
//             child: DChartBarO(
//               groupList: [
//                 OrdinalGroup(
//                   id: '1',
//                   data: [
//                     OrdinalData(domain: 'Mon', measure: 2),
//                     OrdinalData(domain: 'Tue', measure: 6),
//                     OrdinalData(domain: 'Wed', measure: 3),
//                     OrdinalData(domain: 'Thu', measure: 7),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:multi_charts/multi_charts.dart';

// class Page2 extends StatelessWidget {
//   final List<Widget> charts = [
//     RadarChart(
//       values: [1, 2, 4, 7, 9, 0, 6],
//       labels: [
//         "Label1",
//         "Label2",
//         "Label3",
//         "Label4",
//         "Label5",
//         "Label6",
//         "Label7",
//       ],
//       maxValue: 10,
//       fillColor: Colors.blue,
//       chartRadiusFactor: 0.7,
//     ),
//     PieChart(
//       values: [15, 10, 30, 25, 20],
//       labels: ["Label1", "Label2", "Label3", "Label4", "Label5"],
//       sliceFillColors: [
//         Colors.blueAccent,
//         Colors.greenAccent,
//         Colors.pink,
//         Colors.orange,
//         Colors.red,
//       ],
//       animationDuration: Duration(milliseconds: 1500),
//       legendPosition: LegendPosition.Right,
//     ),
//     // Add more charts as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Charts Example"),
//       ),
//       body: ListView(
//         scrollDirection: Axis.vertical,
//         children: <Widget>[
//           SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: PageView.builder(
//               itemCount: charts.length,
//               itemBuilder: (context, index) {
//                 return Center(
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height,
//                     child: charts[index],
//                   ),
//                 );
//               },
//               scrollDirection: Axis.vertical, // set the scroll direction to vertical
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:multi_charts/multi_charts.dart';

// class Page2 extends StatelessWidget {
//   final List<Map<String, String>> jsonData = [
//     {"Chiffre d'affaire": "298877", "date": "2022-03-01"},
//     {"Chiffre d'affaire": "344211", "date": "2022-03-02"},
//     {"Chiffre d'affaire": "298871", "date": "2022-03-04"},
//     {"Chiffre d'affaire": "344261", "date": "2022-03-05"},
//     {"Chiffre d'affaire": "298857", "date": "2022-03-06"}
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Charts Example"),
//       ),
//       body: ListView(
//         scrollDirection: Axis.vertical,
//         children: <Widget>[
//           SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: PieChart(
//               values: jsonData
//                   .map<int>((data) => int.parse(data["Chiffre d'affaire"]))
//                   .toList(),
//               labels: jsonData.map<String>((data) => data["date"]).toList(),
//               sliceFillColors: [
//                 Colors.blueAccent,
//                 Colors.greenAccent,
//                 Colors.pink,
//                 Colors.orange,
//                 Colors.red,
//               ],
//               animationDuration: Duration(milliseconds: 1500),
//               legendPosition: LegendPosition.Right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
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
        // Add a null check for date and Chiffre d'affaire
        String date = chartData['date'] ?? '';
        double chiffreAffaire = chartData["chiffreAffaire"] != null
            ? double.parse(chartData["chiffreAffaire"])
            : 0.0;
        return _SalesData(
          date,
          chiffreAffaire,
        );
      }).toList();

      setState(() {
        loading = false;
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
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 2, // Number of charts
              itemBuilder: (context, index) {
                return index == 0
                    ? Container(
                        // Line chart
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
                      )
                    : Container(
                        // Bar chart
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          title: ChartTitle(text: 'Bar Chart'),
                          legend: Legend(isVisible: true),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CartesianSeries<_SalesData, String>>[
                            BarSeries<_SalesData, String>(
                              dataSource: data,
                              xValueMapper: (_SalesData sales, _) => sales.date,
                              yValueMapper: (_SalesData sales, _) => sales.chiffreAffaire,
                              name: 'Chiffre d\'affaire',
                              dataLabelSettings: DataLabelSettings(isVisible: true),
                            ),
                          ],
                        ),
                      );
              },
            ),
    );
  }
}

class _SalesData {
  _SalesData(this.date, this.chiffreAffaire);

  final String date;
  final double chiffreAffaire;
}
