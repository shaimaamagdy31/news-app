import 'package:flutter/material.dart';
import '../../../core/remote/network/api_manager.dart';
import '../../../model/sourses_response/sources.dart';

class SourcesViewModel extends ChangeNotifier{
  List<Source>? sources;
  String? errorMessage;
  bool isLoading = false;
  getSources(String selectedCategory)async{
    try{
      sources = null;
      errorMessage = null;
      isLoading = true;
      notifyListeners();
      var response = await ApiManager.getSources(selectedCategory);
      isLoading = false;
      if(response.status!="error"){
        // success logic data
        sources = response.sources;
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