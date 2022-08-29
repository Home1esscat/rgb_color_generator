class ModelRGB {
  int colorNumber;

  ModelRGB({required this.colorNumber});

  factory ModelRGB.fromJson(Map<String, dynamic> json) {
    return ModelRGB(colorNumber: json['modelRGB'] as int);
  }

  Map<String, dynamic> toJson() {
    return <String, int>{
      'modelRGB': colorNumber,
    };
  }
}
