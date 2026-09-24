import 'package:anki_flutter/app/anki_flutter_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('boots a Material 3 AnkiFlutter shell', (tester) async {
    await tester.pumpWidget(const AnkiFlutterApp(home: Text('Home')));

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'AnkiFlutter');
    expect(materialApp.debugShowCheckedModeBanner, isFalse);
    expect(materialApp.theme?.useMaterial3, isTrue);
    expect(find.text('Home'), findsOneWidget);
  });
}
