import 'dart:convert';

import 'package:groq/src/api.dart';
import 'package:groq/src/error.dart';
import 'package:groq/src/model.dart';
import 'package:http/http.dart' as http;

final class ApiClient {
  final String _apiKey;
  final Uri _uri = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

  ApiClient({required String apiKey}) : _apiKey = apiKey;

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
      return GroqResponse.fromJson(jsonDecode(response.body));
    }
    throw parseErrorFor(response.statusCode, jsonDecode(response.body));
  }
}
