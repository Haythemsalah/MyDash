
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_dash/Layout/CustomSearch.dart';
import 'package:my_dash/Layout/Page0.dart';
//import 'package:my_dash/Page1.dart';
import 'package:my_dash/Layout/PageChartJson.dart';
import 'package:my_dash/Layout/Page3.dart';
import 'package:my_dash/Layout/PageChatBot.dart';
import 'package:provider/provider.dart';
import 'package:my_dash/Layout/Profile.dart';
class PageA extends StatefulWidget {
  const PageA({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'My Dash',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black, // Set title color based on dark mode
          ),
        ),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/Orange_small_logo.png',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
          
          icon: Icon(
    themeProvider.isDarkMode ? Icons.wb_sunny : Icons.brightness_2,
    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
  ),
),
IconButton(
 onPressed: () {
    // Navigate to the profile page when the button is pressed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  },
  icon: Icon(
    Icons.person,
    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
  ),
),
IconButton(
  onPressed: () async {
    // Show the search bar and wait for the user to input a query
    String? result = await showSearch<String?>(
      context: context,
      delegate: CustomSearchDelegate(), // Replace with your custom search delegate
    );

    // Handle the search result (you can do something with the result if needed)
    if (result != null && result.isNotEmpty) {
      print('Search result: $result');
    }
  },
  icon: Icon(
    Icons.search,
    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
  ),
),

        ],
      ),
      body: TabBarView(
        controller: tabController,
        dragStartBehavior: DragStartBehavior.down,
        physics: const BouncingScrollPhysics(),
        children: [
          Page0(),
         // Page1(),
          Page2(),
          Page3(),
          Page4(),
        ],
      ),
      bottomNavigationBar: Container(
        color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.blueGrey, width: 4),
            insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
          ),
          tabs: [
            TabsIcon(
              icon: Icons.home,
              iconColor: currentPage == 0 ? const Color.fromARGB(223, 255, 115, 34) : (themeProvider.isDarkMode ? Colors.white : Colors.black),
            ),
            // TabsIcon(
            //   icon: Icons.search,
            //   iconColor: currentPage == 1 ? const Color.fromARGB(223, 255, 115, 34) : (themeProvider.isDarkMode ? Colors.white : Colors.black),
            // ),
            TabsIcon(
              icon: Icons.dashboard,
              iconColor: currentPage == 1 ? const Color.fromARGB(223, 255, 115, 34) : (themeProvider.isDarkMode ? Colors.white : Colors.black),
            ),
            TabsIcon(
              icon: Icons.pie_chart,
              iconColor: currentPage == 2 ? const Color.fromARGB(223, 255, 115, 34) : (themeProvider.isDarkMode ? Colors.white : Colors.black),
            ),
            TabsIcon(
              icon: Icons.chat,
              iconColor: currentPage == 3 ? const Color.fromARGB(223, 255, 115, 34) : (themeProvider.isDarkMode ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color iconColor;
  final double height;
  final double width;
  final IconData icon;

  const TabsIcon({
    Key? key,
    this.iconColor = Colors.black,
    this.height = 60,
    this.width = 50,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}







