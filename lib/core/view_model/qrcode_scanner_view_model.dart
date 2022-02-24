import 'dart:typed_data';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:dart_base45/dart_base45.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:archive/archive.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:verifier_core/core/model/trust_model.dart';
import 'package:verifier_core/helper/const.dart';
import 'package:verifier_core/view/dcc_result_view.dart';

class QrcodeScannerViewModel extends GetxController {
  final PanelController panelController = PanelController();
  late QRViewController _qrController;
  late ConnectivityResult _connectivityResult;
  Box? _certBox;
  String? _jsonCountryCertData;
  CoseResult? _coseResult;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void onInit() async {
    _initResource();
    super.onInit();
  }

  void _initResource() async {
    try {
      _connectivityResult = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('checkConnectivity() failed', error: e);
      return;
    }

    _certBox = await Hive.openBox(certSettings);
    if (_jsonCountryCertData == null) {
      if (_connectivityResult == ConnectivityResult.none) {
        _jsonCountryCertData = _certBox!.get('eudcc_trustedlist');
        if (_jsonCountryCertData == null) {
          showDialog(dccTrustedListNull, noServerConnection, backToRoot: true);
        }
      } else {
        try {
          //!!! 此開源版本僅提供測試憑證資訊，做為查驗程式驗證使用
          _jsonCountryCertData = certString;
          if (_jsonCountryCertData != null)
            _certBox!.put('eudcc_trustedlist', _jsonCountryCertData);
        } catch (e) {
          developer.log('getDSCList() failed', error: e);
        }
      }
    }
    update();
  }

  void onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!panelController.isPanelClosed || _coseResult != null) {
        return;
      }
      if (Get.isDialogOpen ?? false) {
        return;
      }
      final qrcodeText = scanData.code;
      if (qrcodeText == null || qrcodeText == '') {
        return;
      }
      final prefixStr = dccPrefix.firstWhere(
          (prefix) => qrcodeText.contains(prefix),
          orElse: () => '');
      if (prefixStr == '') {
        showDialog(qrcodeDecodeFailed, qrcodeDecodeFailedDetail);
        return;
      }
      if (_jsonCountryCertData == null) {
        showDialog(dccTrustedListNull, noServerConnection, backToRoot: true);
        return;
      }

      // qrcode text decode
      try {
        Uint8List decodedata =
            Base45.decode(qrcodeText.substring(prefixStr.length));
        List<int> cose = ZLibDecoder().decodeBytes(decodedata);
        List<TrustModel> trustList = List<TrustModel>.from(json
            .decode(_jsonCountryCertData!)
            .map((model) => TrustModel.fromJson(model)));
        Map<String, String> trustListMap = Map<String, String>.fromIterable(
            trustList,
            key: (e) => e.kid,
            value: (e) => e.rawData);
        _coseResult = Cose.decodeAndVerify(cose, trustListMap);
      } catch (e) {
        showDialog(qrcodeDecodeFailed, e.toString());
        return;
      }

      panelController.open();
      update();
    });
  }

  void onPanelClosed() {
    _coseResult = null;
    update();
  }

  void onPanelOpened() {
    _qrController.dispose();
    update();
  }

  Widget get resultView {
    return _coseResult == null
        ? SizedBox()
        : DccResultView(
            result: _coseResult!,
            panel: panelController,
          );
  }

  Widget get scanView {
    return (!panelController.isAttached ||
            (panelController.isAttached && !panelController.isPanelOpen))
        ? QRView(
            key: _qrKey,
            onQRViewCreated: onQRViewCreated,
            formatsAllowed: [BarcodeFormat.qrcode],
          )
        : Container(color: Colors.black);
  }

  void showDialog(String title, String middleText, {bool backToRoot = false}) {
    Get.defaultDialog(
      title: title,
      middleText: middleText,
      textCancel: closeText,
      onCancel: () {
        if (backToRoot) {
          Get.offAndToNamed(rootPath);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class QrcodeScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<QrcodeScannerViewModel>(QrcodeScannerViewModel());
  }
}
