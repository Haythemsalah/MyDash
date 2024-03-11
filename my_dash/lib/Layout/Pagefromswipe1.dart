
import 'package:flutter/material.dart';
class Pagefromswipe1 extends StatelessWidget {
  final int numberOfContainers = 5; // Adjust the number of containers as needed

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Content for swiped choice 1'),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
