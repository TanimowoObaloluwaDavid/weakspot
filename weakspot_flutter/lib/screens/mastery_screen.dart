import 'package:flutter/material.dart';
import 'package:weakspot_client/weakspot_client.dart';

import '../main.dart';
import '../models/mastery_math.dart';

/// Screen three: the mastery board.
///
/// This is the payoff. Every topic with a bar, weakest first, with the ones
/// doing damage flagged red so the next round can target them.
class MasteryScreen extends StatelessWidget {
  const MasteryScreen({
    super.key,
    required this.report,
    required this.subject,
    required this.onStartRound,
    required this.onNewSyllabus,
  });

  final MasteryReport report;
  final String subject;
  final Future<void> Function() onStartRound;
  final Future<void> Function() onNewSyllabus;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pad = width > 640 ? 48.0 : 20.0;
    final overall = report.totalAttempted == 0
        ? 0
        : ((report.totalCorrect / report.totalAttempted) * 100).round();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(pad, 20, pad, 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.muted,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Where you stand',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'New syllabus',
                    onPressed: onNewSyllabus,
                    icon: const Icon(Icons.refresh, color: AppColors.muted),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _OverallCard(overall: overall, weakCount: report.weakCount),
              const SizedBox(height: 26),
              const Text(
                'TOPIC BREAKDOWN',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 12),
              for (final topic in report.topics)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TopicRow(topic: topic),
                ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onStartRound,
                  icon: const Icon(Icons.bolt, size: 20),
                  label: const Text('Practise my weak topics'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'The next round is weighted toward whatever is red.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.5, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverallCard extends StatelessWidget {
  const _OverallCard({required this.overall, required this.weakCount});

  final int overall;
  final int weakCount;

  @override
  Widget build(BuildContext context) {
    final hasWeak = weakCount > 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasWeak
              ? [const Color(0xFFFEF2F2), const Color(0xFFFFF7ED)]
              : [AppColors.strongSoft, const Color(0xFFF0FDF4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: hasWeak
              ? AppColors.weak.withValues(alpha: 0.25)
              : AppColors.strong.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$overall%',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: hasWeak ? AppColors.weak : AppColors.strong,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasWeak
                ? '$weakCount weak ${weakCount == 1 ? "topic" : "topics"} need attention'
                : 'Everything looks solid so far',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicRow extends StatelessWidget {
  const _TopicRow({required this.topic});

  final TopicMastery topic;

  /// Untouched topics have no evidence, so they read differently from weak ones
  /// rather than being mislabelled as failures.
  ({Color fill, Color text, String label}) _palette(int percent) {
    if (percent >= 70) {
      return (
        fill: AppColors.strong,
        text: AppColors.strong,
        label: 'Solid',
      );
    }
    if (percent >= 50) {
      return (
        fill: AppColors.mid,
        text: AppColors.mid,
        label: 'Shaky',
      );
    }
    return (
      fill: AppColors.weak,
      text: AppColors.weak,
      label: 'Weak',
    );
  }

  @override
  Widget build(BuildContext context) {
    final untouched = topic.attempted == 0;
    final percent = untouched ? 0 : topic.percent;
    final palette = _palette(percent);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: untouched ? AppColors.hairline : palette.fill.withValues(alpha: 0.30),
          width: untouched ? 1 : 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  topic.name,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: untouched ? AppColors.hairline : palette.text,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  untouched ? 'Not started' : '$percent% ${palette.label}',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: untouched ? AppColors.muted : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: untouched ? 0 : percent / 100,
              minHeight: 8,
              backgroundColor: AppColors.hairline,
              valueColor: AlwaysStoppedAnimation<Color>(
                untouched ? AppColors.hairline : palette.fill,
              ),
            ),
          ),
          if (!untouched) ...[
            const SizedBox(height: 8),
            Text(
              '${topic.correct} correct out of ${topic.attempted} attempted'
              '${topic.questionCount > 0 ? "  -  ${topic.questionCount} questions in the bank" : ""}',
              style: const TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ],
        ],
      ),
    );
  }
}
