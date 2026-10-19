import 'package:flutter/material.dart';
import 'package:weakspot_client/weakspot_client.dart';

import '../main.dart';
import 'mastery_screen.dart';
import 'quiz_screen.dart';
import 'syllabus_screen.dart';

/// Entry point. Picks where to start based on whether a syllabus has already
/// been built, so a returning student lands straight on their weak topics.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MasteryReport? _report;
  bool _loading = true;
  String? _subject;

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  Future<void> _loadReport() async {
    try {
      final report = await client.quiz.report();
      if (!mounted) return;
      setState(() {
        _report = report;
        _loading = false;
        if (report.topics.isNotEmpty) _subject = report.topics.first.subject;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _onBuilt(BuildResult result) async {
    setState(() {
      _subject = result.subject;
    });
    await _openQuiz(result.firstRound);
  }

  Future<void> _openQuiz(List<Question> questions) async {
    if (questions.isEmpty) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizScreen(
          questions: questions,
          subject: _subject ?? 'Revision',
          onFinished: _refreshAfterRound,
        ),
      ),
    );
    await _refreshAfterRound();
  }

  Future<void> _refreshAfterRound() async {
    try {
      final report = await client.quiz.report();
      if (!mounted) return;
      setState(() => _report = report);
    } catch (_) {
      // Leave the previous report in place; the UI still works without it.
    }
  }

  Future<void> _startRound() async {
    try {
      final questions = await client.quiz.next(count: 5);
      if (!mounted) return;
      if (questions.isEmpty) {
        _showSnack('No questions available yet. Paste a syllabus first.');
        return;
      }
      await _openQuiz(questions);
    } catch (e) {
      if (!mounted) return;
      _showSnack('Could not load the next round: $e');
    }
  }

  Future<void> _newSyllabus() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SyllabusScreen(onBuilt: _onBuilt),
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final hasData = _report != null && _report!.topics.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: hasData
            ? MasteryScreen(
                report: _report!,
                subject: _subject ?? 'Revision',
                onStartRound: _startRound,
                onNewSyllabus: _newSyllabus,
              )
            : _Welcome(onStart: _newSyllabus),
      ),
    );
  }
}

class _Welcome extends StatelessWidget {
  const _Welcome({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pad = width > 640 ? 48.0 : 20.0;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: pad, vertical: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.brand.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'ADAPTIVE REVISION',
                  style: TextStyle(
                    color: AppColors.brand,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Stop revising everything equally.',
                style: TextStyle(
                  fontSize: 32,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Most students spread their revision evenly across every topic, '
                'then walk into the exam weakest in exactly the parts they '
                'neglected.\n\nWeakSpot finds the topics you keep getting wrong '
                'and pulls them back in until they are solid.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.55,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: onStart,
                icon: const Icon(Icons.auto_awesome, size: 20),
                label: const Text('Build my question set'),
              ),
              const SizedBox(height: 14),
              const Text(
                'Takes about 30 seconds. Paste your syllabus and start.',
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
