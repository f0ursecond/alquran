import 'package:alquran/features/quran/cubit/quran_detail_cubit.dart';
import 'package:alquran/features/quran/models/alquran_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class QuranDetailScreen extends StatelessWidget {
  const QuranDetailScreen({super.key, required this.id, required this.surat});
  final int id;
  final String surat;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<QuranDetailCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat $surat'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => cubit.getQuranById(id),
          child: BlocProvider.value(
            value: cubit..getQuranById(id),
            child: BlocBuilder<QuranDetailCubit, QuranDetailState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is QuranDetailSuccess) {
                  var data = state.result;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.result.namaLatin,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.ayat.length,
                            itemBuilder: (context, index) {
                              return AyatItemWidget(
                                data: data,
                                index: index,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AyatItemWidget extends StatelessWidget {
  const AyatItemWidget({
    super.key,
    required this.data,
    required this.index,
  });

  final ResQuranDetail data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF7f5539),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            data.ayat[index].nomorAyat.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  overflow: TextOverflow.visible,
                  data.ayat[index].teksArab,
                  style: GoogleFonts.amiriQuran(fontSize: 24),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data.ayat[index].teksIndonesia,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
