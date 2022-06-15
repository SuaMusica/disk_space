import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Disk Space Plugin', () {
    testWidgets('Test Example', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      FlutterError.onError = (_) => Null;
      final textFreeSpace = find.text('Free Space on device (MB): 0.0\n');
      final textTotalSpace = find.text('Total Space on device (MB): 0.0\n');
      expect(textFreeSpace, findsOneWidget);
      expect(textTotalSpace, findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(Text), findsNWidgets(3));
      expect(textFreeSpace, findsNothing);
      expect(textTotalSpace, findsNothing);
    });
  });
}
