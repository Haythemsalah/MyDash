
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:my_dash/Naviguation%20menu/PageMenu.dart';
// import 'package:provider/provider.dart';
// import 'package:my_dash/Layout/Page3.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey:
//           "AIzaSyA4dvarN22kDoM7zHlfqR8HNGmByfrHkKY", // paste your api key here
//       appId:
//           "1:256849183307:android:b94803a557072c2b8103ce", //paste your app id here
//       messagingSenderId: "256849183307", //paste your messagingSenderId here
//       projectId: "my-dash-a67f9", //paste your project id here
//     ),
    
//   );
  
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'My Dash',
//       home: MyHomePage(),
//     );
//   }
 
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   Widget build1(BuildContext context) {
//     return MaterialApp(
//       title: 'My Dash',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//         hintColor: Colors.orange,
//         indicatorColor: Colors.blueGrey,
//       ),
//       darkTheme: ThemeData.dark(),
//       home: const PageA(title: 'My Dash'),
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
//               width: 140, // Adjust the width as needed
//               height: 140, // Adjust the height as needed
//             ),
//             const SizedBox(height: 10), // Adjust the height as needed
//             // Circular loading indicator
//             CircularProgressIndicator(
//               strokeWidth: 2, // Adjust the strokeWidth as needed
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:my_dash/Authentification/Authentification.dart';
// import 'package:my_dash/Naviguation%20menu/PageMenu.dart';
// import 'package:provider/provider.dart';
// import 'package:my_dash/Layout/Page3.dart';
// import 'package:my_dash/services/firebase_api.dart'; // Import your Firebase API file here
// import 'package:my_dash/services/RetrieveData_api.dart'; // Import your API service
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyA4dvarN22kDoM7zHlfqR8HNGmByfrHkKY", // paste your api key here
//       appId: "1:256849183307:android:b94803a557072c2b8103ce", //paste your app id here
//       messagingSenderId: "256849183307", //paste your messagingSenderId here
//       projectId: "my-dash-a67f9", //paste your project id here
//     ),
//   );

//   // Retrieve the FCM token
//   String? fcmToken = await FirebaseMessagingService().getToken();
//   print('FCM Token: $fcmToken');

//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'My Dash',
//       home: MyHomePage(),
//     );
//   }
 
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   Widget build1(BuildContext context) {
//     return MaterialApp(
//       title: 'My Dash',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//         hintColor: Colors.orange,
//         indicatorColor: Colors.blueGrey,
//       ),
//       darkTheme: ThemeData.dark(),
//       home: const PageA(title: 'My Dash'),
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
//         MaterialPageRoute(builder: (context) => SignInPage()),
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
//               width: 140, // Adjust the width as needed
//               height: 140, // Adjust the height as needed
//             ),
//             const SizedBox(height: 10), // Adjust the height as needed
//             // Circular loading indicator
//             CircularProgressIndicator(
//               strokeWidth: 2, // Adjust the strokeWidth as needed
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget build2(BuildContext context) {
//     return FutureBuilder(
//       future: checkLoggedInStatus(), // Check logged-in status
//       builder: (context, AsyncSnapshot<bool> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else {
//           if (snapshot.data == true) {
//             return PageA(title: ''); // Navigate to authenticated screen if logged in
//           } else {
//             return SignInPage(); // Navigate to sign-in screen if not logged in
//           }
//         }
//       },
//     );
//   }

//   // Function to check logged-in status using SharedPreferences
//   Future<bool> checkLoggedInStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isLoggedIn') ?? false; // Return false if isLoggedIn key doesn't exist
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_dash/Authentification/Authentification.dart';
import 'package:my_dash/Naviguation%20menu/PageMenu.dart';
import 'package:provider/provider.dart';
import 'package:my_dash/Layout/Page3.dart';
import 'package:my_dash/services/firebase_api.dart'; // Import your Firebase API file here
import 'package:my_dash/services/RetrieveData_api.dart'; // Import your API service
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA4dvarN22kDoM7zHlfqR8HNGmByfrHkKY", // paste your api key here
      appId: "1:256849183307:android:b94803a557072c2b8103ce", //paste your app id here
      messagingSenderId: "256849183307", //paste your messagingSenderId here
      projectId: "my-dash-a67f9", //paste your project id here
    ),
  );

  // Retrieve the FCM token
  String? fcmToken = await FirebaseMessagingService().getToken();
  print('FCM Token: $fcmToken');

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
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder<String?>(
          future: _getUserRole(), // Retrieve the user role
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              );
            } else if (snapshot.hasData) {
              String role = snapshot.data!;
              return Column(
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
                  const SizedBox(height: 10),
                  // Display user role
                  Text(
                    'Role: $role',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            } else {
              return Text(
                'Error retrieving role',
                style: TextStyle(color: Colors.white),
              );
            }
          },
        ),
      ),
    );
  }

  Future<String?> _getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRole');
  }
}
