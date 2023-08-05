import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture/app/services/local_storage.dart';
import 'package:getx_clean_architecture/app/util/dependency.dart';
import 'package:getx_clean_architecture/presentation/app.dart';
import 'package:loggy/loggy.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  DependencyCreator.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(
      EasyLocalization(child: App(),
          supportedLocales: [
            const Locale('ko', 'KR'),
            const Locale('en', 'US'),
          ],
          startLocale: Locale('ko', 'KR'),
          path: 'assets/translations'));
}

initServices() async {
  logDebug('starting services ...');
  await Get.putAsync(() => LocalStorageService().init());
  logDebug('All services started...');
}
