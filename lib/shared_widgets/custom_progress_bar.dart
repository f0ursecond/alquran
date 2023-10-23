import 'package:flutter/material.dart';

class CustomProgresBar extends StatefulWidget {
  final double steps;
  final double currentSteps;
  const CustomProgresBar(
      {super.key, required this.steps, required this.currentSteps});
  @override
  State<CustomProgresBar> createState() => _CustomProgresBarState();
}

class _CustomProgresBarState extends State<CustomProgresBar> {
  double widthProgress = 0;

  @override
  void initState() {
    onSizeWidget();
    super.initState();
  }

  void onSizeWidget() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.size is Size) {
        Size size = context.size!;
        widthProgress = size.width / (widget.steps - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 6,
        width: 312,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              width: widthProgress * widget.currentSteps,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
