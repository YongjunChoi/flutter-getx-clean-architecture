import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_architecture/app/types/category_type.dart';
import 'package:getx_clean_architecture/presentation/app.dart';
import 'package:getx_clean_architecture/presentation/pages/detail_page.dart';
import 'package:getx_clean_architecture/presentation/pages/profile_page.dart';
import 'package:getx_clean_architecture/presentation/pages/views/article_cell.dart';

import '../controllers/news_controller.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPagePage createState() => _NewsPagePage();
}

class _NewsPagePage extends State<NewsPage> {
  final NewsController newsController = Get.find();
  final _scrollController = ScrollController();
  CategoryType _currentCategory = CategoryType.bitcoin;

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: newsController,
      didUpdateWidget: (old, newState) {
        _scrollController.addListener(_scrollListener);
      },
      dispose: (state) {
        _scrollController.removeListener(_scrollListener);
      },
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('News'),
            // leading: Builder(builder: (context) { // this uses the new context to open the drawer properly provided by the Builder
            //   return IconButton(
            //       onPressed: () {
            //         Scaffold.of(context).openEndDrawer();
            //       },
            //       icon: const Icon(Icons.menu));
            // }),
            actions: [
              TextButton(
                  onPressed: () {
                    _selectCategory(context);
                  },
                  child: Text(_currentCategory.keyword.capitalizeFirst ?? ""))
            ],
          ),
          drawer: Drawer(
            child: ProfilePage(),
          ),
          body: ListView.builder(
            controller: _scrollController,
            itemCount: newsController.articles.length,
            itemBuilder: (context, index) {
              final article = newsController.articles[index];
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

  _selectCategory(BuildContext context) {
    final actions = CategoryType.values
        .map(
          (e) => CupertinoActionSheetAction(
            child: Text(e.keyword.capitalizeFirst ?? ""),
            onPressed: () {
              setState(() {
                _currentCategory = e;
              });
              newsController.fetchData(e.keyword);
              Navigator.pop(context);
            },
          ),
        )
        .toList();

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select category'),
        actions: actions,
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      newsController.loadMore(_currentCategory.keyword);
    }
  }
}
