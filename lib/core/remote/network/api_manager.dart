import 'package:dio/dio.dart';
import 'package:news_application/model/sourses_response/sources_response.dart';
import '../../../model/articles_response/articles_response.dart';
import '../../resources/app_constants.dart';

class ApiManager {
  static Dio dio = Dio(
      BaseOptions(
          baseUrl: "https://newsapi.org"
      )
  );


  static Future<SourcesResponse> getsSources(String selectedCategory) async {
    var response = await dio.get("/v2/top-headlines/sources",queryParameters: {
      "apiKey":AppConstants.apiKey,
      "category":selectedCategory
    });

    SourcesResponse sourcesResponse=SourcesResponse.fromJson(response.data);
    return sourcesResponse;

  }

  static Future<ArticlesResponse> getArticles(String sourceId)async{
    //?sources=bbc-sport
    var response = await dio.get("/v2/everything",queryParameters: {
      "apiKey":AppConstants.apiKey,
      "sources":sourceId
    });
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(response.data);
    return articlesResponse;
  }




}