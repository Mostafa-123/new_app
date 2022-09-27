import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_start/layout/newsapp/cubit/cubit.dart';
import 'package:shop_app_start/layout/newsapp/cubit/states.dart';
import 'package:shop_app_start/shared/componant/componant.dart';

class science extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newCubit, newsapp>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = newCubit.getInstance(context).Sceince;
        if (list != null) {
          return articleCBuilder(list, context);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
