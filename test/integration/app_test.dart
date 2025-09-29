import 'package:flutter_test/flutter_test.dart';
import 'package:team_intelligence/app/app.dart';
import '../helpers/pump_app.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await pumpApp(tester, const App());
    expect(find.byType(App), findsOneWidget);
  });
}
