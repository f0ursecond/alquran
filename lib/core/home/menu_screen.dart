import 'dart:async';
import 'package:alquran/constant/route_path.dart';
import 'package:alquran/core/authentication/cubit/logout_cubit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('Text $index'),
                      ),
                    );
                  }),
              const SizedBox(height: 20),
              BlocProvider.value(
                value: BlocProvider.of<LogoutCubit>(context),
                child: BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(content: LoadingLogout());
                          });
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
                  builder: (context, state) {
                    var loading = state is LogoutLoading;
                    return LogoutButton(loading: loading);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingLogout extends StatelessWidget {
  const LoadingLogout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.discreteCircle(color: Colors.red, size: 35),
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.loading,
  });

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('Apakah anda yakin ingin keluar?'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: const Text('Batal'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Keluar'),
                              onPressed: () {
                                context.read<LogoutCubit>().logOut();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                });
          },
          child: const Center(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
