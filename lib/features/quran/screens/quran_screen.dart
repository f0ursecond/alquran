// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:alquran/features/quran/cubit/quran_cubit.dart';
import 'package:alquran/features/quran/models/alquran_model.dart';
import 'package:alquran/features/quran/screens/quran_detail_screen.dart';
import 'package:alquran/shared_widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchCubit = _SearchCubit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al Quran'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              onChanged: searchCubit.search,
              decoration: const InputDecoration(
                focusColor: Color(0xFF7f5539),
                prefixIcon: Align(
                    heightFactor: 1,
                    widthFactor: 1,
                    alignment: Alignment.center,
                    child: Icon(EvaIcons.search_outline)),
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF7f5539),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _tabController,
                unselectedLabelStyle:
                    GoogleFonts.poppins(fontWeight: FontWeight.w400),
                labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                splashBorderRadius: BorderRadius.circular(10),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFddb892),
                ),
                tabs: const [
                  Tab(text: 'Surah'),
                  Tab(text: 'Juz'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  RefreshIndicator(
                    onRefresh: () => context.read<QuranCubit>().getListQuran(),
                    child: SurahTabView(
                      searchCubit: searchCubit,
                    ),
                  ),
                  Text('Juz'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SurahTabView extends StatelessWidget {
  SurahTabView({
    super.key,
    required this.searchCubit,
  });

  final _SearchCubit searchCubit;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<QuranCubit>(context);

    return BlocProvider.value(
      value: cubit..getListQuran(),
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranSuccess) {
            return BlocBuilder<_SearchCubit, String>(
              bloc: searchCubit,
              builder: (context, query) {
                var raw = state.resultList;
                var filteredList = raw
                    .where((element) => element.namaLatin!
                        .toLowerCase()
                        .replaceAll('-', '')
                        .replaceAll("'", '')
                        .contains(query.toLowerCase()))
                    .toList();
                return filteredList.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = filteredList[index];
                          return cardSurahItem(
                            data,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuranDetailScreen(
                                    id: data.nomor!,
                                    surat: data.namaLatin!,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const Text('Hasil Pencarian Tidak Ditemukan');
              },
            );
          } else if (state is QuranFailure) {
            return Text(state.message);
          } else {
            return const CustomShimmerLoading();
          }
        },
      ),
    );
  }

  Card cardSurahItem(Quran data, Function() ontap) {
    return Card(
      elevation: 0,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFe6ccb2),
        child: InkWell(
          hoverColor: const Color(0xFFede0d4),
          borderRadius: BorderRadius.circular(8),
          onTap: ontap,
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage('assets/icons/ic_number.png'),
              child: Text(
                data.nomor.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.namaLatin ?? ''),
                Text(
                  '${data.jumlahAyat} Ayat | ${data.tempatTurun}',
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
            trailing: Text(
              data.nama ?? '',
              style: GoogleFonts.amiriQuran(fontSize: 20),
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchCubit extends Cubit<String> {
  _SearchCubit() : super('');

  void search(String query) {
    emit(query.toLowerCase());
  }
}
