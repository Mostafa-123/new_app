import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_start/layout/newsapp/cubit/states.dart';
import 'package:shop_app_start/modules/news/buisness.dart';
import 'package:shop_app_start/modules/news/science.dart';
import 'package:shop_app_start/modules/news/settings.dart';
import 'package:shop_app_start/modules/news/sports.dart';
import 'package:shop_app_start/shared/network/remote/remote.dart';

class newCubit extends Cubit<newsapp> {
  newCubit() : super(intialNewsState());

  static newCubit getInstance(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];

  List<Widget> screens = [business(), sports(), science(), settings()];

  void change(int index) {
    currentIndex = index;
    //if (index == 0) {
    //getBuisness();
    //} else if (index == 1) {
    //getsports();
    //} else if (index == 2) {
    //getSceince();
    //}
    emit(changeNewsPages());
  }

  List<dynamic> Buisness=[];
  //List<bool>? BuisnessSelectedItem=[];
  int SelectedBuisnessItem=0;
  bool isDesktop=false;

  void setDesktop(bool value){
    isDesktop=value;
    emit(isDesktopState());
  }

  void getBuisness() {
    emit(getBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: <String, dynamic>{
      'country': 'eg',
      'category': 'business',
      'apiKey': 'cd84bfeb57794068912d77c81698c177'
    }).then((value) {
      //print(value.data['totalResults']);
      Buisness = value.data['articles'] as List<dynamic>;
     /* Buisness.forEach((element) {
        BuisnessSelectedItem!.add(false);
      });*/
      emit(getBusinessState());
    });
  }

  void SelectBuisnessItem(int index){
    /*for(int i=0;i<BuisnessSelectedItem!.length;i++){
      if(i==index){
        BuisnessSelectedItem![i]=true;
      }else{
        BuisnessSelectedItem![i]=false;
      }
    }
    BuisnessSelectedItem![index]=true;*/
    SelectedBuisnessItem=index;
    emit(SelectBusinessItemState());
  }

  List<dynamic>? sport;
  void getsports() {
    emit(getSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: <String, dynamic>{
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'cd84bfeb57794068912d77c81698c177'
    }).then((value) {
      //print(value.data['totalResults']);
      sport = value.data['articles'] as List<dynamic>;
      emit(getSportsState());
    });
  }

  List<dynamic>? Sceince;

  void getSceince() {
    emit(getScienceLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: <String, dynamic>{
      'country': 'eg',
      'category': 'science',
      'apiKey': 'cd84bfeb57794068912d77c81698c177'
    }).then((value) {
      //print(value.data['totalResults']);
      Sceince = value.data['articles'] as List<dynamic>;
      emit(getSceinceState());
    });
  }

  List<dynamic>? search;

  void searchh(String value) {
    emit(getSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: <String, dynamic>{
      'q': '$value',
      'apiKey': 'cd84bfeb57794068912d77c81698c177',
    }).then((value) {
      //print(value.data['totalResults']);
      search = value.data['articles'] as List;
      emit(getSearchState());
    });
  }

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
