import 'package:weakspot_client/weakspot_client.dart';

/// Mirrors the server's scheduling arithmetic so the UI classifies a topic the
/// same way the picker does. Kept identical on purpose: if these drift, the
/// board would label a topic "solid" while the server keeps drilling it.
extension TopicMasteryView on TopicMastery {
  /// Untouched topics have no evidence yet.
  bool get isUntouched => attempted == 0;

  int get percent {
    if (attempted == 0) return 0;
    return ((correct / attempted) * 100).round();
  }

  bool get isWeak => attempted > 0 && percent < 50;
}
