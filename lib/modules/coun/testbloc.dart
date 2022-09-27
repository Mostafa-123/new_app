import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_start/layout/todoapp/cubit/cubit.dart';
import 'package:shop_app_start/layout/todoapp/cubit/states.dart';

class tes extends StatelessWidget {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => counterCubit(),
      child: BlocConsumer<counterCubit, counterStates>(
        builder: (BuildContext context, state) => Scaffold(
          body: SafeArea(
            child: Text(
              '${counterCubit.get(context).counter}',
              style: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          floatingActionButton: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      counterCubit.get(context).plus();
                    }),
                FloatingActionButton(
                    child: Icon(Icons.remove),
                    onPressed: () {
                      counterCubit.get(context).minus();
                    }),
              ],
            ),
          ),
        ),
        listener: (BuildContext context, state) {},
      ),
    );
  }
}
