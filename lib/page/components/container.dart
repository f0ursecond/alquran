import 'package:flutter/material.dart';

class anjay extends StatelessWidget {
  const anjay({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.transparent),
      child: child,
    );
  }
}
