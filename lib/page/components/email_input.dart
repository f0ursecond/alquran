import 'package:crud/page/components/container.dart';
import 'package:crud/provider/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoundedInput extends StatefulWidget {
  const RoundedInput({Key? key, required this.icon, required this.hint})
      : super(key: key);

  final IconData icon;
  final String hint;

  @override
  State<RoundedInput> createState() => _RoundedInputState();
}

class _RoundedInputState extends State<RoundedInput> {
  @override
  Widget build(BuildContext context) {
    return anjay(
        child: Consumer2<appColor, tColor>(
      builder: (context, appColor, tColor, child) => TextField(
          style: TextStyle(color: tColor.warna),
          cursorColor: tColor.warna,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: tColor.warna,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: tColor.warna)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: tColor.warna, width: 2.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: tColor.warna),
                borderRadius: BorderRadius.circular(15.0),
              ),
              hintText: 'Masukan Email Anda',
              hintStyle: TextStyle(color: tColor.warna))),
    ));
  }
}
