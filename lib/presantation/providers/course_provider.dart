import 'dart:convert';

import 'package:course_app/domain/fetch_data.dart';
import 'package:course_app/domain/models/course_model.dart';
import 'package:course_app/domain/models/group_model.dart';
import 'package:course_app/domain/models/result_group_model.dart';
import 'package:flutter/material.dart';
import '../../domain/models/all_homework_model.dart';

class CourseProvider extends ChangeNotifier {
  FetchCourse fetchCourse = FetchCourse();
  List<Course> _courseModel = [];

  List<Course> get userModel => _courseModel;
  bool isLoading = true;

  Future getAllCourse() async {
     isLoading = true;
    _courseModel = (await fetchCourse.getCourse())!;
     isLoading = false;
    notifyListeners();
    // check();
  }

  void check() {
    isLoading = !isLoading;
    notifyListeners();
  }

  List<GroupModel> _groupModel = [];

  List<GroupModel> get groupModel => _groupModel;

  Future getGroupInfo(String id) async {
    _groupModel = (await fetchCourse.getGroup(id))!;
    notifyListeners();
  }
}

class AllWorkProvider extends ChangeNotifier {
  FetchCourse fetchCourse = FetchCourse();
  List<AllHomeWorkModel> _allhomeworkModel = [];

  List<AllHomeWorkModel> get allhomeworkModel => _allhomeworkModel;
  bool isLoading = true;

  Future getAllWork({required String courseId, required String groupId}) async {
    _allhomeworkModel = (await fetchCourse.getHomeWork(courseId, groupId))!;
    notifyListeners();
    check();
    print('ALLHOMEWORK LENGTH $allhomeworkModel');
  }

  void check() {
    isLoading = !isLoading;
    notifyListeners();
  }

  List<Result> _result = [];

  List<Result> get resultModel => _result;
  List compareList = [];

  Future<List<Result>> getResult(String map) async {
    _result = (await fetchCourse.getResult(jsonDecode(map)))!;
    notifyListeners();
    return _result;
  }
}
