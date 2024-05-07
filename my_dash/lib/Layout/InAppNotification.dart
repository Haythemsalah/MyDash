import 'package:flutter/material.dart';

class InAppNotification extends StatelessWidget {
  final VoidCallback onClose;

  const InAppNotification({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: onClose,
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New notification!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 16),
                IconButton(
                  onPressed: onClose,
                  icon: Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
