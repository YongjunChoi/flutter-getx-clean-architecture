import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture/presentation/controllers/auth_binding.dart';
import 'package:getx_clean_architecture/presentation/pages/home_page.dart';
import 'package:getx_clean_architecture/presentation/page.dart';

import '../app/config/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Duration duration = Duration(milliseconds: 300);
    Transition transitionA = Transition.fadeIn;
    Transition transitionB = Transition.downToUp;

    return GetMaterialApp(
      initialRoute: "/",
      initialBinding: AuthBinding(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MyTheme.fromType(false).themeData, //ThemeData.light(),
      darkTheme: MyTheme.fromType(true).themeData, //ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
        getPages: [
        //web
        GetPage(name: PageName.home, page: () => HomePage()),
        //mobile
        GetPage(name: PageName.login, page: () => HomePage(), transition: transitionA, transitionDuration: duration),
      ],
    );
  }
}
