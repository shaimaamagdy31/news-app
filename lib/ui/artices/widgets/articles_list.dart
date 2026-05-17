import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return  BlocProvider(
      create: (context) => ArticlesListViewModel()..getArticles(source.id!),
      child: BlocBuilder<ArticlesListViewModel,ArticlesListStates>(
        builder: (context, state) {
          switch(state){

            case ArticlesListLoadingState():{
              return Center(child: CircularProgressIndicator(),);
            }
            case ArticlesListErrorState():{
              return Center(child: Text(state.errorMessage),);
            }
            case ArticlesListSuccessState():{
              List<Article> articles = state.articles;
              if(articles.isEmpty){
                return Center(child: Text("No articles found"),);
              }
              return ListView.separated(
                  itemBuilder: (context, index) => ArticleItem(article: articles[index],),
                  separatorBuilder: (context, index) => SizedBox(height: 16.h,),
                  itemCount: articles.length
              );
            }
          }
        },
      ),
    );
  }

}
