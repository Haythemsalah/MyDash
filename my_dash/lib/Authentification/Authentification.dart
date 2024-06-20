
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';

// import '../Naviguation menu/PageMenu.dart';

// class SignInPage extends StatelessWidget {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   void _signInWithPhoneNumber(BuildContext context) async {
//     String phoneNumber = '+216' + _phoneNumberController.text.trim();

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           // Navigate to PageA upon successful sign-in
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => PageA(title: '',)), // Replace PageA() with the correct constructor
//           );
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Failed to verify phone number: ${e.message}"),
//             ),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           // Navigate to code verification page
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CodeVerificationPage(verificationId: verificationId),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to sign in with phone number: $e"),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     appBar: AppBar(title: Text('Hello MY DASH', style: TextStyle(fontWeight: FontWeight.bold))),

//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Your asset added here
//             Image.asset(
//               'assets/Orange_small_logo.png',
//               height: 100, // Adjust height as needed
//               width: 100, // Adjust width as needed
//             ),
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone, // Restrict keyboard to numbers
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _signInWithPhoneNumber(context),
//               child: Text('Sign In', style: TextStyle(color: Colors.black)), // Change text color to black
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CodeVerificationPage extends StatelessWidget {
//   final String verificationId;

//   const CodeVerificationPage({Key? key, required this.verificationId}) : super(key: key);

//   void _verifyCode(BuildContext context, String code) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       // Navigate to PageA upon successful verification
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => PageA(title: '',)), // Replace PageA() with the correct constructor
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to verify code: $e"),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Verify Code')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             //  TextField(
//             //   decoration: InputDecoration(labelText: 'Verification Code'),
//             //   onChanged: (value) => _verifyCode(context, value),
//             // ),
//             TextField(
//               keyboardType: TextInputType.number, // Restrict keyboard to numbers
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.digitsOnly // Only allow digits
//               ],
//               decoration: InputDecoration(labelText: 'Verification Code'),
//               onChanged: (value) => _verifyCode(context, value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

// import '../Naviguation menu/PageMenu.dart';

// class SignInPage extends StatelessWidget {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   void _signInWithPhoneNumber(BuildContext context) async {
//     String phoneNumber = '+216' + _phoneNumberController.text.trim();

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           _saveLoggedInStatus(); // Save logged-in status
//           // Navigate to PageA upon successful sign-in
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => PageA(title: '')),
//           );
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Failed to verify phone number: ${e.message}"),
//             ),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           // Navigate to code verification page
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CodeVerificationPage(verificationId: verificationId),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to sign in with phone number: $e"),
//         ),
//       );
//     }
//   }

//   // Function to save logged-in status using SharedPreferences
//   void _saveLoggedInStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Hello MY DASH', style: TextStyle(fontWeight: FontWeight.bold))),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Image.asset(
//               'assets/Orange_small_logo.png',
//               height: 100,
//               width: 100,
//             ),
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _signInWithPhoneNumber(context),
//               child: Text('Sign In', style: TextStyle(color: Colors.black)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CodeVerificationPage extends StatelessWidget {
//   final String verificationId;

//   const CodeVerificationPage({Key? key, required this.verificationId}) : super(key: key);

//   void _verifyCode(BuildContext context, String code) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       _saveLoggedInStatus(); // Save logged-in status
//       // Navigate to PageA upon successful verification
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => PageA(title: '')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to verify code: $e"),
//         ),
//       );
//     }
//   }

//   // Function to save logged-in status using SharedPreferences
//   void _saveLoggedInStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Verify Code')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               keyboardType: TextInputType.number,
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.digitsOnly
//               ],
//               decoration: InputDecoration(labelText: 'Verification Code'),
//               onChanged: (value) => _verifyCode(context, value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package

// import '../Naviguation menu/PageMenu.dart';
// class SignInPage extends StatelessWidget {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   void _signInWithPhoneNumber(BuildContext context) async {
//     String phoneNumber = '+216' + _phoneNumberController.text.trim();

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           _saveLoggedInStatus(phoneNumber); // Save logged-in status with phone number
//           // Navigate to PageA upon successful sign-in
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => PageA(title: '')),
//           );
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Failed to verify phone number: ${e.message}"),
//             ),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           // Navigate to code verification page
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CodeVerificationPage(verificationId: verificationId),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to sign in with phone number: $e"),
//         ),
//       );
//     }
//   }

