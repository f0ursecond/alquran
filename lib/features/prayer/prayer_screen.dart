import 'package:alquran/features/prayer/cubit/prayer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../shared_widgets/custom_shimmer_loading.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PrayerCubit()..getPrayerList();

    return Scaffold(
      appBar: AppBar(title: const Text('Doa Doa Harian')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  onFieldSubmitted: (value) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                    suffixIcon: Align(
                      heightFactor: 1.0,
                      widthFactor: 1.0,
                      child: Icon(EvaIcons.search_outline),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<PrayerCubit, PrayerState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is PrayerListSucces) {
                      if (state.listPrayer.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.listPrayer.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.listPrayer[index].title ?? ''),
                              subtitle:
                                  Text(state.listPrayer[index].latin ?? ''),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('Data Not Found'));
                      }
                    } else if (state is PrayerListFailure) {
                      return Text(state.message);
                    } else {
                      return const CustomShimmerLoading();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
