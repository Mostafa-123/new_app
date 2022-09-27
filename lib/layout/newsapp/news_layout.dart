import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_start/layout/newsapp/cubit/cubit.dart';
import 'package:shop_app_start/layout/newsapp/cubit/states.dart';
import 'package:shop_app_start/modules/news/search.dart';
import 'package:shop_app_start/shared/cubit/cubit.dart';

class news_sc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newCubit, newsapp>(
        builder: (context, states) {
          var cubit = newCubit.getInstance(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('newsApp'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed: () {
                    navCubit.getInstance(context).changeAppMode();
                  },
                ),
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            // onPressed: () {
            // DioHelper.getData(
            //   url: 'v2/top-headlines',
            // query: <String, dynamic>{
            // 'country': 'eg',
            //'category': 'business',
            //'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
            //}).then((value) {
            //print(value.data['totalResults']);
            //});
            //},
            //child: Icon(Icons.add),
            //),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.change(index);
                },
                items: cubit.bottomItem),
          );
        },
        listener: (context, states) {});
  }
}
