import 'package:bim429_grup16/features/output/viewmodel/output_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyTotals extends StatelessWidget {
  const MonthlyTotals({super.key});

  @override
  Widget build(BuildContext context) {
    final outputViewModel = Provider.of<OutputViewModel>(context, listen: false);
    outputViewModel.loadFromSharedPreferences();
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
                _buildSummaryRow('Aylık Toplam Kalori',
                    (outputViewModel.totalMonthlyCalories).toStringAsFixed(0)),
                _buildSummaryRow('Aylık Toplam Maliyet (₺)',
                    (outputViewModel.totalMonthlyPrice).toStringAsFixed(2)),
                _buildSummaryRow('Aylık Toplam Tasarruf (₺)',
                    (outputViewModel.totalMonthlySavings).toStringAsFixed(2)),
              ],
            ),
            const SizedBox(height: 16),
            _buildDisclaimer(),
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
        _buildCell('Aylık Özet Bilgiler', isHeader: true),
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

  Widget _buildDisclaimer() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Yukarıdaki hesaplamalar, yemeklerin tamamının yenildiği varsayımı ile yapılmıştır.',
        style: TextStyle(fontSize: 12, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
