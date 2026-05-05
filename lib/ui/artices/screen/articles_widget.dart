import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_application/core/resources/app_constants.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../model/category_model.dart';
import '../widgets/articles_list.dart';

class ArticlesWidget extends StatefulWidget {
  CategoryModel selectedCategory;
  ArticlesWidget(this.selectedCategory);

  @override
  State<ArticlesWidget> createState() => _ArticlesWidgetState();
}

class _ArticlesWidgetState extends State<ArticlesWidget> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: REdgeInsets.all(15),
            child: DefaultTabController(
              length:AppConstants.dummySourcesList.length ,
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
                      tabs: AppConstants.dummySourcesList.map((source)=>Tab(
                        text:source ,
                      )).toList()),
                  Expanded(child: TabBarView(children: AppConstants.dummySourcesList.map((source) => ArticlesList()).toList()),)
                ]
              ),
            ),
    );
  }
}
