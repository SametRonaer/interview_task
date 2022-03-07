// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:interview_task/extensions/screen_size_context.dart';
import 'package:interview_task/helpers/api_service.dart';
import 'package:interview_task/models/blog_model.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/screens/article_detail_screen.dart';
import 'package:provider/provider.dart';

class BlogCell extends StatefulWidget {
  BlogModel blogModel;
  BlogCell({
    Key? key,
    required this.blogModel,
  }) : super(key: key);

  @override
  State<BlogCell> createState() => _BlogCellState();
}

class _BlogCellState extends State<BlogCell> {
  late ContentProvider contentProvider;
  late ProfileProvider profileProvider;
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    contentProvider = Provider.of<ContentProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () {
        contentProvider.setCurrentBlog(widget.blogModel);
        Navigator.of(context).pushNamed(ArticleDetailScreen.routeName);
      },
      child: GridTile(
          footer: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.white70),
            height: context.screenHeight / 17,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: FittedBox(child: Text(widget.blogModel.Title)),
            ),
          ),
          child: Container(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        alignment: Alignment.center,
                        child: Hero(
                            tag: widget.blogModel.Id,
                            child: Image.network(
                              widget.blogModel.Image,
                              fit: BoxFit.cover,
                            )))),
                _getLikeButton(context),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            height: context.screenHeight / 2,
            width: context.screenWidth / 2.2,
          )),
    );
  }

  IconButton _getLikeButton(BuildContext context) {
    List<dynamic> favoriteIds = profileProvider.getCurrentUser!.FavoriteBlogIds;
    Color iconColor = Colors.grey.shade300;
    favoriteIds.forEach(
      (element) {
        if (element.toString() == widget.blogModel.Id) {
          iconColor = Colors.black;
        }
      },
    );
    return IconButton(
        onPressed: () async {
          await profileProvider.toggleFavoriteStatus(
              widget.blogModel.Id, authProvider.getUserToken!, context);
          setState(() {});
        },
        icon: Icon(
          Icons.favorite,
          color: iconColor,
        ));
  }
}
