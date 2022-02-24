// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:verifier_core/helper/const.dart';
import 'package:verifier_core/view/qrcode_scanner_view.dart';

import 'core/view_model/qrcode_scanner_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: rootPath,
      getPages: [
        GetPage(
          name: rootPath,
          page: () => SplashPage(),
          binding: SplashBinding(),
        ),
        GetPage(
            name: verifyPath,
            page: () => QrcodeScannerView(),
            binding: QrcodeScannerBinding()),
      ],
    );
  }
}

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    Get.toNamed(verifyPath);
  }
}

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          color: themeColor,
        ));
  }
}
