import 'package:flutter/material.dart';
import 'package:weakspot_client/weakspot_client.dart';

import '../main.dart';

/// Screen two: the weighted round.
///
/// Questions arrive already ordered by need -- the server has pulled from the
/// weakest topics first, so the student spends their time where it pays.
class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.questions,
    required this.subject,
    required this.onFinished,
  });

  final List<Question> questions;
  final String subject;
  final Future<void> Function() onFinished;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;
  int _correct = 0;
  AnswerResult? _result;
  int? _picked;
  bool _busy = false;
  bool _finished = false;

  Question get _current => widget.questions[_index];

  Future<void> _submit(int choice) async {
    setState(() => _busy = true);
    try {
      final result = await client.quiz.submit(
        questionId: _current.id!,
        selectedIndex: choice,
      );
      if (!mounted) return;
      setState(() {
        _result = result;
        _picked = choice;
        _busy = false;
        if (result.isCorrect) _correct++;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save that answer: $e')),
      );
    }
  }

  void _next() {
    if (_index + 1 >= widget.questions.length) {
      setState(() => _finished = true);
    } else {
      setState(() {
        _index++;
        _result = null;
        _picked = null;
      });
    }
  }

  Future<void> _exit() async {
    await widget.onFinished();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject, overflow: TextOverflow.ellipsis),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_index + 1} / ${widget.questions.length}',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child: _finished ? _summary() : _question()),
    );
  }

  Widget _question() {
    final answered = _result != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: (_index) / widget.questions.length,
              minHeight: 6,
              backgroundColor: AppColors.hairline,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brand),
            ),
          ),
          const SizedBox(height: 26),
          Text(
            _current.prompt,
            style: const TextStyle(
              fontSize: 21,
              height: 1.35,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 24),
          for (var i = 0; i < _current.options.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _OptionTile(
                label: _current.options[i],
                index: i,
                answered: answered,
                correctIndex: _result?.correctIndex,
                pickedIndex: _picked,
                onTap: _busy ? null : () => _submit(i),
              ),
            ),
          if (answered) ...[
            const SizedBox(height: 10),
            _Feedback(
              result: _result!,
              onContinue: _next,
              isLast: _index + 1 >= widget.questions.length,
            ),
          ],
        ],
      ),
    );
  }

  Widget _summary() {
    final total = widget.questions.length;
    final percent = ((_correct / total) * 100).round();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_correct of $total correct',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your weak topics have been updated. The next round will pull '
                'from them harder.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.hairline,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percent / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: percent >= 70 ? AppColors.strong : AppColors.mid,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _exit,
                  child: const Text('See my weak topics'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.index,
    required this.answered,
    required this.correctIndex,
    required this.pickedIndex,
    required this.onTap,
  });

  final String label;
  final int index;
  final bool answered;
  final int? correctIndex;
  final int? pickedIndex;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var bg = Colors.white;
    var border = AppColors.hairline;
    Widget? suffixIcon;

    if (answered) {
      final isCorrect = index == correctIndex;
      final isPickedWrong = index == pickedIndex && !isCorrect;
      if (isCorrect) {
        bg = AppColors.strongSoft;
        border = AppColors.strong;
        suffixIcon = const Icon(Icons.check_circle, color: AppColors.strong, size: 20);
      } else if (isPickedWrong) {
        bg = AppColors.weakSoft;
        border = AppColors.weak;
        suffixIcon = const Icon(Icons.cancel, color: AppColors.weak, size: 20);
      }
    }

    final highlighted = answered && (index == correctIndex || index == pickedIndex);

    return InkWell(
      onTap: answered ? null : onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: highlighted ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index == correctIndex && answered
                    ? AppColors.strong
                    : AppColors.hairline,
                shape: BoxShape.circle,
              ),
              child: Text(
                String.fromCharCode(65 + index),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: index == correctIndex && answered
                      ? Colors.white
                      : AppColors.muted,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: AppColors.ink,
                ),
              ),
            ),
            ?suffixIcon,
          ],
        ),
      ),
    );
  }
}

class _Feedback extends StatelessWidget {
  const _Feedback({
    required this.result,
    required this.onContinue,
    required this.isLast,
  });

  final AnswerResult result;
  final VoidCallback onContinue;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final good = result.isCorrect;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: good ? AppColors.strongSoft : AppColors.weakSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                good ? Icons.check_circle : Icons.cancel,
                size: 20,
                color: good ? AppColors.strong : AppColors.weak,
              ),
              const SizedBox(width: 8),
              Text(
                good ? 'Correct' : 'Not quite',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: good ? AppColors.strong : AppColors.weak,
                ),
              ),
              const Spacer(),
              if (result.isTopicWeak)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.weak,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'WEAK TOPIC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
            ],
          ),
          if (result.explanation.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              result.explanation,
              style: const TextStyle(fontSize: 14, height: 1.5, color: AppColors.ink),
            ),
          ],
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onContinue,
              child: Text(isLast ? 'Finish round' : 'Next question'),
            ),
          ),
        ],
      ),
    );
  }
}
