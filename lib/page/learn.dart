import 'package:crud/provider/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class learn extends StatelessWidget {
  const learn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<appColor, tColor>(
      builder: (context, appColor, tColor, _) => Scaffold(
        backgroundColor: appColor.color,
        appBar: AppBar(
          title: Text('beningg <3',
              style: GoogleFonts.inter(
                letterSpacing: 1,
                color: appColor.color,
              )),
          backgroundColor: Colors.greenAccent,
          elevation: 0,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Aku Sayang Bening banyak banyak <3',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                    color: tColor.warna,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Light Mode',
                          style: GoogleFonts.inter(
                            letterSpacing: 0.4,
                            color: tColor.warna,
                          )),
                    ),
                    FlutterSwitch(
                        value: appColor.isThemeDark,
                        onToggle: (newValue) {
                          appColor.isThemeDark = newValue;
                          tColor.isTextDark = newValue;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Dark Mode',
                          style: GoogleFonts.inter(
                            letterSpacing: 0.4,
                            color: tColor.warna,
                          )),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
