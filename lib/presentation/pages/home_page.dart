import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture/app/config/app_colors.dart';
import 'package:getx_clean_architecture/app/types/tab_type.dart';
import 'package:getx_clean_architecture/presentation/controllers/headline_binding.dart';
import 'package:getx_clean_architecture/presentation/controllers/news_binding.dart';
import 'package:getx_clean_architecture/presentation/pages/headline_page.dart';
import 'package:getx_clean_architecture/presentation/pages/news_page.dart';
import 'package:getx_clean_architecture/presentation/pages/profile_page.dart';

import '../controllers/auth_controller.dart';

class HomePage extends GetView<AuthController> {

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: controller,
      builder: (_) { return Scaffold(
        body: SizedBox.expand(
            child:
            _buildScreens().elementAt(controller.currentIndex.value)
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: controller.currentIndex.value,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) =>
              //setState(() {
                controller.currentIndex.value = index
                //_pageController?.animateToPage(index,duration: const Duration(milliseconds: 300), curve: Curves.ease);
              //})
          ,
          items: TabType.values
                .map((e) => BottomNavyBarItem(icon: e.icon, title: Text(e.title), textAlign: TextAlign.center,
                 activeColor: Theme.of(context).colorScheme.primary, inactiveColor: Theme.of(context).colorScheme.inversePrimary))
                .toList()
        )
      );
      },
    );
  }

  List<Widget> _buildScreens() {
    HeadlineBinding().dependencies();
    NewsBinding().dependencies();
    return [
      HeadlinePage(),
      NewsPage(),
      ProfilePage(),
    ];
  }
}
