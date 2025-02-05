```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      try {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } on FormatException catch (e) {
        print('Invalid JSON format: $e');
        return null; // Or throw a custom exception
      }
    } else {
      print('Request failed with status: ${response.statusCode}. Body: ${response.body}');
      throw Exception('API request failed with status: ${response.statusCode}');
    }
  } on http.ClientException catch (e) {
    print('Network error: $e');
    throw Exception('Network error: Could not connect to API'); // Custom user friendly message
  } catch (e) {
    print('Unexpected error: $e');
    rethrow; // Re-throw to allow for higher-level error handling if needed
  }
}
```