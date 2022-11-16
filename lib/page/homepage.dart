import 'package:cherry_toast/cherry_toast.dart';
import 'package:crud/provider/product_provider.dart';
import 'package:crud/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../provider/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasInternet = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).getAllProduct();
    });

    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
      if (!hasInternet) {
        return CherryToast.error(
          title: const Text(
            'No Internet Connection',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          action: const Text(
            'Please Try Again Later',
            style: TextStyle(color: Colors.black),
          ),
          actionHandler: () {},
        ).show(context);
      } else {
        return CherryToast.success(
          title: const Text('  Connected'),
          action: const Text('/merasa senang'),
          actionHandler: () {},
        ).show(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<appColor, tColor>(
      builder: ((context, appColor, tColor, _) => Scaffold(
            backgroundColor: appColor.color,
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text(
                'Gabut Cok Sumpah',
                style: TextStyle(color: tColor.warna, letterSpacing: 1),
              ),
            ),
            body: Consumer<ProductProvider>(
              builder: ((context, ProductProvider, child) => FutureBuilder(
                    future: ProductService().getAll(),
                    builder: ((context, index) {
                      var value = ProductProvider;
                      final product = value.product;
                      if (index.error != null && !hasInternet) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: tColor.warna,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Check Your Connection & Try Again',
                                  style: TextStyle(
                                    color: tColor.warna,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      if (index.connectionState == ConnectionState.waiting) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: tColor.warna,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        print('AKHIRNYA BISA COKK');

                        return AnimationLimiter(
                          child: ListView.builder(
                            itemCount: value.product.length,
                            itemBuilder: ((context, index) {
                              final asu = product[index];
                              return AnimationConfiguration.staggeredGrid(
                                duration: const Duration(milliseconds: 100),
                                columnCount: index,
                                position: index,
                                child: SlideAnimation(
                                  child: Card(
                                    color: appColor.color,
                                    child: FadeInAnimation(
                                      child: ListTile(
                                        dense: true,
                                        contentPadding: const EdgeInsets.all(2),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          maxRadius: 12,
                                          child: Center(
                                            child: Text(
                                              '${asu.id}.',
                                              style: GoogleFonts.inter(
                                                color: tColor.warna,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Transform(
                                          transform: Matrix4.translationValues(
                                              -15, 0, 0),
                                          child: Text(
                                            asu.title,
                                            style: TextStyle(
                                              color: tColor.warna,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }
                    }),
                  )),
            ),
          )),
    );
  }
}
