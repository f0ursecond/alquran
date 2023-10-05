import 'package:alquran/features/quran/cubit/quran_cubit.dart';
import 'package:alquran/features/quran/models/alquran_model.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al Quran'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(EvaIcons.search_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last Read",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                separatorBuilder: (context, _) => const SizedBox(width: 10),
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return const LastReadItemWidget();
                }),
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
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                ),
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
                splashBorderRadius: BorderRadius.circular(10),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFddb892),
                ),
                tabs: const [
                  Tab(text: 'Sura'),
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
                      onRefresh: () {
                        return context.read<QuranCubit>().getListQuran();
                      },
                      child: SurahTabView()),
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
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<QuranCubit>(context);
    return BlocProvider.value(
      value: cubit..getListQuran(),
      child: BlocConsumer<QuranCubit, QuranState>(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is QuranSuccess) {
            return state.resultList.isNotEmpty
                ? ListView.builder(
                    itemCount: state.resultList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = state.resultList[index];
                      return cardSurahItem(data);
                    },
                  )
                : const Text('Kosong');
          } else if (state is QuranFailure) {
            return Text(state.message);
          } else {
            return const CustomShimmerLoading();
          }
        },
      ),
    );
  }

  Card cardSurahItem(Quran data) {
    return Card(
      elevation: 0,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFe6ccb2),
        child: InkWell(
          hoverColor: const Color(0xFFede0d4),
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
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

class LastReadItemWidget extends StatelessWidget {
  const LastReadItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFe6ccb2),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Al-Mumtahanah'),
          ],
        ),
      ),
    );
  }
}
