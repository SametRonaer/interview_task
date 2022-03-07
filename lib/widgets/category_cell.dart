import 'package:flutter/material.dart';
import 'package:interview_task/extensions/screen_size_context.dart';
import 'package:interview_task/models/category_model.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class CategoryCell extends StatelessWidget {
  CategoryModel categoryModel;
  CategoryCell({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);
  late ContentProvider contentProvider;
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    contentProvider = Provider.of<ContentProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () {
        contentProvider.setCurrentCategory(categoryModel, context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        width: context.screenWidth / 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.screenHeight / 10,
              width: context.screenWidth / 2.4,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    categoryModel.Image!,
                    fit: BoxFit.cover,
                  )),
            ),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(categoryModel.Title!),
              ),
            )
          ],
        ),
      ),
    );
  }
}
