import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../input/model/food_model.dart';

class OutputViewModel extends ChangeNotifier {
  double totalDailyCalories = 0;
  double totalDailyPrice = 0;
  double totalDailySavings = 0;

  double totalMonthlyCalories = 0;
  double totalMonthlyPrice = 0;
  double totalMonthlySavings = 0;

  Future<void> loadFromSharedPreferences() async {
    debugPrint("Loading from SharedPreferences...");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    totalMonthlyCalories = prefs.getDouble('monthlyTotalCalories') ?? 0;
    totalMonthlyPrice = prefs.getDouble('monthlyTotalPrice') ?? 0;
    totalMonthlySavings = prefs.getDouble('monthlyTotalSavings') ?? 0;

    debugPrint("Loaded from SharedPreferences:");
    debugPrint("Monthly Total Calories: $totalMonthlyCalories");
    debugPrint("Monthly Total Price: $totalMonthlyPrice");
    debugPrint("Monthly Total Savings: $totalMonthlySavings");

    notifyListeners();
  }

  Future<void> saveToSharedPreferences(
      double dailyCalories, double dailyPrice, double dailySavings, bool isMonthly) async {
    if (isMonthly) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      double currentCalories = totalMonthlyCalories;
      double currentPrice = totalMonthlyPrice;
      double currentSavings = totalMonthlySavings;

      double newCalories = currentCalories + dailyCalories;
      double newPrice = currentPrice + dailyPrice;
      double newSavings = currentSavings + dailySavings;

      prefs.setDouble('monthlyTotalCalories', newCalories);
      prefs.setDouble('monthlyTotalPrice', newPrice);
      prefs.setDouble('monthlyTotalSavings', newSavings);

      debugPrint("Updated Monthly Totals:");
      debugPrint("Total Monthly Calories: $newCalories");
      debugPrint("Total Monthly Price: $newPrice");
      debugPrint("Total Monthly Savings: $newSavings");

      notifyListeners();
    }
  }

  void calculateTotals(List<FoodModel> foodList) {
    totalDailyCalories = 0;
    totalDailyPrice = 0;

    debugPrint("Calculating totals for the food list:");

    for (var food in foodList) {
      totalDailyCalories += food.calories ?? 0;
      totalDailyPrice += food.price ?? 0;
      debugPrint("Food: ${food.name}, Calories: ${food.calories}, Price: ${food.price}");
    }

    double menuPrice = menuCalculation(foodList);

    if (menuPrice == 0.0) {
      totalDailySavings = 0.0;
      debugPrint("Menu type not valid, no savings.");
    } else {
      totalDailySavings = -1 * (menuPrice - totalDailyPrice);
    }

    debugPrint("Calculated Daily Totals:");
    debugPrint("Total Daily Calories: $totalDailyCalories");
    debugPrint("Total Daily Price: $totalDailyPrice");
    debugPrint("Menu Price: $menuPrice");
    debugPrint("Total Daily Savings: $totalDailySavings");

    saveToSharedPreferences(totalDailyCalories, totalDailyPrice, totalDailySavings, true);
  }

  double menuCalculation(List<FoodModel> foodList) {
    int meatDishes = foodList.where((food) => food.type == 'Etli Yemek').length;
    int noMeatDishes = foodList.where((food) => food.type == 'Etsiz Yemek').length;
    int auxiliaryDishes = foodList.where((food) => food.type == 'Yardımcı Yemek').length;
    int breads = foodList.where((food) => food.name == 'Ekmek').length;
    int waters = foodList.where((food) => food.name == 'Su').length;

    debugPrint("Menu components count: ");
    debugPrint("Etli Yemek: $meatDishes");
    debugPrint("Etsiz Yemek: $noMeatDishes");
    debugPrint("Yardımcı Yemek: $auxiliaryDishes");
    debugPrint("Ekmek: $breads");
    debugPrint("Su: $waters");

    if (meatDishes == 1 && auxiliaryDishes == 3 && breads >= 1 && waters >= 1) {
      debugPrint("Fix Menü seçildi: 132 TL");
      return 132.0;
    } else if (meatDishes == 1 && auxiliaryDishes == 1 && breads >= 1 && waters >= 1) {
      debugPrint("Menü 1 seçildi: 106 TL");
      return 106.0;
    } else if (noMeatDishes == 1 && auxiliaryDishes == 1 && breads >= 1 && waters >= 1) {
      debugPrint("Menü 2 seçildi: 73 TL");
      return 73.0;
    } else if (noMeatDishes == 1 && auxiliaryDishes == 0 && breads >= 1 && waters >= 1) {
      debugPrint("Menü 3 seçildi: 53 TL");
      return 53.0;
    }

    debugPrint("Standart menülere uygun değil.");
    return 0.0;
  }

  String getMenuType(double price) {
    if (price == 132.0) {
      return "Fix Menü";
    } else if (price == 106.0) {
      return "Menü 1";
    } else if (price == 73.0) {
      return "Menü 2";
    } else if (price == 53.0) {
      return "Menü 3";
    } else {
      return "Standart Menülere Uygun Değil";
    }
  }

  void resetState() {
    totalDailyCalories = 0;
    totalDailyPrice = 0;
    totalDailySavings = 0;

    totalMonthlyCalories = 0;
    totalMonthlyPrice = 0;
    totalMonthlySavings = 0;

    debugPrint("State has been reset.");

    notifyListeners();
  }
}
