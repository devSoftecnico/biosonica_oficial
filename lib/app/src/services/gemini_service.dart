import 'package:http/http.dart' as http;
import 'package:bot_dashboard/app/export_app.dart';

class GeminiService {
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1';

  Future<String> generateContent(String prompt, ModelConfig modelConfig) async {
    try {
      final url = Uri.parse('$_baseUrl/models/${modelConfig.model}:generateContent');

      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.7,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 2048,
        },
        'safetySettings': [
          {'category': 'HARM_CATEGORY_HARASSMENT', 'threshold': 'BLOCK_MEDIUM_AND_ABOVE'},
          {'category': 'HARM_CATEGORY_HATE_SPEECH', 'threshold': 'BLOCK_MEDIUM_AND_ABOVE'},
          {'category': 'HARM_CATEGORY_SEXUALLY_EXPLICIT', 'threshold': 'BLOCK_MEDIUM_AND_ABOVE'},
          {'category': 'HARM_CATEGORY_DANGEROUS_CONTENT', 'threshold': 'BLOCK_MEDIUM_AND_ABOVE'}
        ]
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'x-goog-api-key': modelConfig.apiKey},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (!jsonResponse.containsKey('candidates')) {
          throw Exception('Invalid API response: missing candidates');
        }
        final candidates = jsonResponse['candidates'] as List;
        if (candidates.isEmpty) {
          throw Exception('No content generated: empty candidates list');
        }
        final content = candidates[0]['content'];
        if (!content.containsKey('parts')) {
          throw Exception('Invalid API response: missing parts in content');
        }
        final parts = content['parts'] as List;
        if (parts.isEmpty) {
          throw Exception('No content generated: empty parts list');
        }
        if (!parts[0].containsKey('text')) {
          throw Exception('Invalid API response: missing text in parts');
        }
        return parts[0]['text'] as String;
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else {
        final errorBody = json.decode(response.body);
        throw Exception('API Error: ${errorBody['error']['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error generating content: $e');
      }
      throw Exception('Failed to generate content: $e');
    }
  }
}
