import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../model/category_model.dart';
import '../../../model/sourses_response/sources.dart';
import '../view_model/sources_view_model.dart';
import '../widgets/articles_list.dart';

class ArticlesWidget extends StatefulWidget {
  final CategoryModel selectedCategory;
  ArticlesWidget(this.selectedCategory);

  @override
  State<ArticlesWidget> createState() => _ArticlesWidgetState();
}

class _ArticlesWidgetState extends State<ArticlesWidget> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context)=>SourcesViewModel()..getSources(widget.selectedCategory.id),
        child:BlocBuilder<SourcesViewModel,SourcesState>(
          builder:(context,state){
            switch(state){
              case SourcesLoadingState():{
                return Center(child: CircularProgressIndicator(),);
              }
              case SourcesErrorState():{
                return Center(child: Text(state.errorMessage),);
              }
              case SourcesSuccessState():{
                List<Source> sourcesList =state.sources;
                return Padding(
                  padding: REdgeInsets.all(15),
                  child: DefaultTabController(
                    length:sourcesList.length ,
                    child: Column(
                      spacing: 16.h,
                      children: [
                        TabBar(
                            labelStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorsManager.lightPrimaryColor
                            ),
                            unselectedLabelStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorsManager.lightPrimaryColor
                            ),
                            dividerHeight: 0,
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            tabs: sourcesList.map((source)=>Tab(
                              text:source.name ,
                            )).toList()),
                        Expanded(child: TabBarView(children: sourcesList.map((source) => ArticlesList(source: source,),).toList()))
                      ],
                    ),
                  ),
                );

              }
            }
          }
        )
    );
  }
}
