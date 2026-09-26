import 'package:anki_flutter/app/anki_desktop_root.dart';
import 'package:anki_flutter/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('production main mounts the desktop Anki root', (tester) async {
    app.main();
    await tester.pump();

    expect(find.byType(AnkiDesktopRoot), findsOneWidget);
  });
}
