// // ignore_for_file: unnecessary_overrides, avoid_print

// import 'dart:async';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:news_app/app/data/model/jenis_model.dart';
// import 'package:news_app/app/data/model/kamus_model.dart';
// import 'package:news_app/app/data/service/api.dart';

// class HomeController extends GetxController {
//   //TODO: Implement HomeController

//   TextEditingController searchController = TextEditingController();

//   var kamusList = <Kamus>[].obs;
//   var jenisList = <Jeni>[].obs;
//   var isChecked = false.obs;
//   var isButton = 10;
//   var isLoading = false.obs;
//   var isError = false.obs;
//   var isInternetConnected = false.obs;
//   var waktu = '';
//   var typo = '';

//   final connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> subscription;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchNews('', '');
//     fetchJenis();
//     getConnectionType();
//     subscription =
//         connectivity.onConnectivityChanged.listen(getConnectionStatus);
//   }

//   // Connection Type

//   Future<void> getConnectionType() async {
//     var connectivityResult;
//     try {
//       connectivityResult = await connectivity.checkConnectivity();
//     } catch (e) {
//       print(e);
//     }
//     return getConnectionStatus(connectivityResult);
//   }

//   // Connection Status

//   getConnectionStatus(ConnectivityResult connectivityResult) async {
//     var connectivityResult = await connectivity.checkConnectivity();
//     if (connectivityResult == ConnectivityResult.mobile) {
//       isInternetConnected.value = true;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       isInternetConnected.value = true;
//     } else if (connectivityResult == ConnectivityResult.none) {
//       isInternetConnected.value = false;
//     }
//   }

//   // Show selected country news only

//   // Future<void> selectedCountryNews(String code) async {
//   //   try {
//   //     newsList.clear();
//   //     isLoading(true);
//   //     FetchFromApi fetchFromApi = FetchFromApi();
//   //     var data = await fetchFromApi.fetchCountryNews(code);

//   //     for (var i = 0; i < data!.articles.length; i++) {
//   //       if (data.articles[i].urlToImage != null &&
//   //           data.articles[i].source!.name!.isNotEmpty) {
//   //         newsList.add(data.articles[i]);
//   //       }
//   //     }
//   //   } finally {
//   //     isLoading(false);
//   //   }
//   // }

//   // Fetch all latest News

//   Future<void> fetchNews(String jenis, String search) async {
//     try {
//       kamusList.clear();

//       isLoading(true);

//       FetchFromApi fetchFromApi = FetchFromApi();
//       var data = await fetchFromApi.getKamus(search);
//       waktu = data!.waktu.toString();
//       typo = data.typo.toString();
//       for (var i = 0; i < data.kamus.length; i++) {
//         if (data.kamus[i].kamusIstilah!.isNotEmpty) {
//           kamusList.add(data.kamus[i]);
//         }
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> fetchJenis() async {
//     try {
//       jenisList.clear();

//       isLoading(true);

//       FetchFromApi fetchFromApi = FetchFromApi();
//       var data = await fetchFromApi.getJenis();
//       for (var i = 0; i < data!.jenis.length; i++) {
//         if (data.jenis[i].namaJenis.isNotEmpty) {
//           jenisList.add(data.jenis[i]);
//         }
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

//   // Show all search result

//   // Future<void> searchNews() async {
//   //   try {
//   //     newsList.clear();
//   //     isLoading(true);

//   //     // isError(false);

//   //     FetchFromApi fetchFromApi = FetchFromApi();
//   //     var data = await fetchFromApi.searchNews(searchController.text);

//   //     if (data != null) {
//   //       for (var i = 0; i < data.articles.length; i++) {
//   //         if (data.articles[i].urlToImage != null &&
//   //             data.articles[i].source!.name!.isNotEmpty) {
//   //           newsList.add(data.articles[i]);
//   //         }
//   //       }
//   //     } else if (data!.totalResults == 0) {
//   //       print(isError.value);
//   //       isError(true);
//   //     }
//   //   } finally {
//   //     isLoading(false);
//   //   }
//   // }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
