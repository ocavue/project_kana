import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project_kana/kana.dart';

void main() {
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((c) async => '/tmp');

  test('Check audio mp3 files', () async {
    final List<String> errorKanaAudioPath = [];

    for (Kana kana in kanas) {
      try {
        // `flutter test` use different directory depending on how test was executed.
        // https://github.com/flutter/flutter/issues/20907
        final f = File('../assets/${kana.audioPath}');
        await f.readAsBytes();
      } catch (e) {
        errorKanaAudioPath.add(kana.audioPath);
      }
    }

    if (errorKanaAudioPath.length >= 1) {
      throw Exception(
        "Can't open kana audio files:\n  ${errorKanaAudioPath.join('\n  ')}",
      );
    }
  });
}
