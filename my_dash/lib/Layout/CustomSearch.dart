
import 'package:flutter/material.dart';
import 'package:my_dash/Layout/Page0.dart';
import 'package:my_dash/Layout/Page3.dart';
import 'package:my_dash/Layout/PageB.dart';
import 'package:my_dash/Layout/PageC.dart';
import 'package:my_dash/Layout/PageChartJson.dart';
import 'package:my_dash/Layout/PageChatBot.dart';
import 'package:my_dash/Layout/PageD.dart';


class CustomSearchDelegate extends SearchDelegate<String?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          // Clear the search query
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Close the search bar
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Handle the navigation directly when the search is submitted
    navigateToPage(context, query);
    return Container(); // Return an empty container, as we're handling the navigation directly
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions UI here
    return FutureBuilder<List<String>>(
      // Assume you have a method that returns a list of all available pages/words
      future: getAllPages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final List<String> allPages = snapshot.data ?? [];

        // Filter pages based on the search query
        final List<String> filteredPages = allPages
            .where((page) => page.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: filteredPages.length,
          itemBuilder: (context, index) {
            final page = filteredPages[index];
            return ListTile(
              title: Text(page),
              onTap: () {
                // Close the search bar and navigate to the selected page
                close(context, page);
                // Implement logic to navigate to the selected page
                navigateToPage(context, page);
              },
            );
          },
        );
      },
    );
  }

  Future<List<String>> getAllPages() async {
    // Replace this with logic to fetch all available pages/words in your app
    return ['Page0', 'Page3', 'PageB', 'PageC', 'Page2', 'Page4', 'PageD', 'Pagefromswipe0', 'Pagefromswipe1', 'Pagefromswipe2', 'Profile'];
  }

  void navigateToPage(BuildContext context, String page) {
    Widget pageWidget;

    // Assign the appropriate widget based on the page name
    switch (page) {
      case 'Page0':
        pageWidget = Page0();
        break;
      case 'Page3':
        pageWidget = Page3();
        break;
      case 'PageB':
        pageWidget = PageB();
        break;
      case 'PageC':
        pageWidget = PageC();
        break;
      case 'PageChartJson':
        pageWidget = Page2();
        break;
      case 'PageChatBot':
        pageWidget = Page4();
        break;
      case 'PageD':
        pageWidget = PageD();
        break;
      // Add cases for other pages...
      default:
        // Handle unknown pages or navigate to a default page
        return;
    }

    // Navigate to the selected page with a custom page route
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuad;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final Widget pageWidget;

  SearchResultPage({required this.pageWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pageWidget, // Display the page without hero animation
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// class CustomSearchDelegate extends SearchDelegate<String?> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           // Clear the search query
//           query = '';
//         },
//         icon: Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         // Close the search bar
//         close(context, null);
//       },
//       icon: Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Handle the navigation directly when the search is submitted
//     navigateToPage(context, query);
//     return Container(); // Return an empty container, as we're handling the navigation directly
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Implement your search suggestions UI here
//     return FutureBuilder<List<String>>(
//       // Assume you have a method that returns a list of all available pages/words
//       future: getAllPages(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         }

//         final List<String> allPages = snapshot.data ?? [];

//         // Filter pages based on the search query
//         final List<String> filteredPages = allPages
//             .where((page) => page.toLowerCase().contains(query.toLowerCase()))
//             .toList();

//         return ListView.builder(
//           itemCount: filteredPages.length,
//           itemBuilder: (context, index) {
//             final page = filteredPages[index];
//             return ListTile(
//               title: Text(page),
//               onTap: () {
//                 // Close the search bar and navigate to the selected page
//                 close(context, page);
//                 // Implement logic to navigate to the selected page
//                 navigateToPage(context, page);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<List<String>> getAllPages() async {
//     // Replace this with logic to fetch all available pages/words in your app
//     return ['Page0', 'Page3', 'PageB', 'PageC', 'Page2', 'Page4', 'PageD', 'Pagefromswipe0', 'Pagefromswipe1', 'Pagefromswipe2', 'Profile'];
//   }

//   void navigateToPage(BuildContext context, String page) {
//     // Navigate to the selected page using named routes
//     Navigator.pushNamed(context, '/searchResult', arguments: page);
//     Navigator.pushNamed(context, '/Page0');

//   }
// }
// class SearchResultPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Your search result page content
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Result'),
//       ),
//       body: Center(
//         child: Text('Your search result page content goes here'),
//       ),
//     );
//   }
// }

// class CustomSearchDelegate extends SearchDelegate<String?> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           // Clear the search query
//           query = '';
//         },
//         icon: Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         // Close the search bar
//         close(context, null);
//       },
//       icon: Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Handle the navigation directly when the search is submitted
//     navigateToPage(context, query);
//     return Container(); // Return an empty container, as we're handling the navigation directly
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Implement your search suggestions UI here
//     return FutureBuilder<List<String>>(
//       // Assume you have a method that returns a list of all available pages/words
//       future: getAllPages(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         }

//         final List<String> allPages = snapshot.data ?? [];

//         // Filter pages based on the search query
//         final List<String> filteredPages = allPages
//             .where((page) => page.toLowerCase().contains(query.toLowerCase()))
//             .toList();

//         return ListView.builder(
//           itemCount: filteredPages.length,
//           itemBuilder: (context, index) {
//             final page = filteredPages[index];
//             return ListTile(
//               title: Text(page),
//               onTap: () {
//                 // Close the search bar and navigate to the selected page
//                 close(context, page);
//                 // Implement logic to navigate to the selected page
//                 navigateToPage(context, page);
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<List<String>> getAllPages() async {
//     // Replace this with logic to fetch all available pages/words in your app
//     return ['Page0', 'Page3', 'PageB', 'PageC', 'Page2', 'Page4', 'PageD', 'Pagefromswipe0', 'Pagefromswipe1', 'Pagefromswipe2', 'Profile'];
//   }

//   void navigateToPage(BuildContext context, String page) {
//     Widget pageWidget;

//     // Assign the appropriate widget based on the page name
//     switch (page) {
//       case 'Page0':
//         pageWidget = Page0();
//         break;
//       case 'Page3':
//         pageWidget = Page3();
//         break;
//       case 'PageB':
//         pageWidget = PageB();
//         break;
//       case 'PageC':
//         pageWidget = PageC();
//         break;
//       case 'Page2':
//         pageWidget = Page2();
//         break;
//       case 'Page4':
//         pageWidget = Page4();
//         break;
//       case 'PageD':
//         pageWidget = PageD();
//         break;
//       // Add cases for other pages...

//       default:
//         // Handle unknown pages or navigate to a default page
//         return;
//     }

//     // Use pushNamed with the corresponding route name
//     // Navigator.pushNamed(context, '/${page.toLowerCase()}');
  
   
//     Navigator.pushNamed(navigatorKey.currentContext!, '/${page.toLowerCase()}');

//   }
// }
