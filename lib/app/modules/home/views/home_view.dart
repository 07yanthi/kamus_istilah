import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/app/core/env/env.dart';
import 'package:news_app/app/modules/home/controllers/search_controller.dart';
import 'package:news_app/app/modules/home/views/components/card_view.dart';
import 'package:news_app/app/modules/home/views/components/search_view.dart';
import 'package:news_app/app/modules/home/views/components/tentang.dart';
import 'package:news_app/app/modules/home/views/favorit_view.dart';
import 'package:news_app/app/utils/error_page.dart';
import 'package:news_app/app/utils/no_internet_page.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

var waktu = 0;



class HomeView extends GetView<SearchkamusController> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  
  late String jenis = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff4f9b9b),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/logo.png',
                        scale: 45,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'KAMUS ISTILAH',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Kesehatan Hewan Dan Peternakan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Favorit',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () async {
                controller.fetchfavorit();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            FavoritView('Favorit')));
              },
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Tentang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Tentang()));
              },
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
          ],
        ),
      ),
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
                          controller.searchController.text = '';
                          controller.fetchKamus('', '');
                          String? identifier = await UniqueIdentifier.serial;
                          print(identifier);
                        },
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              title: Row(
                                children: [
                                  Image.asset(
                                    'assets/logo.png',
                                    scale: 45,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'KAMUS ISTILAH',
                                          style: TextStyle(
                                              // color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'Kesehatan Hewan Dan Peternakan',
                                            style: TextStyle(
                                                // color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              backgroundColor: Env.colors.primaryBlue,
                              leading: IconButton(
                                  onPressed: () {
                                    _globalKey.currentState!.openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    size: 24,
                                  )),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: SearchView(
                                        controller: controller.searchController,
                                        onPressed: () {
                                          // controller.searchNews();
                                          if (controller.isSearch.isTrue) {
                                            controller.searchController.text =
                                                '';
                                            controller.isSearch(false);
                                            controller.refresh();
                                          }

                                          if (controller.searchController.text
                                              .isNotEmpty) {
                                            controller.searchKamus(
                                                '',
                                                controller
                                                    .searchController.text);
                                            _globalKey.currentState
                                                ?.showSnackBar(SnackBar(
                                              content: Text(
                                                "Waktu Pencarian Algoritma : " +
                                                    controller.waktu,
                                              ),
                                              action: SnackBarAction(
                                                textColor: Colors.white,
                                                label: "Ok",
                                                onPressed: () {
                                                  _globalKey
                                                      .currentState?.mounted;
                                                },
                                              ),
                                              backgroundColor:
                                                  Colors.yellow[700],
                                              duration: Duration(
                                                seconds: 10,
                                              ),
                                            ));
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        onPressed: controller.listen,
                                        icon: Icon(controller.isListening.isTrue
                                            ? Icons.mic
                                            : Icons.mic_none),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
                                  : controller.kamusList.isEmpty
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
                                            controller.searchController.text
                                                        .isNotEmpty &&
                                                    controller.typo != '' &&
                                                    controller.searchController
                                                            .text
                                                            .toLowerCase() !=
                                                        controller.typo
                                                ? Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              bottom: 10,
                                                              left: 10),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
                                                        child: RichText(
                                                          text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        "Pencarian kata ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                                TextSpan(
                                                                    text: controller
                                                                            .searchController
                                                                            .text +
                                                                        " ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .red,
                                                                    )),
                                                                TextSpan(
                                                                    text:
                                                                        "tidak di temukan, kata yang anda maksud mungkin ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                                TextSpan(
                                                                    text: controller
                                                                            .typo +
                                                                        " ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .green,
                                                                    )),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                var data =
                                                    controller.isSearch.isFalse
                                                        ? controller
                                                            .kamusList[index]
                                                        : controller
                                                            .searchList[index];
                                                var cek = controller.favoritList
                                                    .where((element) =>
                                                        element.kamusId ==
                                                        data.kamusId);
                                                bool favorit = false;
                                                if (cek.isNotEmpty) {
                                                  favorit = true;
                                                }

                                                debugPrint(cek.toString());
                                                debugPrint(favorit.toString());
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: CardView(
                                                      favorit: favorit,
                                                      title: data.kamusIstilah,
                                                      id: data.kamusId,
                                                      detail: data.kamusDetail),
                                                );
                                              },
                                              itemCount: controller
                                                      .isSearch.isFalse
                                                  ? controller.kamusList.length
                                                  : controller
                                                      .searchList.length,
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
