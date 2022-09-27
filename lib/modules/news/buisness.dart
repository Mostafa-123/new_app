import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shop_app_start/layout/newsapp/cubit/cubit.dart';
import 'package:shop_app_start/layout/newsapp/cubit/states.dart';
import 'package:shop_app_start/shared/componant/componant.dart';

class business extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newCubit, newsapp>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = newCubit.getInstance(context).Buisness;
        if (list != null) {
          return ScreenTypeLayout(mobile:Builder(builder:(context){
            newCubit.getInstance(context).setDesktop(false);
            return articleBBuilder(list, context, state);
          }),
            desktop: Expanded(child: Builder(builder: (context){
              newCubit.getInstance(context).setDesktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                        width: 500.0,
                        child: articleBBuilder(list, context, state)),
                  ),
                  if(list.length>0)
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: Text('${list[newCubit.getInstance(context).SelectedBuisnessItem]['description']}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        color: Colors.grey[300],
                      ),
                    ),
                ],
              );
            },)),
            breakpoints: ScreenBreakpoints(
                desktop: 600,
                tablet: 600,
                watch: 100
            ),
          );

        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
