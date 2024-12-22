class PredictionModel {
  List<Predictions>? predictions;

  PredictionModel({this.predictions});

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      predictions: json['predictions'] != null
          ? (json['predictions'] as List).map((v) => Predictions.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (predictions != null) {
      data['predictions'] = predictions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Predictions {
  double? x;
  double? y;
  double? width;
  double? height;
  double? confidence;
  String? className;
  int? classId;
  String? detectionId;

  Predictions({
    this.x,
    this.y,
    this.width,
    this.height,
    this.confidence,
    this.className,
    this.classId,
    this.detectionId,
  });

  factory Predictions.fromJson(Map<String, dynamic> json) {
    return Predictions(
      x: json['x']?.toDouble(),
      y: json['y']?.toDouble(),
      width: json['width']?.toDouble(),
      height: json['height']?.toDouble(),
      confidence: json['confidence']?.toDouble(),
      className: json['class'],
      classId: json['class_id'],
      detectionId: json['detection_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'confidence': confidence,
      'class': className,
      'class_id': classId,
      'detection_id': detectionId,
    };
  }
}
