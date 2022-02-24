import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:verifier_core/core/view_model/qrcode_scanner_view_model.dart';

class QrcodeScannerView extends StatelessWidget {
  @override
  Widget build(context) {
    return GetBuilder<QrcodeScannerViewModel>(
        init: QrcodeScannerViewModel(),
        builder: (qrvm) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Material(
              child: Center(
                child: SlidingUpPanel(
                  controller: qrvm.panelController,
                  panel: qrvm.resultView,
                  onPanelClosed: () {
                    qrvm.onPanelClosed();
                  },
                  onPanelOpened: () {
                    qrvm.onPanelOpened();
                  },
                  body: qrvm.scanView,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  // minHeight: _payload == null ? 0 : 50,
                  minHeight: 0,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                  backdropOpacity: 0.3,
                ),
              ),
              color: Colors.black,
            ),
          );
        });
  }
}
