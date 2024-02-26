// page3.dart
// import 'package:flutter/material.dart';

// class Page3 extends StatelessWidget {
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
// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';



// /// My app class to display the date range picker
// class Page3 extends StatefulWidget {
//   @override
//   Page3State createState() => Page3State();
// }

// /// State for MyApp
// class Page3State extends State<Page3> {
//   String _selectedDate = '';
//   String _dateCount = '';
//   String _range = '';
//   String _rangeCount = '';

//   /// The method for [DateRangePickerSelectionChanged] callback, which will be
//   /// called whenever a selection changed on the date picker widget.
//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     /// The argument value will return the changed date as [DateTime] when the
//     /// widget [SfDateRangeSelectionMode] set as single.
//     ///
//     /// The argument value will return the changed dates as [List<DateTime>]
//     /// when the widget [SfDateRangeSelectionMode] set as multiple.
//     ///
//     /// The argument value will return the changed range as [PickerDateRange]
//     /// when the widget [SfDateRangeSelectionMode] set as range.
//     ///
//     /// The argument value will return the changed ranges as
//     /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
//     /// multi range.
//     setState(() {
//       if (args.value is PickerDateRange) {
//         _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
//             // ignore: lines_longer_than_80_chars
//             ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
//       } else if (args.value is DateTime) {
//         _selectedDate = args.value.toString();
//       } else if (args.value is List<DateTime>) {
//         _dateCount = args.value.length.toString();
//       } else {
//         _rangeCount = args.value.length.toString();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text('DatePicker demo'),
//             ),
//             body: Stack(
//               children: <Widget>[
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   top: 0,
//                   height: 80,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Selected date: $_selectedDate'),
//                       Text('Selected date count: $_dateCount'),
//                       Text('Selected range: $_range'),
//                       Text('Selected ranges count: $_rangeCount')
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   top: 80,
//                   right: 0,
//                   bottom: 0,
//                   child: SfDateRangePicker(
//                     onSelectionChanged: _onSelectionChanged,
//                     selectionMode: DateRangePickerSelectionMode.range,
//                     initialSelectedRange: PickerDateRange(
//                         DateTime.now().subtract(const Duration(days: 4)),
//                         DateTime.now().add(const Duration(days: 3))),
//                   ),
//                 )
//               ],
//             )));
//   }
// }

// import 'package:date_time_picker_widget/date_time_picker_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// class Page3  extends StatefulWidget {
//   const Page3 ({super.key, required this.title});
//   final String title;
//   @override
//   Page3State createState() => Page3State();
// }
// class Page3State extends State<Page3> {
//   Color _color = Colors.white;
//   String _d1 = '', _d2 = '';
//   String _t1 = '', _t2 = '';
//   bool _material3 = true;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: _color,
//           primary: _color,
//           secondary: _color,
//         ),
//         useMaterial3: _material3,
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const SizedBox(height: 24),
//                   CheckboxListTile(
//                     value: _material3,
//                     title: Text(
//                       'Use Material 3',
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         _material3 = value ?? true;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     'Color Pallet',
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
                  
//                   const SizedBox(height: 24),
//                   const Divider(),
//                   const SizedBox(height: 24),
                 
//                   const Divider(),
//                   const SizedBox(height: 24),
//                   _datePicker(),
//                   const SizedBox(height: 24),
//                   const Divider(),
//                   const SizedBox(height: 24),
                  
//                   const Divider(),
//                   const SizedBox(height: 24),
//                   _newDatetimePicker(),

//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _newDatetimePicker(){
//     final dt = DateTime.now();
//     final dtMin = DateTime.now().add(const Duration(hours: 1, minutes: 0));
//     final dtMax = dtMin.add(const Duration(
//       days: 4,
//     ));
//     debugPrint('dt: ${dt.toString()}');
//     debugPrint('dtMin: ${dtMin.toString()}');
//     debugPrint('dtMax: ${dtMax.toString()}');

