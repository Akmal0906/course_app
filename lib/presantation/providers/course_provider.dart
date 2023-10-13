import 'package:course_app/domain/fetch_data.dart';
import 'package:course_app/domain/models/course_model.dart';
import 'package:course_app/domain/models/group_model.dart';
import 'package:course_app/domain/models/result_group_model.dart';
import 'package:flutter/material.dart';

import '../../domain/models/all_homework_model.dart';

class CourseProvider extends ChangeNotifier{
  FetchCourse fetchCourse = FetchCourse();
  List<Course> _courseModel=[];

  List<Course> get userModel => _courseModel;
  List<GroupModel> _groupModel=[];

  List<GroupModel> get groupModel => _groupModel;
  List<AllHomeWorkModel> _allhomeworkModel=[];

  List<AllHomeWorkModel> get allhomeworkModel => _allhomeworkModel;
  Future getCurrentUser() async {

    _courseModel = (await fetchCourse.getCourse())!;
    notifyListeners();
  }
  Future getGroupInfo(int id) async {

    _groupModel = (await fetchCourse.getGroup(id.toString()))!;
    notifyListeners();
  }
  Future getAllWork(int courseId,int groupId) async {

    _allhomeworkModel = (await fetchCourse.getHomeWork(id: courseId,id2: groupId))!;
    notifyListeners();
  }
}

class AllWorkProvider extends ChangeNotifier{

 FetchCourse fetchCourse=FetchCourse();
  List<AllHomeWorkModel> _allhomeworkModel=[];

  List<AllHomeWorkModel> get allhomeworkModel => _allhomeworkModel;

  Future getAllWork(int courseId,int groupId) async {

    _allhomeworkModel = (await fetchCourse.getHomeWork(id: courseId,id2: groupId))!;
    notifyListeners();
  }

 List<Result> _result=[];

 List<Result> get resultModel => _result;
List compareList=[];
 Future getResult(Map<String,dynamic>map) async {

   _result = (await fetchCourse.getResult(map))!;
  notifyListeners();
   return _result;
 }
}