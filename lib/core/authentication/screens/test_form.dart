// ignore_for_file: unused_field, use_build_context_synchronously

import 'dart:async';

import 'package:alquran/core/authentication/cubit/logout_cubit.dart';
import 'package:alquran/core/home/menu_screen.dart';
import 'package:alquran/core/user/cubit/user_cubit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constant/route_path.dart';

class TestFormPage extends StatelessWidget {
  TestFormPage({super.key});
  final cubit = UserCubit();

  final nameCtrl = TextEditingController();
  final avatarUrlCtrl = TextEditingController();
  final ageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List User'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<LogoutCubit>().logOut();
            },
            icon: Icon(EvaIcons.log_out_outline),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          cubit.getUsers();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24,
            ),
            child: BlocListener<LogoutCubit, LogoutState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  if (context.mounted) {
                    Timer(const Duration(seconds: 2), () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutePath.registerScreen,
                        (route) => false,
                      );
                    });
                  }
                } else if (state is LogoutFailure) {
                  Flushbar(
                    title: 'Oppps!!',
                    message: state.failure.message,
                    backgroundColor: Colors.red,
                  ).show(context);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state is UserDeleteSuccess) {
                        Flushbar(
                          title: 'Congratulations!',
                          message: 'User ${state.name} has been deleted',
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      } else if (state is CreateUserSuccess) {
                        Flushbar(
                          title: 'Congratulations!',
                          message: 'User Has Been Added!',
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      } else if (state is UserDeleteFailure) {
                        Flushbar(
                          title: 'Opps!!!',
                          message: '$state.failure.message',
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      }
                    },
                    bloc: cubit..getUsers(),
                    builder: (context, state) {
                      if (state is UserSuccess) {
                        if (state.result.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.result.length,
                              itemBuilder: (context, index) {
                                var loading = state is UserDeleteLoading;
                                var data = state.result[index];
                                return Card(
                                  elevation: 1,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text(data.id),
                                    ),
                                    title: Text(data.name),
                                    subtitle: Text(data.age),
                                    trailing: loading
                                        ? LoadingAnimationWidget.inkDrop(
                                            color: Colors.black,
                                            size: 10,
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              context
                                                  .read<UserCubit>()
                                                  .deleteUsers(
                                                      data.id, data.name);
                                              context
                                                  .read<UserCubit>()
                                                  .getUsers();
                                            },
                                            icon: const Icon(EvaIcons.trash),
                                          ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text('Data Tidak Ditemukan');
                        }
                      } else if (state is UserFailure) {
                        return Text(state.failure.message);
                      } else {
                        return Center(
                          child: LoadingAnimationWidget.inkDrop(
                            color: Colors.black,
                            size: 20,
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BlocProvider.value(
        value: BlocProvider.of<UserCubit>(context),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () async {
                var loading = state is CreateUserLoading;
                await showDialog(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        child: Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextField(controller: nameCtrl),
                                const SizedBox(height: 10),
                                TextField(controller: avatarUrlCtrl),
                                const SizedBox(height: 10),
                                TextField(controller: ageCtrl),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    context.read<UserCubit>().createUser(
                                          nameCtrl.text,
                                          avatarUrlCtrl.text,
                                          ageCtrl.text,
                                        );
                                    Navigator.pop(context);
                                    await cubit.getUsers();
                                    nameCtrl.clear();
                                    nameCtrl.clear();
                                    nameCtrl.clear();
                                  },
                                  child: loading
                                      ? LoadingAnimationWidget.prograssiveDots(
                                          color: Colors.black, size: 20)
                                      : const Text('Create User'),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: const Icon(EvaIcons.person_add),
            );
          },
        ),
      ),
    );
  }
}