//     return Container(
//         child: DateTimePicker(
//           initialSelectedDate: dtMin,
//           startDate: dtMin,
//           //.subtract(const Duration(days: 1)),
//           endDate: dtMax,
//           startTime: dt,
//           endTime: dtMax,
//           timeInterval: const Duration(minutes: 15),
//           datePickerTitle: 'Pick your preferred date',
//           timePickerTitle: 'Pick your preferred time',
//           timeOutOfRangeError: 'Sorry shop is closed now',
//           is24h: false,
//           numberOfWeeksToDisplay: 1,
//           locale: 'es',
//           customStringWeekdays: const ['D', 'L', 'M', 'X', 'J', 'V', 'S'],
//           onDateChanged: (date) {
//             setState(() {
//               _d1 = DateFormat('dd MMM, yyyy').format(date);
//             });
//           },
//           onTimeChanged: (time) {
//             setState(() {
//               _t1 = DateFormat('hh:mm:ss aa').format(time);
//             });
//           },
//         ) 
//     );
//   }

//   Widget _datePicker() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'Date Picker',
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'Date: $_d2',
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyMedium,
//         ),
//         const SizedBox(height: 16),
//         DateTimePicker(
//           type: DateTimePickerType.Date,
//           onDateChanged: (date) {
//             setState(() {
//               _d2 = DateFormat('dd MMM, yyyy').format(date);
//             });
//           },
//         )
//       ],
//     );
//   }
// }
// import 'package:calendar_timeline/calendar_timeline.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class Page3 extends StatefulWidget {
//   const Page3({Key? key}) : super(key: key);

//   @override
//   State<Page3> createState() => Page3State();
// }

// class Page3State extends State<Page3> {
//   late DateTime _selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     _resetSelectedDate();
//   }

//   void _resetSelectedDate() {
//     _selectedDate = DateTime.now();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 255, 255, 255),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             CalendarTimeline(
//               showYears: true,
//               initialDate: _selectedDate,
//               firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)), // 5 years ago
//               lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
//               onDateSelected: (date) => setState(() => _selectedDate = date),
//               leftMargin: 20,
//               monthColor: const Color.fromARGB(179, 0, 0, 0),
//               dayColor: const Color.fromARGB(179, 0, 0, 0),
//               dayNameColor: const Color.fromARGB(179, 0, 0, 0),
//               activeDayColor: const Color.fromARGB(179, 0, 0, 0),
//               activeBackgroundDayColor: Colors.redAccent[100],
//               dotsColor: const Color(0xFF333A47),
//               selectableDayPredicate: (date) {
//                 final fiveYearsAgo = DateTime.now().subtract(const Duration(days: 365 * 5));
//                 return date.isAfter(fiveYearsAgo) && date.day != 23;
//               },
//               locale: 'en',
//             ),
//             const SizedBox(height: 20),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 16),
//             //   child: TextButton(
//             //     style: ButtonStyle(
//             //       backgroundColor: MaterialStateProperty.all(Colors.teal[200]),
//             //     ),
//             //     child: const Text(
//             //       'RESET',
//             //       style: TextStyle(color: Color(0xFF333A47)),
//             //     ),
//             //     onPressed: () => setState(() => _resetSelectedDate()),
//             //   ),
//             // ),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 'Selected date is $_selectedDate',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => Page3State();
}

class Page3State extends State<Page3> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CalendarTimeline(
              showYears: true,
              initialDate: _selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)), // 5 years ago
              lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
              onDateSelected: (date) => setState(() => _selectedDate = date),
              leftMargin: 20,
              monthColor: const Color.fromARGB(179, 0, 0, 0),
              dayColor: const Color.fromARGB(179, 0, 0, 0),
              dayNameColor: const Color.fromARGB(179, 0, 0, 0),
              activeDayColor: const Color.fromARGB(179, 0, 0, 0),
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: const Color(0xFF333A47),
              selectableDayPredicate: (date) {
                final fiveYearsAgo = DateTime.now().subtract(const Duration(days: 365 * 5));
                return date.isAfter(fiveYearsAgo) && date.day != 23;
              },
              locale: 'en',
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Selected date is ${_formatDate(_selectedDate)}',
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else {
      return '${_getDayName(date)}, ${date.day}';
    }
  }

  String _getDayName(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}
