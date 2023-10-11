import 'package:alquran/constant/route_path.dart';
import 'package:alquran/features/prayer/prayer_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assalamualaikum',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Alif Zulfanur',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          FontAwesome.location_dot,
                          size: 16,
                          color: Colors.red,
                        ),
                        Text('Semarang', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            const PrayerScheduleWidget(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrayerWidget(),
                  QuranWidget(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const QuoteWidget()
          ],
        ),
      ),
    );
  }
}

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ayat Of The Day | Al Baqarah 286'),
              Divider(
                thickness: 1,
                height: 8,
                color: Colors.grey.shade300,
              ),
              Text(
                'لَا يُكَلِّفُ ٱللَّهُ نَفْسًا إِلَّا وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا ٱكْتَسَبَتْ رَبَّنَا لَا تُؤَاخِذْنَآ إِن نَّسِينَآ أَوْ أَخْطَأْنَا رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَآ إِصْرًا كَمَا حَمَلْتَهُۥ عَلَى ٱلَّذِينَ مِن قَبْلِنَا رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِۦ وَٱعْفُ عَنَّا وَٱغْفِرْ لَنَا وَٱرْحَمْنَآ أَنتَ مَوْلَىٰنَا فَٱنصُرْنَا عَلَى ٱلْقَوْمِ ٱلْكَٰفِرِينَ',
                style: GoogleFonts.amiriQuran(fontSize: 16),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 6),
              Divider(
                thickness: 1,
                height: 8,
                color: Colors.grey.shade300,
              ),
              Text(
                'Allah tidak membebani seseorang melainkan sesuai dengan kesanggupannya',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrayerScheduleWidget extends StatelessWidget {
  const PrayerScheduleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(0, -40, 0),
      child: Container(
        width: 312,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
              colors: [Colors.blueAccent, Color.fromARGB(255, 90, 191, 238)]),
        ),
        height: MediaQuery.of(context).size.height * 0.15,
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 24,
          ),
          child: Column(
            children: [
              Expanded(child: Text('Senin, 19 September 2023')),
              Expanded(
                child: Text(
                  '11:45 | Dzuhur',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuranWidget extends StatelessWidget {
  const QuranWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.green,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pushNamed(context, RoutePath.quranScreen);
              },
              child: const Icon(FontAwesome.book_quran, color: Colors.white),
            ),
          ),
        ),
        const Text('Quran'),
      ],
    );
  }
}

class PrayerWidget extends StatelessWidget {
  const PrayerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.green,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrayerScreen(),
                  ),
                );
              },
              child: const Icon(FontAwesome.hands_praying, color: Colors.white),
            ),
          ),
        ),
        const Text(
          'Doa-Doa',
          overflow: TextOverflow.visible,
        ),
      ],
    );
  }
}
