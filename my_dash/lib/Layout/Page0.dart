
//tmchi
// import 'package:flutter/material.dart';
// import 'package:chips_choice/chips_choice.dart';
// import 'package:animated_checkmark/animated_checkmark.dart';
// //import 'package:theme_patrol/theme_patrol.dart';

// class Page0 extends StatefulWidget {
//   const Page0({Key? key}) : super(key: key);

//   @override
//   Page0State createState() => Page0State();
// }

// class Page0State extends State<Page0> {
//   int tag = 3;
//   List<String> tags = ['Tracking'];
//   List<String> options = [
//     'Recharge',
//     'Achat option',
//     'Promos',
//     'Bons plans',
//     'Transfert internet',
//     'Transfert crédit',
//     'Dates',
//     'E-Shop',
//     'Roue de la chance',
//     'Services',
//     'Paiement de facture',
//   ];

//  final formKey = GlobalKey<FormState>();
//   List<String> formValue = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
        
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: ListView(
//                 addAutomaticKeepAlives: true,
//                 children: <Widget>[
//                   Content(
//                     // Removed the title to make it smaller
//                      title: 'Scrollable List Single Choice',
//                     child: ChipsChoice<int>.single(
//                       value: tag,
//                       onChanged: (val) => setState(() => tag = val),
//                       choiceItems: C2Choice.listFrom<int, String>(
//                         source: options,
//                         value: (i, v) => i,
//                         label: (i, v) => v,
//                         tooltip: (i, v) => v,
//                       ),
//                       choiceCheckmark: true,
//                       choiceStyle: C2ChipStyle.filled(
//                         selectedStyle: const C2ChipStyle(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(25),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Content(
//                     title: 'Custom Choice Widget',
//                     child: ChipsChoice<String>.multiple(
//                       value: tags,
//                       onChanged: (val) => setState(() => tags = val),
//                       choiceItems: C2Choice.listFrom<String, String>(
//                         source: options,
//                         value: (i, v) => v,
//                         label: (i, v) => v,
//                       ),
//                       choiceBuilder: (item, i) {
//                         return CustomChip(
//                           label: item.label,
//                           width: 70,
//                           height: 70,
//                           selected: item.selected,
//                           onSelect: item.select!,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomChip extends StatelessWidget {
//   final String label;
//   final Color? color;
//   final double? width;
//   final double? height;
//   final EdgeInsetsGeometry? margin;
//   final bool selected;
//   final Function(bool selected) onSelect;

//   const CustomChip({
//     Key? key,
//     required this.label,
//     this.color,
//     this.width,
//     this.height,
//     this.margin,
//     this.selected = false,
//     required this.onSelect,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       width: width,
//       height: height,
//       margin: margin ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
//       duration: const Duration(milliseconds: 300),
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//         color: selected ? (color ?? Colors.deepOrange) : Colors.transparent,
//         borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
//         border: Border.all(
//           color: selected ? (color ?? Colors.deepOrange) : Colors.grey,
//           width: 1,
//         ),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
//         onTap: () => onSelect(!selected),
//         child: Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             AnimatedCheckmark(
//               active: selected,
//               color: Colors.white,
//               size: const Size.square(32),
//               weight: 5,
//               duration: const Duration(milliseconds: 400),
//             ),
//             Positioned(
//               left: 9,
//               right: 9,
//               bottom: 7,
//               child: Text(
//                 label,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   color: selected ? Colors.white : Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Content extends StatelessWidget {
//   final String title;
//   final Widget child;

//   const Content({
//     Key? key,
//     required this.title,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(15),
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Flexible(fit: FlexFit.loose, child: child),
//         ],
//       ),
//     );
//   }
// }

// void _about(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (_) => Dialog(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           ListTile(
//             title: Text(
//               'chips_choice',
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineSmall!
//                   .copyWith(color: Colors.black87),
//             ),
//             subtitle: const Text('by davigmacode'),
//             trailing: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           Flexible(
//             fit: FlexFit.loose,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text(
//                     'Easy way to provide a single or multiple choice chips.',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .copyWith(color: Colors.black54),
//                   ),
//                   Container(height: 15),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//mohawla bhya 
// import 'package:flutter/material.dart';

// class Page0 extends StatefulWidget {
//   const Page0({Key? key}) : super(key: key);

//   @override
//   Page0State createState() => Page0State();
// }

// class Page0State extends State<Page0> {
//   int tag = 3;
//   List<String> tags = ['Tracking'];
//   List<String> options = [
//     'Recharge',
//     'Achat option',
//     'Promos',
//     'Bons plans',
//     'Transfert internet',
//     'Transfert crédit',
//     'Dates',
//     'E-Shop',
//     'Roue de la chance',
//     'Services',
//     'Paiement de facture',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Content(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: options.map((String option) {
//                 return ChoiceChip(
//                   label: Text(option),
//                   selected: tag == options.indexOf(option),
//                   onSelected: (bool selected) {
//                     setState(() {
//                       tag = selected ? options.indexOf(option) : -1;
//                     });
//                   },
//                   selectedColor: Colors.deepOrange,
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Content extends StatelessWidget {
//   final Widget child;

//   const Content({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: child,
//       ),
//     );
//   }
// }
//el hadher
// import 'package:flutter/material.dart';

// class Page0 extends StatefulWidget {
//   const Page0({Key? key}) : super(key: key);

//   @override
//   Page0State createState() => Page0State();
// }

// class Page0State extends State<Page0> {
//   int tag = 3;
//   List<String> tags = ['Tracking'];
//   List<String> options = [
//     'Recharge',
//     'Achat option',
//     'Promos',
//     'Bons plans',
//     'Transfert internet',
//     'Transfert crédit',
//     'Dates',
//     'E-Shop',
//     'Roue de la chance',
//     'Services',
//     'Paiement de facture',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0.0,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Content(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: options.map((String option) {
//                     return Container(
//                       margin: const EdgeInsets.only(right: 8.0),
//                       child: ChoiceChip(
//                         label: Text(
//                           option,
//                           style: TextStyle(
//                             color: tag == options.indexOf(option)
//                                 ? Colors.white
//                                 : Colors.black,
//                           ),
//                         ),
//                         selected: tag == options.indexOf(option),
//                         onSelected: (bool selected) {
//                           setState(() {
//                             tag = selected ? options.indexOf(option) : -1;
//                           });
//                         },
//                         selectedColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Content extends StatelessWidget {
//   final Widget child;

//   const Content({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: child,
//     );
//   }
// }
//lekhr
// import 'package:flutter/material.dart';
// import 'package:my_dash/PageA.dart';
// import 'package:provider/provider.dart';

// class Page0 extends StatefulWidget {
//   const Page0({Key? key}) : super(key: key);

//   @override
//   Page0State createState() => Page0State();
// }

// class Page0State extends State<Page0> {
//   int tag = 3;
//   List<String> tags = ['Tracking'];
//   List<String> options = [
//     'Recharge',
//     'Achat option',
//     'Promos',
//     'Bons plans',
//     'Transfert internet',
//     'Transfert crédit',
//     'Dates',
//     'E-Shop',
//     'Roue de la chance',
//     'Services',
//     'Paiement de facture',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Card(
//       elevation: 0.0,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       color: themeProvider.isDarkMode ? Color.fromARGB(255, 15, 19, 21) : Colors.white, // Adjust background color based on dark mode
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Content(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: options.map((String option) {
//                     return Container(
//                       margin: const EdgeInsets.only(right: 8.0),
//                       child: ChoiceChip(
//                         label: Text(
//                           option,
//                           style: TextStyle(
//                             color: tag == options.indexOf(option)
//                                 ? Colors.white
//                                 : Colors.black,
//                           ),
//                         ),
//                         selected: tag == options.indexOf(option),
//                         onSelected: (bool selected) {
//                           setState(() {
//                             tag = selected ? options.indexOf(option) : -1;
//                           });
//                         },
//                         selectedColor: themeProvider.isDarkMode ? const Color.fromARGB(223, 255, 115, 34) : Colors.black, // Adjust color based on dark mode
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Content extends StatelessWidget {
//   final Widget child;

//   const Content({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: child,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:my_dash/Naviguation%20menu/PageMenu.dart';
import 'package:my_dash/Layout/Pagefromswipe0.dart';
import 'package:my_dash/Layout/Pagefromswipe1.dart';
import 'package:my_dash/Layout/Pagefromswipe2.dart';
import 'package:provider/provider.dart';

class Page0 extends StatefulWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  Page0State createState() => Page0State();
}

class Page0State extends State<Page0> {
  List<String> options = [
    'Recharge',
    'Achat option',
    'Promos',
    'Bons plans',
    'Transfert internet',
    'Transfert crédit',
    'Dates',
    'E-Shop',
    'Roue de la chance',
    'Services',
    'Paiement de facture',
  ];

  int selectedOptionIndex = -1; // Initialize with a default value

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: themeProvider.isDarkMode ? Color.fromARGB(255, 15, 19, 21) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: options.map((String option) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          option,
                          style: TextStyle(
                            color: selectedOptionIndex == options.indexOf(option)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: selectedOptionIndex == options.indexOf(option),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedOptionIndex = selected ? options.indexOf(option) : -1;
                          });
                        },
                        selectedColor: themeProvider.isDarkMode ? const Color.fromARGB(223, 255, 115, 34) : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            selectedOptionIndex != -1
                ? buildContentForSelectedOption(options[selectedOptionIndex])
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget buildContentForSelectedOption(String selectedOption) {
    switch (selectedOption) {
      case 'Recharge':
        return Pagefromswipe0();
      case 'Achat option':
        return Pagefromswipe1();
      case 'Promos':
        return Pagefromswipe2();
      // Add cases for other options as needed
      default:
        return DefaultPageContent();
    }
  }
}


class DefaultPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Default Content - Unknown Option'),
    );
  }
}

class Content extends StatelessWidget {
  final Widget child;

  const Content({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}


// ... Add more page classes as needed



