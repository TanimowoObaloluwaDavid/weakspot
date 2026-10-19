// A CLI diagnostic, not library code: stdout IS the output channel here.
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:weakspot_server/src/ai/ai_client.dart';
import 'package:weakspot_server/src/ai/groq_client.dart';

/// Checks the configured Groq account end to end using the real client and the
/// real schema, without needing the database or the running server.
///
///   dart run tool/verify_groq.dart
///
/// Set GROQ_API_KEY in the environment, or leave it and the client reports a
/// missing key. No secret is hardcoded in this file on purpose.
Future<void> main(List<String> args) async {
  final key = Platform.environment['GROQ_API_KEY'] ?? '';
  final model = args.isNotEmpty ? args.first : AiClientFactory.groqDefaultModel;
  final client = GroqClient(apiKey: key, model: model);

  final stopwatch = Stopwatch()..start();

  try {
    final content = await client.complete(
      prompt: _prompt,
      schema: _schema,
    );
    stopwatch.stop();

    print('provider : ${client.providerName}');
    print('model    : $model');
    print('elapsed  : ${stopwatch.elapsedMilliseconds}ms');
    print('');

    _report(content);
  } on Object catch (e) {
    stopwatch.stop();
    print('provider : ${client.providerName}');
    print('model    : $model');
    print('elapsed  : ${stopwatch.elapsedMilliseconds}ms');
    print('FAILED   : $e');
    exitCode = 1;
  }
}

void _report(String content) {
  final decoded = jsonDecode(content);
  if (decoded is! Map<String, dynamic>) {
    print('FAILED: top level JSON was ${decoded.runtimeType}, expected a map');
    exitCode = 1;
    return;
  }

  final topics = decoded['topics'];
  if (topics is! List) {
    print('FAILED: "topics" was ${topics.runtimeType}, expected a list');
    exitCode = 1;
    return;
  }

  var questions = 0;
  var bad = 0;

  for (final rawTopic in topics) {
    if (rawTopic is! Map<String, dynamic>) continue;
    final name = rawTopic['name'] ?? '(unnamed)';
    print('* $name');

    final rawQuestions = rawTopic['questions'];
    if (rawQuestions is! List) continue;

    for (final rawQuestion in rawQuestions) {
      if (rawQuestion is! Map<String, dynamic>) continue;
      questions++;

      final prompt = rawQuestion['prompt'];
      final options = rawQuestion['options'];
      final correct = rawQuestion['correctIndex'];
      final why = rawQuestion['explanation'];

      print('   Q: $prompt');
      if (options is List) {
        for (var i = 0; i < options.length; i++) {
          final mark = i == correct ? '*' : ' ';
          print('      $mark ${options[i]}');
        }
        if (options.length != 4) {
          bad++;
          print('   !! expected 4 options, got ${options.length}');
        }
      } else {
        bad++;
        print('   !! "options" was ${options.runtimeType}, expected a list');
      }

      if (correct is! int || correct < 0) {
        bad++;
        print('   !! "correctIndex" was $correct');
      }
      if (why is! String || why.isEmpty) {
        bad++;
        print('   !! "explanation" was $why');
      }
    }
  }

  print('');
  print('topics   : ${topics.length}');
  print('questions: $questions');
  print('malformed: $bad');

  if (topics.isEmpty) {
    print('FAILED: no topics came back');
    exitCode = 1;
  } else if (bad > 0) {
    print('FAILED: $bad malformed question(s) would have been dropped');
    exitCode = 1;
  } else {
    print('OK: every question parsed and validated');
  }
}

const _schema = {
  'type': 'object',
  'properties': {
    'subject': {'type': 'string'},
    'topics': {
      'type': 'array',
      'items': {
        'type': 'object',
        'properties': {
          'name': {'type': 'string'},
          'questions': {
            'type': 'array',
            'items': {
              'type': 'object',
              'properties': {
                'prompt': {'type': 'string'},
                'options': {
                  'type': 'array',
                  'items': {'type': 'string'},
                },
                'correctIndex': {'type': 'integer'},
                'explanation': {'type': 'string'},
              },
              'required': ['prompt', 'options', 'correctIndex', 'explanation'],
            },
          },
        },
        'required': ['name', 'questions'],
      },
    },
  },
  'required': ['subject', 'topics'],
};

const _prompt = '''
You are an exam question writer. Read the syllabus and produce 2
multiple-choice questions per topic.

Syllabus:
"""
Intro to Computer Networks (CS 201)

Topic: Network Fundamentals
- What a network is, and why we build them
- Client-server vs peer-to-peer topologies
- LAN, MAN, WAN and their typical use cases
- Bandwidth, throughput and latency

Topic: TCP/IP and the OSI Model
- The seven layers of the OSI model
- Encapsulation and decapsulation
- How TCP differs from UDP, and when to pick each
- The three-way handshake

Topic: Routing and Addressing
- IPv4 addressing, subnet masks and CIDR notation
- What a router does versus a switch
- How a packet is forwarded hop by hop
- NAT and private vs public address ranges
"""

Rules:
- Topics must come only from the syllabus text.
- Exactly 4 options per question.
- Plausible distractors, never "All of the above".
- One sentence explaining why the correct answer is correct.
''';