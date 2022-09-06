import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_cubit/cubit.dart';
import 'package:news_app/app_cubit/states.dart';

Widget buildArticleItem(articel, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                  '${articel['urlToImage']}',
                ),
                // image: NetworkImage(
                //   checkImage(articel),
                // ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Expanded(
                  child: Container(
                    height: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            '${articel['title']}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Text(
                          '${articel['publishedAt']}',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );

// bool loaded = false;
// String imgUrl = '';

// Future<String> checkImage(articel) async {
//   if (articel['urlToImage'] == null) {
//     return await
//         'https://banksiafdn.com/wp-content/uploads/2019/10/placeholde-image.jpg';
//   } else {
//     return await articel['urlToImage'];
//   }
// }

Widget myDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      color: Colors.grey,
      width: double.infinity,
      height: 1.0,
    ),
  );
}

Widget articalBuilder(list, context) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: 10,
    ),
    fallback: (context) => Center(
      child: CircularProgressIndicator(
        color: Colors.deepOrange,
      ),
    ),
  );
}
