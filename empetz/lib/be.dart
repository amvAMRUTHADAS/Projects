// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String _baseUrl = 'http://192.168.1.15/Empetz/swagger/index.html';
//   static const String _token = 'your_bearer_token_here';

//   static Future<http.Response> getData(String endpoint) async {
//     final url = Uri.parse('$_baseUrl/$endpoint');
//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $_token',
//         'Content-Type': 'application/json',
//       },
//     );
//     return response;
//   }
// }
