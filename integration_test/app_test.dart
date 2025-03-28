import 'package:cm_sample/todos/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:cm_sample/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end Test', () {
    testWidgets('Add, complete, and delete todo', (WidgetTester tester) async {
      // Start the app
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => TodoProvider(),
          child: const MyApp(),
        ),
      );

      // Verify initial state
      expect(find.text('No todos found'), findsOneWidget);

      // Add a new todo
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Integration Test Todo');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify todo is added
      expect(find.text('Integration Test Todo'), findsOneWidget);

      // Complete the todo
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      // Verify it's completed
      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isTrue);

      // Switch to Completed tab to see it there
      await tester.tap(find.text('Completed'));
      await tester.pumpAndSettle();
      expect(find.text('Integration Test Todo'), findsOneWidget);

      // Delete the todo
      await tester.drag(find.byType(Dismissible), const Offset(500, 0));
      await tester.pumpAndSettle();

      // Verify it's deleted
      expect(find.text('Integration Test Todo'), findsNothing);
    });
  });
}