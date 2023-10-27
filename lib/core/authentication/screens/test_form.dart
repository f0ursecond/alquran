// ignore_for_file: unused_field, use_build_context_synchronously, unnecessary_string_interpolations, unused_import, avoid_print

import 'package:alquran/core/user/cubit/user_cubit.dart';
import 'package:alquran/shared_widgets/custom_shimmer_loading.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) async {
                    print('UserCubit listener called with state: $state');
                    if (state is UserDeleteSuccess) {
                      print('user delete sukses');
                      Flushbar(
                        title: 'Congratulations!',
                        message: 'User ${state.name} has been deleted',
                        duration: const Duration(seconds: 3),
                      ).show(context);
                      await cubit.getUsers();
                    } else if (state is CreateUserSuccess) {
                      print('user create sukses');
                      Flushbar(
                        title: 'Congratulations!',
                        message: 'User Has Been Added!',
                        duration: const Duration(seconds: 3),
                      ).show(context);
                      await cubit.getUsers();
                    } else if (state is UpdateUserSuccess) {
                      print('user update sukses');
                      Flushbar(
                        title: 'Congratulations!',
                        message: 'User by id ${state.id} Has Been Updated!',
                        duration: const Duration(seconds: 3),
                      ).show(context);
                      await cubit.getUsers();
                    } else if (state is UserDeleteFailure) {
                      Flushbar(
                        title: 'Opps!!!',
                        message: '${state.failure.message}',
                        duration: const Duration(seconds: 8),
                      ).show(context);
                    } else if (state is CreateUserFailure) {
                      Flushbar(
                        title: 'Opps!!!',
                        message: '${state.failure.message}',
                        duration: const Duration(seconds: 8),
                      ).show(context);
                    } else if (state is UpdateUserFailure) {
                      Flushbar(
                        title: 'Opps!!!',
                        message: '${state.failure.message}',
                        duration: const Duration(seconds: 8),
                      ).show(context);
                    }
                  },
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is UserSuccess) {
                      if (state.result.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.result.length,
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
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await cubit.deleteUsers(
                                              data.id, data.name);
                                          await cubit.getUsers();
                                        },
                                        icon: const Icon(EvaIcons.trash),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          var loading =
                                              state is UpdateUserLoading;
                                          await createAndUpdateDialog(
                                              context,
                                              loading,
                                              'Update',
                                              data.id,
                                              data.name,
                                              data.avatarUrl,
                                              data.age);
                                          if (loading) {
                                            await cubit.getUsers();
                                          }
                                        },
                                        icon: const Icon(EvaIcons.edit),
                                      ),
                                    ],
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
      floatingActionButton: BlocProvider.value(
        value: BlocProvider.of<UserCubit>(context),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () async {
                var loading =
                    state is CreateUserLoading || state is UpdateUserLoading;
                await createAndUpdateDialog(context, loading, 'Create');
              },
              child: const Icon(EvaIcons.person_add),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> createAndUpdateDialog(
      BuildContext context, bool loading, String btnText,
      [String? id, String? name, String? avatar, String? age]) {
    print('createAndUpdateDialog called');
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          print('ini id coy : $id');
          return SizedBox(
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      decoration: InputDecoration(
                        prefixText: id != null ? name : 'Masukan Nama',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: avatarUrlCtrl,
                      decoration: InputDecoration(
                        prefixText: id != null ? avatar : 'Masukan Url',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ageCtrl,
                      decoration: InputDecoration(
                        prefixText: id != null ? age : 'Masukan Umur',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        createOrUpdate(id, cubit, nameCtrl, avatarUrlCtrl,
                            ageCtrl, context);
                      },
                      child: loading
                          ? LoadingAnimationWidget.prograssiveDots(
                              color: Colors.black, size: 20)
                          : Text(btnText),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Batal'))
                  ],
                ),
              ),
            ),
          );
        });
  }

  final nameCtrl = TextEditingController();

  final avatarUrlCtrl = TextEditingController();

  final ageCtrl = TextEditingController();
}

void createOrUpdate(String? id, UserCubit cubit, TextEditingController nameCtrl,
    avatarUrlCtrl, ageCtrl, context) async {
  try {
    id == null
        ? cubit.createUser(nameCtrl.text, avatarUrlCtrl.text, ageCtrl.text)
        : cubit.updateUser(
            nameCtrl.text,
            avatarUrlCtrl.text,
            ageCtrl.text,
            id,
          );
    Navigator.pop(context);
    nameCtrl.clear();
    avatarUrlCtrl.clear();
    ageCtrl.clear();
  } catch (e) {
    print(e.toString());
  }
}
