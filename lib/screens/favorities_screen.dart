import 'package:flutter/material.dart';
import 'package:interview_task/constants/enums.dart';
import 'package:interview_task/providers/bottom_bar_provider.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/widgets/app_loading_spinner.dart';
import 'package:interview_task/widgets/blog_cell.dart';
import 'package:provider/provider.dart';

class FavoritiesScreen extends StatelessWidget {
  FavoritiesScreen({Key? key}) : super(key: key);
  late ContentProvider contentProvider;

  @override
  Widget build(BuildContext context) {
    contentProvider = Provider.of<ContentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "My Favorities",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: contentProvider.contentState == ScreenStates.Loading
          ? const AppLoadingSpinner()
          : Column(
              children: [_getArtcilesGrid()],
            ),
    );
  }

  Widget _getArtcilesGrid() {
    return contentProvider.contentState == ScreenStates.Loading
        ? const AppLoadingSpinner()
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                  itemCount: contentProvider.getFavoriteBlogs.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 9 / 13,
                  ),
                  itemBuilder: (_, i) =>
                      BlogCell(blogModel: contentProvider.getFavoriteBlogs[i])),
            ),
          );
  }
}
