import 'package:flutter_test/flutter_test.dart';
import 'package:guvenli_sehrim/core/app/app.dart';

void main() {
  testWidgets('App shell renders', (WidgetTester tester) async {
    await tester.pumpWidget(const GuvenliSehrimApp());

    expect(find.text('Dashboard'), findsWidgets);
  });
}
