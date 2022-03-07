
import 'package:flutter/cupertino.dart';
import 'package:interview_task/constants/enums.dart';
import 'package:interview_task/helpers/api_service.dart';
import 'package:interview_task/models/blog_model.dart';
import 'package:interview_task/models/category_model.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/screens/bottom_bar_screen.dart';
import 'package:provider/provider.dart';

class ContentProvider extends ChangeNotifier{


  List<CategoryModel> categoryList = [];
  List<BlogModel> categoryBlogList = [];
  List<BlogModel> blogList = [];
  List<BlogModel> _favoritiesBlogs = [];
  CategoryModel? _currentCategory;
  BlogModel? _currentBlog;
  ScreenStates _contentState = ScreenStates.Initial;

  CategoryModel? get getCurrentCategory => _currentCategory;
  BlogModel? get getCurrentBlog => _currentBlog;
  ScreenStates get contentState => _contentState;
  List<BlogModel> get getFavoriteBlogs => _favoritiesBlogs;


  Future<void> setCategories(String token)async{
    _contentState = ScreenStates.Loading;
    notifyListeners();
    categoryList.clear();
    Map<String, dynamic> response =  await ApiService.sendGetRequest("/Blog/GetCategories", token);
    List<dynamic> categoryData = response["Data"];
    categoryData.forEach((element) => categoryList.add(CategoryModel.fromMap(element)));
    _currentCategory = categoryList.first;
    _contentState = ScreenStates.Success;
    await _setCategoryBlogs(token);
    notifyListeners();
}

  Future<void>  _setCategoryBlogs(String token) async{
   _contentState = ScreenStates.Loading;
   notifyListeners();
   categoryBlogList.clear();
   Map<String, dynamic> response = await ApiService.sendPostRequest(endPoint: "/Blog/GetBlogs", postData: {"CategoryId": _currentCategory!.Id} , token: token);
   List<dynamic> categoryBlogs = response["Data"];
   categoryBlogs.forEach((element) => categoryBlogList.add(BlogModel.fromMap(element)));
   _contentState = ScreenStates.Success;
   notifyListeners();
  }

  Future<void> setCurrentCategory(CategoryModel categoryModel, BuildContext context)async{
    AuthProvider authProvider = Provider.of(context, listen: false);
    _currentCategory = categoryModel;
    await _setCategoryBlogs(authProvider.getUserToken!);
    notifyListeners();
  }

    setCurrentBlog(BlogModel blogModel){
    _currentBlog = blogModel;
    notifyListeners();
  }

  Future<void> getAllBlogs(String token) async{
   _contentState = ScreenStates.Loading;
   notifyListeners();
   blogList.clear();
   Map<String, dynamic> response = await ApiService.sendPostRequest(endPoint: "/Blog/GetBlogs", postData: {"CategoryId": ""} ,token: token);
   List<dynamic> allBlogs = response["Data"];
   allBlogs.forEach((element) => blogList.add(BlogModel.fromMap(element)));
   _contentState = ScreenStates.Success;
   notifyListeners();
  }

   Future<void> setFavoriteBlogs(BuildContext context)async{
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    await profileProvider.setAccountData(authProvider.getUserToken!);
    List<dynamic> favoriteBlogIds = profileProvider.getCurrentUser!.FavoriteBlogIds;
    _favoritiesBlogs = [];
    favoriteBlogIds.forEach((favoriteId) {
      blogList.forEach((blog){
        if(favoriteId.toString() == blog.Id){
          _favoritiesBlogs.add(blog);
        }
      });
    });
    notifyListeners();
  }

}