//   // Function to save logged-in status using SharedPreferences
//   void _saveLoggedInStatus(String phoneNumber) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);

//     // Assign role based on phone number
//     String role = _getRoleForPhoneNumber(phoneNumber);
//     await prefs.setString('userRole', role);
//   }

//   String _getRoleForPhoneNumber(String phoneNumber) {
//     // Hardcoded role assignment for demonstration purposes
//     if (phoneNumber == '+21626581412') {
//       return 'full'; // Full access role
//     } else {
//       return 'restricted'; // Restricted access role
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Hello MY DASH', style: TextStyle(fontWeight: FontWeight.bold))),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Image.asset(
//               'assets/Orange_small_logo.png',
//               height: 100,
//               width: 100,
//             ),
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _signInWithPhoneNumber(context),
//               child: Text('Sign In', style: TextStyle(color: Colors.black)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CodeVerificationPage extends StatelessWidget {
//   final String verificationId;

//   const CodeVerificationPage({Key? key, required this.verificationId}) : super(key: key);

//   void _verifyCode(BuildContext context, String code) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       _saveLoggedInStatus(); // Save logged-in status
//       // Navigate to PageA upon successful verification
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => PageA(title: '')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to verify code: $e"),
//         ),
//       );
//     }
//   }

//   // Function to save logged-in status using SharedPreferences
//   void _saveLoggedInStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Verify Code')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               keyboardType: TextInputType.number,
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.digitsOnly
//               ],
//               decoration: InputDecoration(labelText: 'Verification Code'),
//               onChanged: (value) => _verifyCode(context, value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Naviguation menu/PageMenu.dart';

// class SignInPage extends StatelessWidget {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   void _signInWithPhoneNumber(BuildContext context) async {
//     String phoneNumber = '+216' + _phoneNumberController.text.trim();

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           _saveLoggedInStatus(phoneNumber);
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => PageA(title: '')),
//           );
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Failed to verify phone number: ${e.message}"),
//             ),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CodeVerificationPage(verificationId: verificationId),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to sign in with phone number: $e"),
//         ),
//       );
//     }
//   }

//   void _saveLoggedInStatus(String phoneNumber) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);

//     String role = _getRoleForPhoneNumber(phoneNumber);
//     await prefs.setString('userRole', role);

//     String entityName = _getEntityNameForPhoneNumber(phoneNumber);
//     await prefs.setString('entityName', entityName);
//   }

//   String _getRoleForPhoneNumber(String phoneNumber) {
//     if (phoneNumber == '+21626581412') {
//       return 'full';
//     } else {
//       return 'restricted';
//     }
//   }

//   String _getEntityNameForPhoneNumber(String phoneNumber) {
//     if (phoneNumber == '+21626581412') {
//       return '';
//     } else {
//       return 'Franchise Mourouj 4';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Hello MY DASH', style: TextStyle(fontWeight: FontWeight.bold))),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Image.asset(
//               'assets/Orange_small_logo.png',
//               height: 100,
//               width: 100,
//             ),
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _signInWithPhoneNumber(context),
//               child: Text('Sign In', style: TextStyle(color: Colors.black)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CodeVerificationPage extends StatelessWidget {
//   final String verificationId;

//   const CodeVerificationPage({Key? key, required this.verificationId}) : super(key: key);

//   void _verifyCode(BuildContext context, String code) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       _saveLoggedInStatus();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => PageA(title: '')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to verify code: $e"),
//         ),
//       );
//     }
//   }

//   void _saveLoggedInStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Verify Code')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               keyboardType: TextInputType.number,
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.digitsOnly
//               ],
//               decoration: InputDecoration(labelText: 'Verification Code'),
//               onChanged: (value) => _verifyCode(context, value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Naviguation menu/PageMenu.dart';

// class SignInPage extends StatelessWidget {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   void _signInWithPhoneNumber(BuildContext context) async {
//     String phoneNumber = '+216' + _phoneNumberController.text.trim();

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           _saveLoggedInStatus(phoneNumber);
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => PageA(title: '')),
//           );
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Failed to verify phone number: ${e.message}"),
//             ),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CodeVerificationPage(verificationId: verificationId),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to sign in with phone number: $e"),
//         ),
//       );
//     }
//   }

