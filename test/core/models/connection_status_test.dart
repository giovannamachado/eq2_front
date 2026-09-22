import 'package:flutter_test/flutter_test.dart';

import 'package:eq_front/core/models/connection_status.dart';

void main() {
  group('ConnectionStatus', () {
    test('has a human readable label for every value', () {
      for (final status in ConnectionStatus.values) {
        expect(status.label, isNotEmpty);
      }
    });

    test('connected label is distinct from disconnected/error', () {
      expect(ConnectionStatus.connected.label, isNot(ConnectionStatus.disconnected.label));
      expect(ConnectionStatus.connected.label, isNot(ConnectionStatus.error.label));
    });
  });
}
