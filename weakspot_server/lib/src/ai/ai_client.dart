import 'ai_exceptions.dart';
import 'gemini_client.dart';
import 'groq_client.dart';

/// One provider's HTTP plumbing. The rest of the app talks to this, not to
/// Gemini or Groq directly, so swapping providers is a config change rather
/// than a code change.
abstract class AiClient {
  AiClient({required this.apiKey, required this.model});

  final String apiKey;
  final String model;

  /// Human-readable name used in error messages.
  String get providerName;

  /// The key to look for in passwords.yaml.
  String get keyName;

  /// Returns the model's raw text reply. [schema] is enforced by the provider
  /// where it supports structured outputs.
  Future<String> complete({
    required String prompt,
    required Map<String, dynamic> schema,
    double temperature = 0.4,
  });

  /// Trims the key so a blank or whitespace-only entry counts as missing.
  String get effectiveKey => apiKey.trim();

  /// Models sometimes wrap JSON in prose or code fences even when given a
  /// schema, so pull out the first balanced object rather than trusting
  /// verbatim output.
  static String extractJson(String raw) {
    final trimmed = raw.trim();
    final fenceStart = trimmed.indexOf('```');
    var body = trimmed;
    if (fenceStart != -1) {
      final afterFence = trimmed.substring(fenceStart + 3);
      final newline = afterFence.indexOf('\n');
      body = newline == -1 ? afterFence : afterFence.substring(newline + 1);
      final close = body.indexOf('```');
      if (close != -1) body = body.substring(0, close);
    }

    final start = body.indexOf('{');
    if (start == -1) {
      throw AiResponseFormatException('The model did not return JSON.');
    }

    var depth = 0;
    var inString = false;
    var escaped = false;

    for (var i = start; i < body.length; i++) {
      final ch = body[i];
      if (inString) {
        if (escaped) {
          escaped = false;
        } else if (ch == r'\') {
          escaped = true;
        } else if (ch == '"') {
          inString = false;
        }
        continue;
      }
      if (ch == '"') {
        inString = true;
      } else if (ch == '{') {
        depth++;
      } else if (ch == '}') {
        depth--;
        if (depth == 0) return body.substring(start, i + 1);
      }
    }
    throw AiResponseFormatException('The model returned malformed JSON.');
  }

  static String shorten(String body) =>
      body.length <= 400 ? body : '${body.substring(0, 400)}...';
}

/// Builds the right client from config. Adding a third provider means adding a
/// case here and nothing else.
class AiClientFactory {
  static const String groq = 'groq';
  static const String gemini = 'gemini';

  /// Verified to work on the project owner's Groq account.
  ///
  /// Groq's available model list varies by account and region, so a model that
  /// works for one person 404s for another with "does not exist or you do not
  /// have access to it". If generation starts failing with that error, list
  /// your account's models and set `groqModel` in passwords.yaml:
  ///
  ///   curl -H "Authorization: Bearer $GROQ_API_KEY" \
  ///     https://api.groq.com/openai/v1/models
  static const String groqDefaultModel = 'openai/gpt-oss-120b';
  static const String geminiDefaultModel = 'gemini-2.0-flash';

  static AiClient create({
    required String provider,
    required String geminiKey,
    required String groqKey,
    String? geminiModel,
    String? groqModel,
  }) {
    switch (provider.toLowerCase()) {
      case AiClientFactory.gemini:
        return GeminiClient(
          apiKey: geminiKey,
          model: (geminiModel?.trim().isNotEmpty ?? false)
              ? geminiModel!.trim()
              : geminiDefaultModel,
        );
      case AiClientFactory.groq:
      default:
        return GroqClient(
          apiKey: groqKey,
          model: (groqModel?.trim().isNotEmpty ?? false)
              ? groqModel!.trim()
              : groqDefaultModel,
        );
    }
  }
}