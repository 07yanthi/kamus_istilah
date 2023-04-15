// ignore_for_file: unnecessary_overrides, avoid_print

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_app/app/data/model/jenis_model.dart';
import 'package:news_app/app/data/model/kamus_model.dart';
import 'package:news_app/app/data/service/api.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:http/http.dart' as http;

class FavoritController extends GetxController {
  TextEditingController searchController = TextEditingController();

  var favoritList = <Kamus>[].obs;
  var jenisList = <Jeni>[].obs;
  var isChecked = false.obs;
  var isButton = 10;
  var isLoading = false.obs;
  var isError = false.obs;
  var isInternetConnected = false.obs;
  var waktu = '';
  var typo = '';

  final connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void onInit() {
    super.onInit();
    fetchfavorit();
    getConnectionType();
    subscription =
        connectivity.onConnectivityChanged.listen(getConnectionStatus);
  }

  // Connection Type

  Future<void> getConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await connectivity.checkConnectivity();
    } catch (e) {
      print(e);
    }
    return getConnectionStatus(connectivityResult);
  }

  // Connection Status

  getConnectionStatus(ConnectivityResult connectivityResult) async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      isInternetConnected.value = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isInternetConnected.value = true;
    } else if (connectivityResult == ConnectivityResult.none) {
      isInternetConnected.value = false;
    }
  }

  Future<void> fetchfavorit() async {
    try {
      favoritList.clear();

      isLoading(true);

      FetchFromApi fetchFromApi = FetchFromApi();
      var data = await fetchFromApi.getFavorit();
      // waktu = data!.waktu.toString();
      for (var i = 0; i < data!.kamus.length; i++) {
        if (data.kamus[i].kamusIstilah!.isNotEmpty) {
          favoritList.add(data.kamus[i]);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  // addFavorit(String kamus) async {
  //   String? user = await UniqueIdentifier.serial;
  //   var response = await http.get(Uri.parse(
  //       'http://kamus.test-web.my.id/api/add_favorit?user=' +
  //           user! +
  //           '&kamus_id=' +
  //           kamus));

  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     print(jsonString);
  //     return kamusModelFromJson(jsonString);
  //   } else {
  //     throw Exception('Failed to load news');
  //   }
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
