import 'package:flutter/material.dart';

import '../../input/model/food_model.dart';

class Contents extends StatelessWidget {
  final List<FoodModel> foodList;

  const Contents(this.foodList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(
        outside: BorderSide(color: Colors.grey.shade300, width: 1),
        inside: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      children: [
        _buildHeaderRow(),
        ..._buildDataRows(),
      ],
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      children: [
        _buildCell('Adet', isHeader: true),
        _buildCell('Yemek Adı', isHeader: true),
        _buildCell('Türü', isHeader: true),
        _buildCell('Kalori (kcal)', isHeader: true),
        _buildCell('Fiyat (₺)', isHeader: true),
      ],
    );
  }

  List<TableRow> _buildDataRows() {
    return foodList.map((food) {
      return TableRow(
        children: [
          _buildCell('1'),
          _buildCell(food.name ?? 'Bilinmiyor'),
          _buildCell(food.type ?? 'Bilinmiyor'),
          _buildCell(food.calories?.toString() ?? '0'),
          _buildCell(food.price?.toStringAsFixed(2) ?? '0.00'),
        ],
      );
    }).toList();
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
