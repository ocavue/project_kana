import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

import 'kana.dart';

abstract class Storage<T> {
  final filename;
  T _data;

  T defaultValue();
  T decode(String s);
  String encode(T t);

  Storage(this.filename) : super();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$filename.txt');
  }

  Future<File> save(T data) async {
    _data = data;
    String str = encode(data);
    final file = await _localFile;
    return file.writeAsString(str);
  }

  Future<T> load() async {
    try {
      if (_data == null) {
        final file = await _localFile;
        String str = await file.readAsString();
        return decode(str);
      } else {
        return _data;
      }
    } catch (e) {
      return defaultValue();
    }
  }
}

class JsonStorage extends Storage<Map> {
  JsonStorage(String filename) : super(filename);
  Map defaultValue() => {};
  Map decode(String s) => jsonDecode(s);
  String encode(Map map) => jsonEncode(map);
}

class KanaScoresStorage extends JsonStorage {
  KanaScoresStorage() : super('kana-scores.v1.json');

  Future<void> loadSorces() async {
    Map map = await load();
    for (final kana in kanas) {
      if (map.containsKey(kana.romaji) &&
          map[kana.romaji].runtimeType == double) {
        kana.score = map[kana.romaji];
      } else {
        kana.score = 0.0;
      }
    }
  }

  Future<void> saveSorces() async {
    Map map = {};
    for (final kana in kanas) {
      map[kana.romaji] = kana.score;
      await save(map);
    }
  }
}

final kanaScoresStorage = KanaScoresStorage();
