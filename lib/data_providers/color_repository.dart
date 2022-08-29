import 'dart:convert';
import 'dart:async' show Future;
import 'dart:io';

import 'package:color_randomizer_test_app/data_providers/color_generator.dart';
import 'package:color_randomizer_test_app/models/model_rgb.dart';
import 'package:path_provider/path_provider.dart';

class ColorRepository {
  bool restoreList = true;

  void saveColor(int value) async {
    if (restoreList) {
      try {
        restoreList = false;
        var list = await readLocalFile();
        ColorGenerator.temporaryModelsList.addAll(list);
      } catch (e) {
        print("File does not exist, so we create a new one");
      }
    }

    ColorGenerator.temporaryModelsList.add(ModelRGB(colorNumber: value));
    saveTempListToLocalFile();
  }

  Future<String> _getLocalPath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } catch (e) {
      return Future.error("Local path error");
    }
  }

  Future<File> _getLocalFile() async {
    try {
      final path = await _getLocalPath();
      return File('$path/rgb_values.json');
    } catch (e) {
      return Future.error("Local file error");
    }
  }

  // Запись в хранилище
  Future<File> saveTempListToLocalFile() async {
    try {
      final file = await _getLocalFile();
      final objects =
          ColorGenerator.temporaryModelsList.map((e) => e.toJson()).toList();
      String jsonString = jsonEncode(objects);
      return file.writeAsString(jsonString);
    } catch (e) {
      return Future.error("Write error");
    }
  }

  // Считывание из хранилища
  Future<List<ModelRGB>> readLocalFile() async {
    try {
      final file = await _getLocalFile();
      final contents = await file.readAsString();
      final json = jsonDecode(contents) as List<dynamic>;
      var colors = json
          .map((e) => ModelRGB.fromJson(e as Map<String, dynamic>))
          .toList();
      return colors;
    } catch (e) {
      return Future.error("Read error");
    }
  }

  void saveCOLORS(List<ModelRGB> colors) {}
}
