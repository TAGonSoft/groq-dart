import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api.dart';
import 'error.dart';
import 'model.dart';

final class ApiClient {
  final String _apiKey;
  final Uri _uri = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

  ApiClient({required String apiKey}) : _apiKey = apiKey;

  // Send request to Groq API
  Future<GroqResponse> makeRequest({
    required GroqRequest groqRequest,
  }) async {
    final response = await (http.post)(
      _uri,
      headers: {
        ApiHeaderKeys.authorization: ApiHeaderValues.bearer(_apiKey),
        ApiHeaderKeys.contentType: ApiHeaderValues.applicationJson,
      },
      body: jsonEncode(groqRequest),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return GroqResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }
    throw parseErrorFor(
      response.statusCode,
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