//   void _saveLoggedInStatus(String phoneNumber) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);

//     String role = _getRoleForPhoneNumber(phoneNumber);
//     await prefs.setString('userRole', role);
//     print('User Role: $role'); // Print role to terminal

//     String entityName = _getEntityNameForPhoneNumber(phoneNumber);
//     await prefs.setString('entityName', entityName);
//   }

//   String _getRoleForPhoneNumber(String phoneNumber) {
//     if (phoneNumber == '+21626581412') {
//       return 'full';
//     } else {
//       return 'restricted';
//     }
//   }

//   String _getEntityNameForPhoneNumber(String phoneNumber) {
//     if (phoneNumber == '+21626581412') {
//       return '';
//     } else {
//       return 'Franchise Mourouj 4';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Hello MY DASH', style: TextStyle(fontWeight: FontWeight.bold))),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Image.asset(
//               'assets/Orange_small_logo.png',
//               height: 100,
//               width: 100,
//             ),
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _signInWithPhoneNumber(context),
//               child: Text('Sign In', style: TextStyle(color: Colors.black)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CodeVerificationPage extends StatelessWidget {
//   final String verificationId;

//   const CodeVerificationPage({Key? key, required this.verificationId}) : super(key: key);

//   void _verifyCode(BuildContext context, String code) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       _saveLoggedInStatus();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => PageA(title: '')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to verify code: $e"),
//         ),
//       );
//     }
//   }

//   void _saveLoggedInStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Verify Code')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               keyboardType: TextInputType.number,
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.digitsOnly
//               ],
//               decoration: InputDecoration(labelText: 'Verification Code'),
//               onChanged: (value) => _verifyCode(context, value),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Naviguation menu/PageMenu.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();

  void _signInWithPhoneNumber(BuildContext context) async {
    String phoneNumber = '+216' + _phoneNumberController.text.trim();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          _saveLoggedInStatus(phoneNumber);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageA(title: '')),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to verify phone number: ${e.message}"),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CodeVerificationPage(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to sign in with phone number: $e"),
        ),
      );
    }
  }

  void _saveLoggedInStatus(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    String role = _getRoleForPhoneNumber(phoneNumber);
    await prefs.setString('userRole', role);
    print('User Role: $role'); // Print role to terminal

    String entityName = _getEntityNameForPhoneNumber(phoneNumber);
    await prefs.setString('entityName', entityName);
  }

  String _getRoleForPhoneNumber(String phoneNumber) {
    if (phoneNumber == '+21626581412') {
      return 'full';
    } else {
      return 'restricted';
    }
  }

  String _getEntityNameForPhoneNumber(String phoneNumber) {
    if (phoneNumber == '+21626581412') {
      return '';
    } else {
      return 'Franchise Mourouj 4';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello MY DASH', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/Orange_small_logo.png',
              height: 100,
              width: 100,
            ),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _signInWithPhoneNumber(context),
              child: Text('Sign In', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeVerificationPage extends StatelessWidget {
  final String verificationId;

  const CodeVerificationPage({Key? key, required this.verificationId}) : super(key: key);

  void _verifyCode(BuildContext context, String code) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
      await FirebaseAuth.instance.signInWithCredential(credential);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber!;
      _saveLoggedInStatus(phoneNumber); // Save the login status with phone number
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PageA(title: '')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to verify code: $e"),
        ),
      );
    }
  }

  void _saveLoggedInStatus(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    String role = _getRoleForPhoneNumber(phoneNumber);
    await prefs.setString('userRole', role);
    print('User Role: $role'); // Print role to terminal

    String entityName = _getEntityNameForPhoneNumber(phoneNumber);
    await prefs.setString('entityName', entityName);
  }

  String _getRoleForPhoneNumber(String phoneNumber) {
    if (phoneNumber == '+21626581412') {
      return 'full';
    } else {
      return 'restricted';
    }
  }

  String _getEntityNameForPhoneNumber(String phoneNumber) {
    if (phoneNumber == '+21626581412') {
      return '';
    } else {
      return 'Franchise Mourouj 4';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Code')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(labelText: 'Verification Code'),
              onChanged: (value) => _verifyCode(context, value),
            ),
          ],
        ),
      ),
    );
  }
}
