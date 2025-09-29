import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:team_intelligence/app/app.dart';

pumpApp(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(MaterialApp(home: widget));
}
