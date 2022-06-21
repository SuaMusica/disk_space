import 'dart:io';

import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Disk Space Plugin - Test Example', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final textFreeSpace = find.text('Free Space on device (MB): 0.0\n');
    final textTotalSpace = find.text('Total Space on device (MB): 0.0\n');
    final textHasSd = find.text('Has SD: false\n');
    final textFreeSdSpace = find.text('SD Space on device (MB): 0.0\n');
    expect(textFreeSpace, findsOneWidget);
    expect(textTotalSpace, findsOneWidget);
    if (Platform.isAndroid) {
      expect(textHasSd, findsOneWidget);
      expect(textFreeSdSpace, findsOneWidget);
    }

    await tester.pumpAndSettle();

    expect(textFreeSpace, findsNothing);
    expect(textTotalSpace, findsNothing);
    if (Platform.isAndroid) {
      expect(textHasSd, findsNothing);
      expect(textFreeSdSpace, findsNothing);
    }
  });
}
