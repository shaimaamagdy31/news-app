
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/resources/colors_manager.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.lightPrimaryColor),
      ),
      child: Column(
        spacing: 10.h,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8.r),
             child: CachedNetworkImage(
               imageUrl: "https://images.unsplash.com/photo-1504711434969-e33886168f5c",
               height: 220.h,
               fit: BoxFit.cover,
               placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
               errorWidget: (context, url, error) => Center(child: Icon(Icons.error,size: 40.sp,),),
             ),
          ),
          Text(
            "40-year-old man falls 200 feet to his death while canyoneering at national park",
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "By : Jon Haworth",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Text(
                "15 minutes ago",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
