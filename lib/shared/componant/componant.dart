import 'dart:isolate';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_start/layout/newsapp/cubit/cubit.dart';
import 'package:shop_app_start/layout/newsapp/cubit/states.dart';
import 'package:shop_app_start/modules/news/web_view/web_view_screen.dart';
import 'package:shop_app_start/shared/cubit/cubit.dart';

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget dat(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        navCubit.getInstance(context).delete(
              id: model['id'] as int,
            );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: () {
                  navCubit
                      .getInstance(context)
                      .update(status: 'done', id: model['id'] as int);
                },
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.amber,
                )),
            IconButton(
                onPressed: () {
                  navCubit
                      .getInstance(context)
                      .update(status: 'archive', id: model['id'] as int);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(dynamic article, BuildContext context,index) => Container(
  color: newCubit.getInstance(context).SelectedBuisnessItem==index && newCubit.getInstance(context).isDesktop==true? Colors.grey[300]:null,
  child:   InkWell(

        onTap: () {
          if( newCubit.getInstance(context).isDesktop==true){
          newCubit.getInstance(context).SelectBuisnessItem(index);}
          else{
          Navigator.push<void>(

            context,

            MaterialPageRoute(

              builder: (context) => web_view(article['url'] as String),

            ),

          );}

        },

        child: Padding(

          padding: const EdgeInsets.all(20.0),

          child: Row(

            children: [

              Container(

                width: 120.0,

                height: 120.0,

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(

                    10.0,

                  ),

                  image: DecorationImage(

                    image: NetworkImage('${article['urlToImage']}'),

                    fit: BoxFit.cover,

                  ),

                ),

              ),

              SizedBox(

                width: 20.0,

              ),

              Expanded(

                child: Container(

                  height: 120.0,

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [

                      Expanded(

                        child: Text(

                          '${article['title']}',

                          style: Theme.of(context).textTheme.bodyText1,

                          maxLines: 3,

                          overflow: TextOverflow.ellipsis,

                        ),

                      ),

                      Text(

                        '${article['publishedAt']}',

                        style: TextStyle(

                          color: Colors.grey,

                        ),

                      ),

                    ],

                  ),

                ),

              ),

              SizedBox(

                width: 15.0,

              ),

            ],

          ),

        ),

      ),
);

Widget articleBBuilder(List list, BuildContext context, newsapp state) =>
    ConditionalBuilder(
      condition: state is! getBusinessLoadingState,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context,index),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 8,
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

Widget articleSBuilder(List<dynamic> list, BuildContext context) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context,index),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
Widget articleCBuilder(List<dynamic> list, BuildContext context) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context,index),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

Widget articleBuilder(
        dynamic list, newsapp state, bool isSearch, BuildContext context) =>
    ConditionalBuilder(
      condition: state is! getSearchLoadingState,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context,index),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 8,
      ),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      validator: (s) {
        validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(BuildContext context, Widget widget) => Navigator.push<void>(
    context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil<void>(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({required String message, required toastColor colorToast}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: chooseToastColor(colorToast),
        textColor: Colors.white,
        fontSize: 16.0);

enum toastColor { SUCCESS, ERROR, WARNING }

Color chooseToastColor(toastColor toasted) {
  Color chossen;
  switch (toasted) {
    case toastColor.SUCCESS:
      chossen = Colors.greenAccent;
      break;
    case toastColor.ERROR:
      chossen = Colors.amberAccent;
      break;
    case toastColor.WARNING:
      chossen = Colors.redAccent;
      break;
  }
  return chossen;
}
