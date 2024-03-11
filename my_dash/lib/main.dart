import 'package:flutter/material.dart';
// import 'package:my_dash/Layout/CustomSearch.dart';
// import 'package:my_dash/Layout/Page0.dart';
// import 'package:my_dash/Layout/Page3.dart';
// import 'package:my_dash/Layout/PageB.dart';
// import 'package:my_dash/Layout/PageC.dart';
// import 'package:my_dash/Layout/PageChartJson.dart';
// import 'package:my_dash/Layout/PageChatBot.dart';
// import 'package:my_dash/Layout/PageD.dart';
// import 'package:my_dash/Layout/Profile.dart';
//import 'package:animator/animator.dart';
import 'package:my_dash/Naviguation%20menu/PageMenu.dart';
import 'package:provider/provider.dart';
//import 'package:theme_patrol/theme_patrol.dart';
//import 'package:theme_patrol/theme_patrol.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Dash',
      home: MyHomePage(),
    );
  }
 
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget build1(BuildContext context) {
    return MaterialApp(
      title: 'My Dash',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        hintColor: Colors.orange,
        indicatorColor: Colors.blueGrey,
      ),
      darkTheme: ThemeData.dark(),
      home: const PageA(title: 'My Dash'),
      //  initialRoute: '/',
      //   navigatorKey: navigatorKey,  // Add this line
      // routes: {
      //   '/': (context) => const MyHomePage(),
      //   //'/searchResult': (context) => SearchResultPage(),
      //   '/page0': (context) => Page0(),
      //   '/page3': (context) => Page3(),
      //   '/pageB': (context) => PageB(),
      //   '/pageC': (context) => PageC(),
      //   '/page2': (context) => Page2(),
      //   '/page4': (context) => Page4(),
      //   '/pageD': (context) => PageD(),
      //   '/profile': (context) => ProfilePage(),
        
      // },
    );
  }

  // Widget build1(BuildContext context) {
  //   return ThemePatrol(
  //     light: ThemeData(
  //       brightness: Brightness.light,
  //       colorScheme: ColorScheme.fromSeed(
  //         brightness: Brightness.light,
  //         seedColor: Colors.deepOrange,
  //       ),
  //     ),
  //     dark: ThemeData(
  //       brightness: Brightness.dark,
  //       colorScheme: ColorScheme.fromSeed(
  //         brightness: Brightness.dark,
  //         seedColor: Colors.deepOrange,
  //       ),
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //     ),
  //     builder: (context, theme) {
  //       return MaterialApp(
  //         title: 'Chips Choice',
  //         theme: theme.lightData,
  //         darkTheme: theme.darkData,
  //         themeMode: theme.mode,
  //         home: const PageA(title: '',),
  //       );
  //     },
  //   );
  // }

}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PageA(title: 'My Dash')),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image in the middle
            Image.asset(
              'assets/Orange_small_logo.png', // Replace with the correct asset path
              width: 140, // Adjust the width as needed
              height: 140, // Adjust the height as needed
            ),
            const SizedBox(height: 10), // Adjust the height as needed
            // Circular loading indicator
            CircularProgressIndicator(
              strokeWidth: 2, // Adjust the strokeWidth as needed
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
