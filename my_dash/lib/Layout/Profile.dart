
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controller for text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Save button callback
  void _saveProfile() {
    // TODO: Implement your logic to save the profile data
    // You can access the entered data using _usernameController.text, _fullNameController.text, etc.
    print('Profile Saved!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromARGB(255, 201, 196, 196), // Set the background color for the avatar
                // You can set the profile picture image here
                // backgroundImage: AssetImage('path_to_your_image'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Set the background color of the button
                ),
                child: Text(
                  'Save Profile',
                  style: TextStyle(
                    color: Colors.black, // Set the text color of the button
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
