import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeigt = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Title(),
                SizedBox(
                  height: sizeHeigt / 28,
                ),
                const subTitle(),
                SizedBox(
                  height: sizeHeigt / 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF863ED5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: sizeWidth * 0.6,
                  height: sizeHeigt * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      insideContainer(sizeHeigt: sizeHeigt),
                      Image.asset('assets/images/kitab.png'),
                    ],
                  ),
                ),
                buttonContainer(
                  sizeWidth: sizeWidth,
                  sizeHeigt: sizeHeigt,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(0, 20, 0),
      child: Text(
        'Quran App',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}

class subTitle extends StatelessWidget {
  const subTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(0, 30, 0),
      child: Column(
        children: [
          Text(
            'Learn Quran and',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'Recite once everyday',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class insideContainer extends StatelessWidget {
  const insideContainer({
    Key? key,
    required this.sizeHeigt,
  }) : super(key: key);

  final double sizeHeigt;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/awan.png'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: sizeHeigt / 11),
              child: Image.asset(
                'assets/images/awansatu.png',
              ),
            ),
          ],
        ),
        Transform(
          transform: Matrix4.translationValues(0, -50, 0),
          child: Image.asset(
            'assets/images/star.png',
          ),
        ),
      ],
    );
  }
}

class buttonContainer extends StatelessWidget {
  const buttonContainer({
    Key? key,
    required this.sizeWidth,
    required this.sizeHeigt,
  }) : super(key: key);

  final double sizeWidth;
  final double sizeHeigt;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(0, -22, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9B091),
          borderRadius: BorderRadius.circular(50),
        ),
        width: sizeWidth * 0.3,
        height: sizeHeigt / 15,
        child: Center(
          child: Text(
            'Get Started',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
