// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = 'https://client-data-pwya.onrender.com/get-data/';

//   Future<List<dynamic>> fetchData({int? tmcode, String? entityName, String? activationDate}) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/get-data/').replace(queryParameters: {
//         if (tmcode != null) 'tmcode': tmcode.toString(),
//         if (entityName != null) 'entity_name': entityName,
//         if (activationDate != null) 'activation_date': activationDate,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['data'];
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://client-data-pwya.onrender.com/get-data/';

  Future<List<dynamic>> fetchData({int? tmcode, String? entityName, String? activationDate}) async {
    try {
      final uri = Uri.parse(baseUrl).replace(queryParameters: {
        if (tmcode != null) 'tmcode': tmcode.toString(),
        if (entityName != null) 'entity_name': entityName,
        if (activationDate != null) 'activation_date': activationDate,
      });
      print('Requesting data from: $uri'); // Debugging line to check the URL

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error in fetchData: $e');
      throw Exception('Failed to load data');
    }
  }
}
