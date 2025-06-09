import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String _endpoint = 'https://api.openai.com/v1/chat/completions';
  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  Future<String> getWorkoutPlan(String prompt) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": prompt}]
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get workout from OpenAI');
    }
  }
}
