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
              BlocConsumer<LogoutCubit, LogoutState>(
                listener: (context, state) async {
                  print('listener $state');
                  if (state is LogoutLoading) {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 150,
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (state is LogoutSuccess) {
                    if (context.mounted) {
                      Future.delayed(const Duration(seconds: 1), () {
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
                  print('builder $state');
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () async {
                          context.read<LogoutCubit>().logOut();
                        },
                        child: const Center(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showLogout(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Apakah anda yakin ingin keluar?'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Batal'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Keluar'),
                        onPressed: () {
                          context.read<LogoutCubit>().logOut();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}

// class LoadingLogout extends StatelessWidget {
//   const LoadingLogout({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         LoadingAnimationWidget.discreteCircle(color: Colors.black, size: 25),
//       ],
//     );
//   }
// }

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.loading,
    required this.onTap,
  });

  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Center(
            child: Text(
              loading ? 'Loading' : 'Logout',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
