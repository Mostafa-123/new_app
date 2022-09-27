import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_start/modules/todo/final.dart';
import 'package:shop_app_start/modules/todo/mid.dart';
import 'package:shop_app_start/modules/todo/news.dart';
import 'package:shop_app_start/shared/cubit/states.dart';
import 'package:shop_app_start/shared/network/local/local.dart';
import 'package:sqflite/sqflite.dart';

class navCubit extends Cubit<navStates> {
  navCubit() : super(initialNav());

  static navCubit getInstance(BuildContext context) => BlocProvider.of(context);
  List<Widget> screens = [firs(), midel(), fina()];
  int current = 0;
  void changeStates(int index) {
    current = index;
    emit(changeNavState());
  }

  List<Map> newlists = [];
  List<Map> donelists = [];
  List<Map> archivelists = [];
  late Database db;
  void create() {
    openDatabase(
      'one.db',
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
        print('o');
      },
      onOpen: (db) {
        print('openeded');
        get(db);
      },
    ).then((value) {
      db = value;
      emit(createDb());
    });
  }

  void delete({
    required int id,
  }) {
    db.rawDelete('DELETE FROM Test WHERE id = ?', [id]).then((value) {
      get(db);
      emit(deleteDb());
    });
  }

  void update({
    required String status,
    required int id,
  }) {
    db.rawUpdate(
      'UPDATE Test SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      get(db);
      emit(updateDb());
    });
  }

  void get(Database database) {
    newlists = [];
    donelists = [];
    archivelists = [];
    emit(getloadingDb());
    database.rawQuery('SELECT * FROM Test')
      ..then((value) {
        value.forEach((element) {
          if (element['status'] == 'new')
            newlists.add(element);
          else if (element['status'] == 'done')
            donelists.add(element);
          else
            archivelists.add(element);
        });
        emit(getDb());
      });
  }

  Future insert({
    required String title,
    required String time,
    required String date,
  }) async {
    await db.transaction<dynamic>((Transaction txn) async {
      txn
          .rawInsert(
              'INSERT INTO Test(title,date,time,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('$value inserted');
        emit(insertDb());
        get(db);
      });
    });
  }

  IconData icin = Icons.edit;
  bool show = false;

  void changesheet({
    required bool isshow,
    required IconData icon,
  }) {
    show = isshow;
    icin = icon;

    emit(changesheetstate());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      chache_Helper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
