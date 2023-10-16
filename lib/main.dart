import 'package:alquran/config/router.dart';
import 'package:alquran/config/theme.dart';
import 'package:alquran/constant/route_path.dart';
import 'package:alquran/core/authentication/cubit/register_cubit.dart';
import 'package:alquran/features/prayer/cubit/prayer_cubit.dart';
import 'package:alquran/features/quran/cubit/quran_cubit.dart';
import 'package:alquran/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/quran/cubit/quran_detail_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PrayerCubit(),
        ),
        BlocProvider(
          create: (context) => QuranCubit(),
        ),
        BlocProvider(
          create: (context) => QuranDetailCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: myTheme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: RoutePath.splashScreen,
      ),
    );
  }
}
