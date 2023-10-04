import 'package:alquran/features/prayer/cubit/prayer_cubit.dart';
import 'package:alquran/features/prayer/model/prayer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../shared_widgets/custom_shimmer_loading.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PrayerCubit>(context);
    final searchController = TextEditingController();
    final search = _SearchCubit();

    return Scaffold(
      appBar: AppBar(title: const Text('Doa Doa Harian')),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<PrayerCubit>().getPrayerList();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: search.search,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: 'Search',
                      suffixIcon: Align(
                        heightFactor: 1.0,
                        widthFactor: 1.0,
                        child: Icon(EvaIcons.search_outline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocProvider.value(
                    value: cubit..getPrayerList(),
                    child: BlocBuilder<PrayerCubit, PrayerState>(
                      builder: (context, state) {
                        if (state is PrayerListSucces) {
                          return BlocBuilder<_SearchCubit, String>(
                            bloc: search,
                            builder: (context, query) {
                              var raw = state.listPrayer;
                              var filteredList = raw
                                  .where((element) => element.title!
                                      .toLowerCase()
                                      .contains(query.toLowerCase()))
                                  .toList();
                              if (filteredList.isNotEmpty) {
                                return ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 10);
                                  },
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, index) {
                                    var data = filteredList[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Theme(
                                        data: ThemeData().copyWith(
                                          dividerColor: Colors.transparent,
                                        ),
                                        child: ExpansionTile(
                                          title: Text(
                                            data.title ?? '',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          children: [
                                            ExpansionTileContent(data: data)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child:
                                      Text('Hasil Pencarian Tidak Ditemukan'),
                                );
                              }
                            },
                          );
                        } else if (state is PrayerListFailure) {
                          return Text(state.message);
                        } else if (state is PrayerListLoading) {
                          return const CustomShimmerLoading();
                        } else {
                          return const CustomShimmerLoading();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpansionTileContent extends StatelessWidget {
  const ExpansionTileContent({
    super.key,
    required this.data,
  });

  final Prayer data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.end,
              data.arabic ?? '',
              overflow: TextOverflow.visible,
              style: GoogleFonts.amiriQuran(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(data.translation ?? '')
        ],
      ),
    );
  }
}

class _SearchCubit extends Cubit<String> {
  _SearchCubit() : super("");

  void search(String query) {
    emit(query.toLowerCase());
  }
}
