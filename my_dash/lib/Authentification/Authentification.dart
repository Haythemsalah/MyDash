// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignInPage extends StatelessWidget {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   void _signInWithPhoneNumber(BuildContext context) async {
//     String phoneNumber = '+216' + _phoneNumberController.text.trim();

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential);
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
//       appBar: AppBar(title: Text('Sign In with Phone Number')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone, // Restrict keyboard to numbers
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _signInWithPhoneNumber(context),
//               child: Text('Sign In'),
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
//             TextField(
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
//       appBar: AppBar(title: Text('Sign In with Phone Number')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone, // Restrict keyboard to numbers
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => _signInWithPhoneNumber(context),
//               child: Text('Sign In'),
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
//             TextField(
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
          // Navigate to PageA upon successful sign-in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PageA(title: '',)), // Replace PageA() with the correct constructor
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
          // Navigate to code verification page
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
            // Your asset added here
            Image.asset(
              'assets/Orange_small_logo.png',
              height: 100, // Adjust height as needed
              width: 100, // Adjust width as needed
            ),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone, // Restrict keyboard to numbers
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _signInWithPhoneNumber(context),
              child: Text('Sign In', style: TextStyle(color: Colors.black)), // Change text color to black
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
      // Navigate to PageA upon successful verification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PageA(title: '',)), // Replace PageA() with the correct constructor
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to verify code: $e"),
        ),
      );
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
              decoration: InputDecoration(labelText: 'Verification Code'),
              onChanged: (value) => _verifyCode(context, value),
            ),
          ],
        ),
      ),
    );
  }
}
