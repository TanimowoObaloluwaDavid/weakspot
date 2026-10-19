import 'package:flutter/material.dart';
import 'package:weakspot_client/weakspot_client.dart';

import '../main.dart';

/// Screen one of three: paste a syllabus and let the model turn it into
/// topics and questions.
class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key, required this.onBuilt});

  final Future<void> Function(BuildResult result) onBuilt;

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  final _controller = TextEditingController();
  bool _busy = false;
  String? _error;

  /// A short real syllabus so the demo can be run without hunting for one.
  static const String _sample = '''Intro to Computer Networks (CS 201)

Topic: Network Fundamentals
- What a network is, why we build them
- Client-server vs peer-to-peer topologies
- LAN, MAN, WAN and their typical use cases
- Bandwidth, throughput and latency, with the difference between them

Topic: TCP/IP and the OSI Model
- The seven layers of the OSI model and what each one does
- Encapsulation and decapsulation as data moves down and up
- How TCP differs from UDP, and when you would pick each
- The three-way handshake and why a connection is needed at all

Topic: Routing and Addressing
- IPv4 addressing, subnet masks, and CIDR notation
- What a router does versus a switch
- How a packet is forwarded hop by hop across a network
- NAT and why private and public address ranges exist''';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _build() async {
    final text = _controller.text.trim();
    if (text.length < 20) {
      setState(
        () => _error =
            'Paste at least a couple of sentences so there is something to work with.',
      );
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      final result = await client.syllabus.build(
        syllabus: text,
        questionsPerTopic: 3,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      await widget.onBuilt(result);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = _clean(e.toString());
      });
    }
  }

  /// Server errors arrive as long strings; trim them to something readable.
  String _clean(String raw) {
    var message = raw;
    if (message.contains('Exception: ')) {
      message = message.split('Exception: ').last;
    }
    if (message.contains('ServerpodClient')) {
      message = message.split('ServerpodClient').last;
    }
    return message.trim();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pad = width > 640 ? 48.0 : 20.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Your syllabus')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Paste the syllabus you are revising from.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'The model splits it into topics and writes questions for each one.',
                  style: TextStyle(fontSize: 14, color: AppColors.muted),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: _controller,
                  minLines: 10,
                  maxLines: 18,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                  decoration: const InputDecoration(
                    hintText: 'Paste or type your syllabus here...',
                  ),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _busy
                      ? null
                      : () => setState(() => _controller.text = _sample),
                  icon: const Icon(Icons.description_outlined, size: 18),
                  label: const Text('Use the sample syllabus'),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  _ErrorCard(message: _error!),
                ],
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _busy ? null : _build,
                    icon: _busy
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.auto_awesome, size: 20),
                    label: Text(_busy ? 'Building your questions...' : 'Generate'),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Takes 10 to 20 seconds.',
                  style: TextStyle(fontSize: 12, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.weakSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.weak.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: AppColors.weak, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF991B1B),
                fontSize: 13.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
