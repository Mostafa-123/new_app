import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_start/shared/componant/componant.dart';
import 'package:shop_app_start/shared/cubit/cubit.dart';
import 'package:shop_app_start/shared/cubit/states.dart';

class firs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<navCubit, navStates>(
      builder: (BuildContext context, navStates state) {
        var tasks = navCubit.getInstance(context).newlists;
        return tasks.length > 0
            ? ListView.separated(
                itemBuilder: (context, index) => dat(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                itemCount: tasks.length)
            : Center(child: CircularProgressIndicator());
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
