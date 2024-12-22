import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/init/network/roboflow_service.dart';
import '../../output/model/prediction_model.dart';
import '../model/food_model.dart';
import '../model/input_model.dart';

class InputViewModel with ChangeNotifier {
  List<FoodModel> foodList = [];
  InputModel? _image;
  final ImagePicker _picker = ImagePicker();
  InputModel? get image => _image;

  Future<void> pickImageFromGallery() async {
    try {
      debugPrint("Picking image from gallery...");
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = InputModel(path: pickedFile.path, source: 'gallery');
        debugPrint('Selected Image Path: ${_image!.path}');
        debugPrint("Sending image to Roboflow: ${_image!.path}");
        final predictionModel = await RoboflowService.instance.sendImageToRoboflow(_image!.path!);
        debugPrint("Image sent successfully to Roboflow");
        String excelFilePath = "assets/tables/food_list.xlsx";
        debugPrint("Comparing predictions with Excel file: $excelFilePath");
        foodList.clear();
        await compareWithExcel(predictionModel!, excelFilePath);
        notifyListeners();
      } else {
        debugPrint("No image selected from gallery");
      }
    } catch (e) {
      debugPrint("Gallery error: $e");
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      debugPrint("Picking image from camera...");
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _image = InputModel(path: pickedFile.path, source: 'camera');
        debugPrint('Selected Image Path: ${_image!.path}');
        debugPrint("Sending image to Roboflow: ${_image!.path}");
        final predictionModel = await RoboflowService.instance.sendImageToRoboflow(_image!.path!);
        debugPrint("Image sent successfully to Roboflow");
        String excelFilePath = "your_excel_file_path_here";
        debugPrint("Comparing predictions with Excel file: $excelFilePath");
        foodList.clear();
        await compareWithExcel(predictionModel!, excelFilePath);
        notifyListeners();
      } else {
        debugPrint("No image captured from camera");
      }
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  Future<void> compareWithExcel(PredictionModel predictionModel, String excelFilePath) async {
    try {
      debugPrint("Comparing predictions with Excel file...");
      final data = await rootBundle.load('assets/tables/food_list.xlsx');
      final bytes = data.buffer.asUint8List();
      final excel = Excel.decodeBytes(bytes);

      Map<String, Map<String, String>> excelData = {};
      for (var table in excel.tables.keys) {
        debugPrint("Processing table: $table");
        for (var row in excel.tables[table]!.rows) {
          if (row.isNotEmpty && row[0] != null) {
            final excelId = row[0]!.value.toString().trim();
            debugPrint("Row data for ID: $excelId");
            excelData[excelId] = {
              'Yemek Adi': row[1]?.value.toString() ?? 'Bilinmiyor',
              'Tür': row[2]?.value.toString() ?? 'Bilinmiyor',
              'Kalori': row[3]?.value.toString() ?? '0',
              'Fiyat': row[4]?.value.toString() ?? '0',
            };
          }
        }
      }

      debugPrint("Processing predictions...");
      for (var prediction in predictionModel.predictions ?? []) {
        final id = prediction.classId?.toString().trim() ?? 'Bilinmiyor';
        debugPrint("Processing prediction for ID: $id");
        if (excelData.containsKey(id)) {
          debugPrint("Found matching data in Excel for ID: $id");
          foodList.add(FoodModel(
            name: prediction.className ?? 'Bilinmiyor',
            type: excelData[id]!['Tür']!,
            calories: double.tryParse(excelData[id]!['Kalori']!) ?? 0.0,
            price: double.tryParse(excelData[id]!['Fiyat']!) ?? 0.0,
          ));
        } else {
          debugPrint("No matching data in Excel for ID: $id");
          foodList.add(FoodModel(
            name: prediction.className ?? 'Bilinmiyor',
            type: 'Bilinmiyor',
            calories: 0.0,
            price: 0.0,
          ));
        }
      }
      debugPrint("Finished processing all predictions");
      notifyListeners();
    } catch (e) {
      debugPrint("Error during Excel comparison: $e");
    }
  }
}
