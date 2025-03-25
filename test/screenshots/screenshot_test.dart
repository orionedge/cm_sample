@Tags(['golden'])
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cm_sample/main.dart';
void main() {
  testWidgets('Verify initial UI',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    // Normal golden test.
    await expectLater(
      find.byType(MyApp),
      matchesGoldenFile('golden/initial_state.png'),
    );
  });

  testWidgets('Verify incremented UI',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    await expectLater(
      find.byType(MyApp),
      matchesGoldenFile('golden/incremented_state.png'),
    );
  });
}