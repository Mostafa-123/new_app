import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app_start/shared/cubit/cubit.dart';
import 'package:shop_app_start/shared/cubit/states.dart';

import 'package:sqflite/sqflite.dart';

class bottom extends StatelessWidget {
  var titleCon = TextEditingController();
  var timecon = TextEditingController();
  var datecon = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    return BlocConsumer<navCubit, navStates>(
      builder: (BuildContext context, navStates state) {
        return Scaffold(
          key: scaffoldKey,
          body: state is! getloadingDb
              ? navCubit
                  .getInstance(context)
                  .screens[navCubit.getInstance(context).current]
              : Center(child: CircularProgressIndicator()),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (navCubit.getInstance(context).show) {
                if (formKey.currentState!.validate()) {
                  navCubit.getInstance(context).insert(
                      title: titleCon.text,
                      time: timecon.text,
                      date: datecon.text);
                  // Navigator.pop(context);
                  //navCubit
                  // .getInstance(context)
                  //.show = false;
                  //setState(() {
                  //icin = Icons.edit;
                  //});
                }
              } else {
                scaffoldKey.currentState
                    ?.showBottomSheet<dynamic>(
                      (context) => Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: titleCon,
                                enableSuggestions: true,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'not allowed empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'title',
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: timecon,
                                enableSuggestions: true,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'not allowed empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'time',
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timecon.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                      icon: Icon(Icons.watch_later_outlined)),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: datecon,
                                enableSuggestions: true,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'not allowed empty';
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'date',
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2022-09-02'))
                                          .then((value) {
                                        datecon.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((dynamic value) {
                  navCubit
                      .getInstance(context)
                      .changesheet(isshow: false, icon: Icons.edit);
                  //show = false;
                  // setState(() {
                  // icin = Icons.edit;
                  //});
                });
              }
              navCubit
                  .getInstance(context)
                  .changesheet(isshow: true, icon: Icons.add);
              //show = true;
              //setState(() {
              //  icin = Icons.add;
              // });
            },
            child: Icon(
              navCubit.getInstance(context).icin,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: navCubit.getInstance(context).current,
            onTap: (index) {
              navCubit.getInstance(context).changeStates(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'news',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: 'mid',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: 'finals',
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, navStates state) {
        if (state is insertDb) {
          Navigator.pop(context);
        }
      },
    );
  }
}
