
import 'package:flutter/material.dart';
import 'package:my_dash/Naviguation%20menu/PageMenu.dart'; // Import your pages
import 'package:my_dash/Layout/PageB.dart'; // Import your pages
import 'package:my_dash/Layout/PageC.dart';
import 'package:my_dash/Layout/PageD.dart'; 
// Import your pages
import 'package:provider/provider.dart';

class Pagefromswipe0 extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/kpi_dashboard_main.png', 
    'assets/dashboard-modern.png',
    'assets/customer.png',
    'assets/dash4.png',
  ];

  final List<String> otherImagePaths = [
    'assets/1.png', // Replace with your additional image paths
    'assets/2.png',
    'assets/3.png',
  ];

  // List of pages corresponding to each container
  final List<Widget> pages = [
    PageD(),
    PageB(),
    PageC(),
    // Add more pages as needed
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'KPIs',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 150, // Adjust the height based on your needs
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Navigate to the corresponding page when container is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pages[index]),
                      );
                    },
                    child: Container(
                      height: 150, // Adjust the height based on your needs
                      width: 200, // Adjust the width based on your needs
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imagePaths[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
        
          Container(
            height: 250, // Adjust the height based on your needs
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: otherImagePaths.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Navigate to the corresponding page when additional container is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pages[index]),
                      );
                    },
                    child: Container(
                      height: 250, // Adjust the height based on your needs
                      width: 200, // Adjust the width based on your needs
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          otherImagePaths[index],
                          fit: BoxFit.cover,
                        ),
                      ),
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















