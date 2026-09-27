import 'package:anki_flutter/app/anki_desktop_root.dart';
import 'package:anki_flutter/app/anki_flutter_app.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  startAnkiFlutter();
}

void startAnkiFlutter({void Function()? mediaKitInitializer}) {
  WidgetsFlutterBinding.ensureInitialized();
  (mediaKitInitializer ?? () => MediaKit.ensureInitialized())();
  runApp(const AnkiFlutterApp(home: AnkiDesktopRoot()));
}
