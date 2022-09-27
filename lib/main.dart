
import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shop_app_start/layout/newsapp/cubit/cubit.dart';
import 'package:shop_app_start/layout/newsapp/news_layout.dart';
import 'package:shop_app_start/shared/bloc_observer.dart';
import 'package:shop_app_start/shared/cubit/cubit.dart';
import 'package:shop_app_start/shared/cubit/states.dart';
import 'package:shop_app_start/shared/network/local/local.dart';
import 'package:shop_app_start/shared/network/remote/remote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  blocObserver:
  MyBlocObserver();
  //if(Platform.isWindows)
  /*await DesktopWindow.setMinWindowSize(Size(
      600.0,
      500.0
    ));*/
  DioHelper.inia();
  await chache_Helper.init();
  bool? isDark = chache_Helper.getbool(key: 'isDark');
  /* // bool? onBoarding = chache_Helper.getbool(key: 'onBoarding');
 // Widget? widg;
  //tokens = chache_Helper.getString(key: 'token') ?? '';
  //if (onBoarding != null) {
    //if (tokens != null) {
      //widg = shopLayout();
    //} else {
     // widg = logins();
    //}
  } else {
    widg = OnBoardingScreen();
  } */
  //bool? isDark = chache_Helper.getbool(key: 'isDark');
  BlocOverrides.runZoned(() {
    runApp(MyApp(isDark));
  });
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  //final Widget? widg;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => newCubit()
            ..getBuisness()
            ..getsports()
            ..getSceince(),
        ),
        BlocProvider(
          create: (BuildContext context) => navCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        /* BlocProvider(
            create: (BuildContext context) => shopCubit()..getHomeData()) */
      ],
      child: BlocConsumer<navCubit, navStates>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.green[900],
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.greenAccent[700],
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: HexColor('333739'),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              themeMode: navCubit.getInstance(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: news_sc(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
