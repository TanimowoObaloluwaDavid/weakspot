/// Failures from the AI layer.
///
/// Top-level so endpoint analyzers can reference them by type without needing
/// to resolve nested classes across file boundaries.
library;

/// The chosen provider has no API key configured. Reported plainly rather than
/// degrading to canned questions, because a demo that silently fakes its own
/// AI is worse than one that fails loudly.
class MissingApiKeyException implements Exception {
  MissingApiKeyException(this.provider);

  final String provider;

  @override
  String toString() =>
      'No API key configured for $provider.\n\n'
      'Get a free key and add it to weakspot_server/config/passwords.yaml '
      'under the development section:\n'
      '  aiProvider: groq      (or gemini)\n'
      '  groqApiKey: YOUR_KEY  (or geminiApiKey: YOUR_KEY)';
}

/// The provider rejected the call, or returned something unreadable.
class AiRequestFailedException implements Exception {
  AiRequestFailedException(this.provider, this.statusCode, this.body);

  final String provider;
  final int statusCode;
  final String body;

  @override
  String toString() => '$provider request failed ($statusCode)';
}

/// The model replied, but not with a syllabus we could use.
class AiResponseFormatException implements Exception {
  AiResponseFormatException(this.reason);

  final String reason;

  @override
  String toString() => reason;
}