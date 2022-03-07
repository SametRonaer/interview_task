import 'package:flutter/material.dart';
import 'package:interview_task/constants/enums.dart';
import 'package:interview_task/extensions/screen_size_context.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:interview_task/widgets/app_loading_spinner.dart';
import 'package:interview_task/widgets/blog_cell.dart';
import 'package:interview_task/widgets/category_cell.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late ContentProvider contentProvider;

  @override
  Widget build(BuildContext context) {
    contentProvider = Provider.of<ContentProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [_getCategoriesBar(context), _getArtcilesGrid()],
        ));
  }

  Widget _getArtcilesGrid() {
    return contentProvider.contentState == ScreenStates.Loading
        ? const AppLoadingSpinner()
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                  itemCount: contentProvider.categoryBlogList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 9 / 13,
                  ),
                  itemBuilder: (_, i) =>
                      BlogCell(blogModel: contentProvider.categoryBlogList[i])),
            ),
          );
  }

  Widget _getCategoriesBar(BuildContext context) {
    return SizedBox(
        height: context.screenHeight / 6,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contentProvider.categoryList.length,
            itemBuilder: ((context, index) {
              return CategoryCell(
                  categoryModel: contentProvider.categoryList[index]);
            })));
  }
}
