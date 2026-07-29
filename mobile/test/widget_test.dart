import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/app.dart';

void main() {
  testWidgets('ShopAssistantApp loads successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ShopAssistantApp());

    expect(find.byType(ShopAssistantApp), findsOneWidget);
  });
}