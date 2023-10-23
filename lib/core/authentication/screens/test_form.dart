// ignore_for_file: unused_field

import 'package:alquran/core/user/cubit/user_cubit.dart';
import 'package:alquran/shared_widgets/custom_shimmer_loading.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class TestFormPage extends StatelessWidget {
  TestFormPage({super.key});
  final cubit = UserCubit()..getUsers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          cubit.getUsers();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24,
              ),
              child: Column(
                children: [
                  BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state is UserDeleteSuccess) {
                        Flushbar(
                          title: 'Congratulations!',
                          message: 'User ${state.name} has been deleted',
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      }
                    },
                    bloc: cubit,
                    builder: (context, state) {
                      if (state is UserSuccess) {
                        if (state.result.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.result.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = state.result[index];
                              return Card(
                                elevation: 1,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(data.id),
                                  ),
                                  title: Text(data.name),
                                  subtitle: Text(data.age),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      print('click');
                                      await cubit.deleteUsers(
                                        data.id,
                                        data.name,
                                      );
                                      await cubit.getUsers();
                                    },
                                    icon: const Icon(EvaIcons.trash),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Text('Data Tidak Ditemukan');
                        }
                      } else if (state is UserFailure) {
                        return Text(state.failure.message);
                      } else {
                        return const CustomShimmerLoading();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
