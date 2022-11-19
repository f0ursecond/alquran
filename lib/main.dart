import 'package:crud/page/loginpage.dart';
import 'package:crud/provider/app_color.dart';
import 'package:crud/provider/product_provider.dart';
import 'package:crud/provider/quran_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('shopping_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appColor()),
        ChangeNotifierProvider(create: (context) => tColor()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => QuranProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: loginPage(),
          theme: ThemeData.from(
            colorScheme: ColorScheme.light(),
          ).copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              },
            ),
          )),
    );
  }
}
