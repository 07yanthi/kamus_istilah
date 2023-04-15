// ignore_for_file: unnecessary_overrides, avoid_print

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:news_app/app/data/model/jenis_model.dart';
import 'package:news_app/app/data/model/kamus_model.dart';
import 'package:news_app/app/data/service/api.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchkamusController extends GetxController {
  TextEditingController searchController = TextEditingController();

  var favoritList = <Kamus>[].obs;
  var kamusList = <Kamus>[].obs;
  var searchList = <Kamus>[].obs;
  var jenisList = <Jeni>[].obs;
  var isChecked = false.obs;
  var isButton = 10;
  var isLoading = false.obs;
  var isError = false.obs;
  var isInternetConnected = false.obs;
  var waktu = '';
  var typo = '';
  var isSearch = false.obs;

  final connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;
  late stt.SpeechToText _speech;
  var isListening = false.obs;

  @override
  void onInit() {
    super.onInit();
    _speech = stt.SpeechToText();
    fetchfavorit();
    fetchKamus('', '');
    getConnectionType();
    subscription =
        connectivity.onConnectivityChanged.listen(getConnectionStatus);
  }

  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  Future<void> listen() async {
    if (isListening.isFalse) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        // setState(() => );
        isListening(true);
        _speech.listen(onResult: (val) {
          _text = val.recognizedWords;
          print('onText: $_text');
          if (val.hasConfidenceRating && val.confidence > 0) {
            _confidence = val.confidence;
          }
          searchController.text = _text;
          searchKamus('', searchController.text);
        });
      }
    } else {
      // setState(() => isListening = false);
      isListening(false);
      _speech.stop();
    }
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

  Future<void> fetchKamus(String jenis, String search) async {
    try {
      kamusList.clear();
      searchList.clear();

      isLoading(true);

      FetchFromApi fetchFromApi = FetchFromApi();
      var data = await fetchFromApi.getKamus(search);
      waktu = data!.waktu.toString();
      typo = data.typo;
      for (var i = 0; i < data.kamus.length; i++) {
        if (data.kamus[i].kamusIstilah!.isNotEmpty) {
          kamusList.add(data.kamus[i]);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchKamus(String jenis, String search) async {
    try {
      searchList.clear();

      isLoading(true);
      if (search != '') {
        isSearch(true);
      } else {
        isSearch(false);
      }

      FetchFromApi fetchFromApi = FetchFromApi();
      var data = await fetchFromApi.getKamus(search);
      waktu = data!.waktu.toString();
      typo = data.typo;
      for (var i = 0; i < data.kamus.length; i++) {
        if (data.kamus[i].kamusIstilah!.isNotEmpty) {
          searchList.add(data.kamus[i]);
        }
      }
      isListening(false);
      _speech.stop();
    } finally {
      isLoading(false);
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
