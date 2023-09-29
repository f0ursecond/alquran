import 'package:alquran/features/prayer/cubit/prayer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PrayerCubit()..getPrayerList();

    return Scaffold(
      body: BlocBuilder<PrayerCubit, PrayerState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is PrayerListSucces) {
            return ListView.builder(
              itemCount: state.listPrayer.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.listPrayer[index].title ?? ''),
                  subtitle: Text(state.listPrayer[index].latin ?? ''),
                );
              },
            );
          } else if (state is PrayerListFailure) {
            return Text(state.message);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
