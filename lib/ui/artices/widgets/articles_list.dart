import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_application/model/sourses_response/sources.dart';
import 'package:news_application/ui/artices/view_model/articles_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/remote/network/api_manager.dart';
import '../../../model/articles_response/article.dart';
import 'article_item.dart';


class ArticlesList extends StatelessWidget {

  final Source source;
  ArticlesList({required this.source});


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create:(context)=> ArticlesListViewModel()..getArticles(source.id??""),
      child:Consumer<ArticlesListViewModel>(
        builder: (context,viewModel,child){
          if(viewModel.isLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          if(viewModel.errorMessage!=null){
            return Center(child: InkWell(
                onTap: (){
                  viewModel.getArticles(source.id??"");
                },
                child: Text(viewModel.errorMessage!)
            ),);
          }

          List<Article> articles = viewModel.articles??[];

          if(articles.isEmpty){
            return Center(child: Text("No articles found"),);
          }
          return ListView.separated(
              itemBuilder: (context, index) => ArticleItem(article: articles[index],),
              separatorBuilder: (context, index) => SizedBox(height: 16.h,),
              itemCount: articles.length
          );
        },
      )
    );





      /* FutureBuilder(
      future: ApiManager.getArticles(source.id??""),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()),);
        }
        var response = snapshot.data;
        if(response?.status == "error"){
          return Center(child: Text(response?.message??""),);
        }
        List<Article> articles = response?.articles??[];

        if(articles.isEmpty){
          return Center(child: Text("No articles found"),);
        }
        return ListView.separated(
            itemBuilder: (context, index) => ArticleItem(article: articles[index],),
            separatorBuilder: (context, index) => SizedBox(height: 16.h,),
            itemCount: articles.length
        );
      },)*/
  }

}
