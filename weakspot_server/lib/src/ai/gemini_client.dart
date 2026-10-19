import 'dart:convert';
import 'dart:io';

import 'ai_client.dart';
import 'ai_exceptions.dart';

/// Google Gemini, via generateContent with a responseSchema.
class GeminiClient extends AiClient {
  GeminiClient({required super.apiKey, super.model = 'gemini-2.0-flash'});

  @override
  String get providerName => 'Gemini';

  @override
  String get keyName => 'geminiApiKey';

  @override
  Future<String> complete({
    required String prompt,
    required Map<String, dynamic> schema,
    double temperature = 0.4,
  }) async {
    if (effectiveKey.isEmpty) throw MissingApiKeyException(providerName);

    final client = HttpClient();
    try {
      final uri = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/'
        '$model:generateContent',
      );

      final request = await client.postUrl(uri);
      request.headers.set('x-goog-api-key', effectiveKey);
      request.headers.contentType = ContentType.json;
      request.write(
        jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
          'generationConfig': {
            'temperature': temperature,
            'responseMimeType': 'application/json',
            'responseSchema': schema,
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
      final candidates = decoded['candidates'] as List<dynamic>?;
      if (candidates == null || candidates.isEmpty) {
        throw AiRequestFailedException(
          providerName,
          response.statusCode,
          'Empty candidates list',
        );
      }

      final content =
          (candidates.first as Map<String, dynamic>)['content'] as Map<String, dynamic>?;
      final parts = content?['parts'] as List<dynamic>?;
      if (parts == null || parts.isEmpty) {
        throw AiRequestFailedException(providerName, response.statusCode, 'No parts in response');
      }

      final text = (parts.first as Map<String, dynamic>)['text'] as String;
      return text;
    } on FormatException catch (e) {
      throw AiRequestFailedException(providerName, 0, 'Malformed response: ${e.message}');
    } finally {
      client.close(force: true);
    }
  }
}