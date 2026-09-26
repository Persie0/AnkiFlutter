import 'package:anki_flutter/app/anki_desktop_root.dart';
import 'package:anki_flutter/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('desktop startup initializes media before mounting the app',
      (tester) async {
    var initialized = false;

    app.startAnkiFlutter(
      mediaKitInitializer: () {
        expect(find.byType(AnkiDesktopRoot), findsNothing);
        initialized = true;
      },
    );
    await tester.pump();

    expect(initialized, isTrue);
    expect(find.byType(AnkiDesktopRoot), findsOneWidget);
  });
}
