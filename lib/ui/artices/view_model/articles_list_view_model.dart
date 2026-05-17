import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/model/articles_response/article.dart';
import '../../../core/remote/network/api_manager.dart';


class ArticlesListViewModel extends Cubit<ArticlesListStates>{
  ArticlesListViewModel():super(ArticlesListLoadingState());

  getArticles(String sourceId)async{
    try{
      // loading
      emit(ArticlesListLoadingState());
      var result = await ApiManager.getArticles(sourceId);
      if(result.status!="error"){
        // success
        emit(ArticlesListSuccessState(result.articles??[]));
      }else{
        // error
        emit(ArticlesListErrorState(result.message!));
      }
    }catch(e){
      // error
      emit(ArticlesListErrorState(e.toString()));
    }
  }

}

sealed class ArticlesListStates{}

class ArticlesListLoadingState extends ArticlesListStates{}
class ArticlesListErrorState extends ArticlesListStates{
  String errorMessage;
  ArticlesListErrorState(this.errorMessage);
}
class ArticlesListSuccessState extends ArticlesListStates{
  List<Article> articles;
  ArticlesListSuccessState(this.articles);
}