import 'dart:convert';
import 'dart:io';

import 'ai_client.dart';
import 'ai_exceptions.dart';

/// Groq, via its OpenAI-compatible chat completions endpoint.
///
/// Free tier, very fast, and supports `json_schema` structured outputs, so the
/// model is constrained to the shape we expect instead of being asked nicely.
class GroqClient extends AiClient {
  GroqClient({required super.apiKey, super.model = AiClientFactory.groqDefaultModel});

  static const String baseUrl = 'https://api.groq.com/openai/v1/chat/completions';

  @override
  String get providerName => 'Groq';

  @override
  String get keyName => 'groqApiKey';

  @override
  Future<String> complete({
    required String prompt,
    required Map<String, dynamic> schema,
    double temperature = 0.4,
  }) async {
    if (effectiveKey.isEmpty) throw MissingApiKeyException(providerName);

    final client = HttpClient();
    try {
      final request = await client.postUrl(Uri.parse(baseUrl));
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $effectiveKey');
      request.headers.contentType = ContentType.json;
      request.write(
        jsonEncode({
          'model': model,
          'messages': [
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'temperature': temperature,
          'response_format': {
            'type': 'json_schema',
            'json_schema': {
              'name': 'generated_syllabus',
              'strict': false,
              'schema': schema,
            },
          },
        }),
      );

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      if (response.statusCode != 200) {
        throw AiRequestFailedException(
          providerName,
          response.statusCode,
          AiClient.shorten(body),
        );
      }

      final decoded = jsonDecode(body) as Map<String, dynamic>;
      final choices = decoded['choices'] as List<dynamic>?;
      if (choices == null || choices.isEmpty) {
        throw AiRequestFailedException(
          providerName,
          response.statusCode,
          'No choices in response',
        );
      }

      final message =
          (choices.first as Map<String, dynamic>)['message'] as Map<String, dynamic>?;
      final content = message?['content'] as String?;

      if (content == null || content.isEmpty) {
        throw AiRequestFailedException(
          providerName,
          response.statusCode,
          'Empty message content',
        );
      }

      return content;
    } on FormatException catch (e) {
      throw AiRequestFailedException(providerName, 0, 'Malformed response: ${e.message}');
    } finally {
      client.close(force: true);
    }
  }
}