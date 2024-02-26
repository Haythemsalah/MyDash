import 'package:flutter/material.dart';
//import 'package:animator/animator.dart';
import 'package:my_dash/PageMenu.dart';
import 'package:provider/provider.dart';
//import 'package:theme_patrol/theme_patrol.dart';
//import 'package:theme_patrol/theme_patrol.dart';


// void main() {
//   runApp(MyApp());
// }
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
  //mohawla
  // Widget build1(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Frosted bottom bar',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blueGrey,
  //     ),
  //     home: const PageA(title: 'My Dash'),
  //   );
  // }
  //dark
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
  // mohawla theme 
  // Widget build3(BuildContext context) {
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
  //         home: const PageA(title: 'My Dash'),
  //       );
  //     },
  //   );
  // }


}
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
    
//     return Animator<double>(
//       tween: Tween<double>(begin: 0, end: 120),
//       cycles: 0,
//       builder: (context, animatorState, child) {
//         // Delayed execution after 3 seconds
//         Future.delayed(const Duration(seconds: 3), () {
//           animatorState.controller.forward(); // Trigger the animation to set size to zero

//           // Navigate to a blank page after the animation is complete
//           Future.delayed(animatorState.controller.duration!, () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => PageA(title: 'My Dash',)),
//             );
//           });
//         });

        
//          return Center(
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           height: animatorState.value,
//           width: animatorState.value,
//           child: Image.asset(
//             'assets/Orange_small_logo.png', // Replace with the correct asset path
//           ),
//         ),
//       );
//       },
//     );
    
//   }
// }


// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     // Delayed execution after 3 seconds
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => PageA(title: 'My Dash')),
//       );
//     });

//     return Center(
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         child: Image.asset(
//           'assets/Orange_small_logo.png', // Replace with the correct asset path
//         ),
//       ),
//     );
//   }
// }
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const PageA(title: 'My Dash')),
//       );
//     });

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Image in the middle
//             Image.asset(
//               'assets/Orange_small_logo.png', // Replace with the correct asset path
//               width: 70, // Adjust the width as needed
//               height: 70, // Adjust the height as needed
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.only(bottom: 16), // Adjust the margin as needed
//         width: 10, // Adjust the width as needed
//         height: 10, // Adjust the height as needed
//         child: const CircularProgressIndicator(
//           strokeWidth: 2, // Adjust the strokeWidth as needed
//           valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
//         ),
//       ),
//     );
//   }
// }

//  class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const PageA(title: 'My Dash')),
//       );
//     });

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Image in the middle
//             Image.asset(
//               'assets/Orange_small_logo.png', // Replace with the correct asset path
//               width: 70, // Adjust the width as needed
//               height: 70, // Adjust the height as needed
//             ),
//             const SizedBox(height: 10), // Adjust the height as needed
//             // Animated loading dots
//             const AnimatedDots(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AnimatedDots extends StatefulWidget {
//   const AnimatedDots({Key? key}) : super(key: key);

//   @override
//   _AnimatedDotsState createState() => _AnimatedDotsState();
// }

// class _AnimatedDotsState extends State<AnimatedDots>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat(reverse: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: TweenSequence<double>([
//         TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 1),
//         TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
//       ]).animate(_controller),
//       child: const Text(
//         '.......',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 20, // Adjust the fontSize as needed
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
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