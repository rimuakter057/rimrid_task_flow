// A basic smoke test that makes sure the TaskFlow app starts up and
// shows the Login screen without crashing.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rimrid_task_flow/main.dart';

void main() {
  testWidgets('App starts on the Login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Log In'), findsOneWidget);
  });
}
