import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_app/app/core/env/env.dart';
import 'package:news_app/app/modules/home/controllers/favorit_controller.dart';
import 'package:news_app/app/modules/home/controllers/search_controller.dart';
import 'package:news_app/app/utils/error_page.dart';
import 'package:news_app/app/utils/no_internet_page.dart';

import 'components/card_view.dart';
import 'components/search_view.dart';

class FavoritView extends GetView<SearchkamusController> {
  final String title;
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  FavoritView(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.isInternetConnected.value
            ? controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.isError.value
                    ? const ErrorPage()
                    : RefreshIndicator(
                        onRefresh: () async {
                          controller.fetchfavorit();
                        },
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              title: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'FAVORIT',
                                  style: TextStyle(
                                      // color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              backgroundColor: Env.colors.primaryBlue,
                              leading: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(Icons.arrow_back)),
                            ),
                            SliverToBoxAdapter(
                              child: controller.isLoading.isTrue
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      child: const Center(
                                          child: Text('Load Data ...')),
                                    )
                                  : controller.favoritList.isEmpty
                                      ? SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          child: const Center(
                                              child:
                                                  Text('Data Tidak Ditemukan')),
                                        )
                                      : Column(
                                          children: [
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                var data = controller
                                                    .favoritList[index];
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: CardView(
                                                      id: data.kamusId,
                                                      favorit: true,
                                                      title: data.kamusIstilah,
                                                      detail: data.kamusDetail),
                                                );
                                              },
                                              itemCount:
                                                  controller.favoritList.length,
                                            ),
                                          ],
                                        ),
                            ),
                          ],
                        ),
                      )
            : const NoInternetPage(),
      ),
    );
  }
}
