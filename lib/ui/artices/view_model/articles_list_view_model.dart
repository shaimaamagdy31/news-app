import 'package:flutter/material.dart';
import 'package:news_application/model/articles_response/article.dart';

import '../../../core/remote/network/api_manager.dart';
class ArticlesListViewModel extends ChangeNotifier {
  List<Article>? articles;
  String? errorMessage;
  bool isLoading = false;
  getArticles(String sourceId)async{

    try{
      articles = null;
      errorMessage = null;
      isLoading = true;
      notifyListeners();
      var response = await ApiManager.getArticles(sourceId);
      isLoading = false;
      if(response.status!="error"){
        // success logic data
        articles = response.articles;
      }else{
        // server error
        errorMessage = response.message;
      }
      notifyListeners();
    }catch(e){
      isLoading = false;
      errorMessage = "No Internet Connection";
      notifyListeners();
    }



  }
}