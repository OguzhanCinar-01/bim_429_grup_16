import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../features/output/model/prediction_model.dart';

class RoboflowService {
  RoboflowService._privateConstructor();
  static final RoboflowService instance = RoboflowService._privateConstructor();

  Future<PredictionModel?> sendImageToRoboflow(String imagePath) async {
    const String apiUrl = 'https://detect.roboflow.com/veri-madenciligi/2';
    const String apiKey = 'T8jC2xiYa733NgVWNYHX';

    // const String apiUrl = 'https://detect.roboflow.com/food-k7fpo/3';
    // const String apiKey = 'EJcCn6LTSrJ4jUMPjFnW';

    try {
      final Uri uri = Uri.parse('$apiUrl?api_key=$apiKey');
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
      final http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final String responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> data = jsonDecode(responseBody);
        debugPrint('Başarılı Yanıt: $data');
        return PredictionModel.fromJson(data);
      } else {
        debugPrint('Hata: ${response.statusCode}, Mesaj: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      debugPrint('İstek sırasında bir hata oluştu: $e');
      return null;
    }
  }
}
