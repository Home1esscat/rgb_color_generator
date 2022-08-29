import 'dart:async';
import 'dart:math';

import 'package:color_randomizer_test_app/data_providers/color_repository.dart';
import 'package:color_randomizer_test_app/models/model_rgb.dart';
import 'package:flutter/material.dart';

import 'color_repository.dart';

class ColorGenerator extends ChangeNotifier {
  ColorRepository repository = ColorRepository();
  static List<ModelRGB> temporaryModelsList = [];
  late Color _color;

  bool isAutomaticallyEnabled = false;
  Timer? timer;

  ColorGenerator() {
    _color = _getRandomRGBColor();
    saveColorsToRepository(_color.value);
  }

  Color getColor() {
    return _color;
  }

  bool isEnabled() {
    return isAutomaticallyEnabled;
  }

  void changeToogle(bool value) {
    isAutomaticallyEnabled = value;
    value
        ? startAutomaticallyColorChanging()
        : stopAutomaticallyColorChanging();
    notifyListeners();
  }

  void setRandomColor() {
    _color = _getRandomRGBColor();
    saveColorsToRepository(_color.value);
    notifyListeners();
  }

  Color _getRandomRGBColor() {
    int r, g, b;
    const double opacity = 1.0;
    r = Random().nextInt(255);
    g = Random().nextInt(255);
    b = Random().nextInt(255);
    return Color.fromRGBO(r, g, b, opacity);
  }

  void startAutomaticallyColorChanging() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => setRandomColor(),
    );
    notifyListeners();
  }

  void stopAutomaticallyColorChanging() {
    isAutomaticallyEnabled = false;
    timer?.cancel();
    notifyListeners();
  }

  void saveColorsToRepository(int color) {
    repository.saveColor(color);
  }

  Future<List<ModelRGB>> getColors() async {
    var data = await repository.readLocalFile();
    return data;
  }
}
