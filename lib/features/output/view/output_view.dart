import 'dart:io';

import 'package:bim429_grup16/features/input/model/food_model.dart';
import 'package:bim429_grup16/features/input/viewmodel/input_view_model.dart';
import 'package:bim429_grup16/features/output/viewmodel/output_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/contents_widget.dart';
import '../widgets/daily_totals_widget.dart';
import '../widgets/montly_totals_widget.dart';

class OutputView extends StatefulWidget {
  final List<FoodModel> foodList;
  const OutputView({super.key, required this.foodList});

  @override
  State<OutputView> createState() => _OutputViewState();
}

class _OutputViewState extends State<OutputView> {
  @override
  void initState() {
    Provider.of<OutputViewModel>(context, listen: false).loadFromSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              const _Image(),
              Contents(widget.foodList),
              DailyTotals(widget.foodList),
              const MonthlyTotals(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return Consumer<InputViewModel>(
      builder: (context, inputViewModel, child) {
        return AspectRatio(
          aspectRatio: 1,
          child: Image.file(
            File(
              inputViewModel.image!.path!,
            ),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
