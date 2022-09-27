import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_start/layout/todoapp/cubit/states.dart';

class counterCubit extends Cubit<counterStates> {
  counterCubit() : super(intial());

  static counterCubit get(BuildContext context) => BlocProvider.of(context);
  int counter = 0;
  void minus() {
    counter--;
    emit(dec());
  }

  void plus() {
    counter++;
    emit(inc());
  }
}
