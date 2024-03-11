import 'package:flutter/material.dart';

class PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page C'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Content for Page C'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // This line will navigate back to the previous page
              },
              child: Text('Return'),
            ),
          ],
        ),
      ),
    );
  }
}
