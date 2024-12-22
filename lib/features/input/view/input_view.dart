import 'package:bim429_grup16/features/input/viewmodel/input_view_model.dart';
import 'package:bim429_grup16/features/output/view/output_view.dart';
import 'package:bim429_grup16/features/output/viewmodel/output_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputView extends StatelessWidget {
  const InputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Consumer2<InputViewModel, OutputViewModel>(
            builder: (context, inputViewModel, outputViewModel, child) {
              return Column(
                children: [
                  _Camera(inputViewModel, outputViewModel),
                  _Galery(inputViewModel, outputViewModel),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Camera extends StatelessWidget {
  final InputViewModel inputViewModel;
  final OutputViewModel outputViewModel;

  const _Camera(this.inputViewModel, this.outputViewModel);

  @override
  Widget build(BuildContext context) {
    return _GeneralButton(
      text: 'Camera',
      onPressed: () async {
        await inputViewModel.pickImageFromCamera();
        if (inputViewModel.image != null) {
          showCustomModalBottomSheet(
            // ignore: use_build_context_synchronously
            context,
            child: OutputView(foodList: inputViewModel.foodList),
          );
        }
      },
      color: Colors.red,
    );
  }
}

class _Galery extends StatelessWidget {
  final InputViewModel inputViewModel;
  final OutputViewModel outputViewModel;

  const _Galery(this.inputViewModel, this.outputViewModel);

  @override
  Widget build(BuildContext context) {
    return _GeneralButton(
      text: 'Galeri',
      onPressed: () async {
        await inputViewModel.pickImageFromGallery();
        if (inputViewModel.image != null) {
          showCustomModalBottomSheet(
            // ignore: use_build_context_synchronously
            context,
            child: OutputView(foodList: inputViewModel.foodList),
          );
        }
      },
      color: Colors.blue,
    );
  }
}

class _GeneralButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const _GeneralButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

void showCustomModalBottomSheet(BuildContext context, {required Widget child}) {
  showModalBottomSheet(
    useSafeArea: true,
    context: context,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (BuildContext context) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            height: MediaQuery.of(context).size.height,
            child: child,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[100]!, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
