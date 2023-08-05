import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture/presentation/pages/detail_page.dart';
import 'package:getx_clean_architecture/presentation/pages/profile_page.dart';
import 'package:getx_clean_architecture/presentation/pages/views/article_cell.dart';

import '../controllers/headline_controller.dart';

class HeadlinePage extends GetView<HeadlineController> {

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: controller,
      initState: (state) {
        controller.fetchData();
      },
      didUpdateWidget: (old, newState) {
        _scrollController.addListener(_scrollListener);
      },
      dispose: (state) {
        _scrollController.removeListener(_scrollListener);
      },
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Headline'),
          ),
          endDrawer: Drawer(
            child: ProfilePage(),
          ),
          body: ListView.builder(
            controller: _scrollController,
            itemCount: controller.articles.length,
            itemBuilder: (context, index) {
              final article = controller.articles[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailPage(article: article));
                },
                child: ArticleCell(article: article),
              );
            },
          ),
        );
      },
    );
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      print("load more");
      controller.loadMore();
    }
  }
}
