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
  bool isLoading = false;
  String error = '';

  Future getAllCourse() async {
    try {
      isLoading = true;
      _courseModel = (await fetchCourse.getCourse())!;
      isLoading = false;
      notifyListeners();
    } catch (onError) {
      isLoading = false;
      error = onError.toString();
      notifyListeners();
    }

    // check();
  }

  List<GroupModel> _groupModel = [];

  List<GroupModel> get groupModel => _groupModel;

  Future getGroupInfo(String id) async {
    try {
      error = '';
      isLoading = true;
      _groupModel = (await fetchCourse.getGroup(id))!;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}

class AllWorkProvider extends ChangeNotifier {
  FetchCourse fetchCourse = FetchCourse();
  List<AllHomeWorkModel> _allhomeworkModel = [];

  List<AllHomeWorkModel> get allhomeworkModel => _allhomeworkModel;
  bool isLoading = false;
  String error = '';

  Future getAllWork({required String courseId, required String groupId}) async {
    try {
      error = '';
      isLoading = true;
      _allhomeworkModel = (await fetchCourse.getHomeWork(courseId, groupId))!;
      isLoading = false;
    } catch (e) {
      error = e.toString();
      isLoading = false;
    }
    notifyListeners();

    print('ALLHOMEWORK LENGTH $allhomeworkModel');
  }

  Future refresh({required String courseId, required String groupId}) async {
    try {
      error = '';
      isLoading = true;
      _allhomeworkModel = (await fetchCourse.getHomeWork(courseId, groupId))!;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
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
