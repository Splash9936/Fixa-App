// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:fixa/fixa_main_routes.dart';

class NetworkController extends GetxController {
  Rx<int> connectionStatus = 0.obs;
  int connectionStus = 0;
  Rx<String> connectionErrorMessage = "".obs;
  final _networkStateStream = NetworkState().obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  // get for network state
  NetworkState get state => _networkStateStream.value;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updatedConnectionStatus);
  }

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //     return _updatedConnectionStatus(result);
  //   } catch (e) {
  //     Get.snackbar('network error platform', 'platform exception',
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: redColor,
  //         colorText: whiteColor,
  //         borderRadius: 10,
  //         margin: const EdgeInsets.all(10));
  //   }
  // }

  Future<void> initConnectivity() async {
    _networkStateStream.value = NetworkLoading();
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      Get.snackbar('network error platform', '${e.toString()}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: redColor,
          colorText: whiteColor,
          borderRadius: 10,
          margin: const EdgeInsets.all(10));
    }
    return _updatedConnectionStatus(connectivityResult!);
  }

  _updatedConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        connectionStus = 1;
        _networkStateStream.value = NetworkWifiConnected();
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        connectionStus = 2;
        _networkStateStream.value = NetworkMobileConnected();
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        connectionStus = 0;
        _networkStateStream.value = NetworkNotConnected();
        break;
      default:
        connectionErrorMessage.value = "not connected";
        _networkStateStream.value = NetworkNotConnected();
        break;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription!.cancel();
    super.onClose();
  }
}
