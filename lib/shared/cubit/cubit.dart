// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures, unnecessary_string_interpolations, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/modules/social_app/new_post/newpost.dart';
import 'package:socialm/shared/cubit/state.dart';
import 'package:socialm/shared/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isBottomSheetShow = false;
  IconData fadeIcon = Icons.edit;

  static AppCubit? get(context) => BlocProvider.of(context);
  var currentIndex = 0;

  List<String> title = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  List<Widget> screen = [
    NewPost(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarStates());
  }

  void createDatabase() {
    openDatabase(
      'toda.db',
      version: 1,
      onCreate: (Database db, int version) {
        print('database Create');
        db
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table Create');
        }).catchError((error) {
          print("error is Create ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseStates());
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLodeStates());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseStates());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,date ,time , status) VALUES("$title","$date","$time","new")')
          .then((value) {
        emit(AppInsertDatabaseStates());
        getDataFromDatabase(database);
        print('$value Inserted Successfully');
      }).catchError((error) {
        print("error is insert ${error.toString()}");
      });
    });
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseStates());
    });
  }

  void changeBottomSheetStates({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShow = isShow;
    fadeIcon = icon;
    emit(AppChangeBottomSheetStates());
  }

  void deleteData({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseStates());
    });
  }

  bool isDark = false;

  void themeMode({bool? fromSheard}) {
    if (fromSheard != null) {
      isDark = fromSheard;
      emit(AppThemeModeStates());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: "isDark", value: isDark).then((value) {
        emit(AppThemeModeStates());
      });
    }
  }
}
