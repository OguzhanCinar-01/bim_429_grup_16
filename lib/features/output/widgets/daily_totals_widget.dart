import 'package:bim429_grup16/features/output/viewmodel/output_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../input/model/food_model.dart';

class DailyTotals extends StatelessWidget {
  final List<FoodModel> foodList;
  const DailyTotals(this.foodList, {super.key});

  @override
  Widget build(BuildContext context) {
    final outputViewModel = Provider.of<OutputViewModel>(context, listen: false);
    outputViewModel.calculateTotals(foodList);

    return Consumer<OutputViewModel>(
      builder: (context, outputViewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              border: TableBorder.symmetric(
                outside: BorderSide(color: Colors.grey.shade300, width: 1),
                inside: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              children: [
                _buildHeaderRow(),
                _buildSummaryRow('Toplam Kalori', outputViewModel.totalDailyCalories.toStringAsFixed(0)),
                _buildSummaryRow('Toplam Fiyat (₺)', outputViewModel.totalDailyPrice.toStringAsFixed(2)),
                _buildSummaryRow('Menü Fiyatı (₺)', outputViewModel.menuCalculation(foodList).toStringAsFixed(2)),
                _buildSummaryRow(
                  'Menü Tipi',
                  outputViewModel.getMenuType(outputViewModel.menuCalculation(foodList)),
                ),
                _buildSummaryRow('Tasarruf (₺)', outputViewModel.totalDailySavings.toStringAsFixed(2)),
              ],
            ),
          ],
        );
      },
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      children: [
        _buildCell('Günlük Özet Bilgiler', isHeader: true),
        _buildCell('Değerler', isHeader: true),
      ],
    );
  }

  TableRow _buildSummaryRow(String label, String value) {
    return TableRow(
      children: [
        _buildCell(label),
        _buildCell(value),
      ],
    );
  }

  Widget _buildCell(String content, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 12 : 10,
          color: isHeader ? Colors.black : Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
