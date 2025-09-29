import 'package:flutter_test/flutter_test.dart';
import 'package:team_intelligence/shared/widgets/buttons/primary_button.dart';
import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('PrimaryButton renders correctly', (WidgetTester tester) async {
    bool pressed = false;
    await pumpApp(
      tester,
      PrimaryButton(text: 'Click Me', onPressed: () => pressed = true),
    );

    expect(find.text('Click Me'), findsOneWidget);
    await tester.tap(find.byType(PrimaryButton));
    expect(pressed, isTrue);
  });
}
