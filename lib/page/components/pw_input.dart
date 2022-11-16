import 'package:crud/page/components/container.dart';
import 'package:crud/provider/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Password extends StatefulWidget {
  const Password({Key? key, required this.icon, required this.hint})
      : super(key: key);

  final IconData icon;
  final String hint;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return anjay(
      child: Consumer2<appColor, tColor>(
        builder: ((context, appColor, tColor, child) => TextField(
            style: TextStyle(color: tColor.warna),
            obscureText: _obsecureText,
            cursorColor: tColor.warna,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: tColor.warna,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecureText = !_obsecureText;
                        });
                      },
                      icon: _obsecureText
                          ? Icon(
                              Icons.visibility_off,
                              color: tColor.warna,
                            )
                          : Icon(
                              Icons.visibility,
                              color: tColor.warna,
                            )),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: tColor.warna)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: tColor.warna, width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: tColor.warna,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: widget.hint,
                hintStyle: (TextStyle(color: tColor.warna))))),
      ),
    );
  }
}
