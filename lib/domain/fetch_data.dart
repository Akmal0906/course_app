import 'dart:convert';

import 'package:course_app/domain/models/all_homework_model.dart';
import 'package:course_app/domain/models/course_model.dart';
import 'package:course_app/domain/models/group_model.dart';
import 'package:course_app/domain/models/result_group_model.dart';
import 'package:http/http.dart' as http;

class FetchCourse {
  Future<List<Course>?> getCourse() async {
    const String url = 'http://cahomeworkapi.pythonanywhere.com/courses/';
    Uri uri = Uri.parse(url);
    var response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      List<Course> list =
          jsonResponse.map((job) => Course.fromJson(job)).toList();
      print(list);
      return list;
    }
    return null;
  }

  Future<List<GroupModel>?> getGroup(String id) async {
    const String url = 'http://cahomeworkapi.pythonanywhere.com/courses/';
    Uri uri = Uri.parse('$url$id/groups/');
    var response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      List<GroupModel> list =
          jsonResponse.map((job) => GroupModel.fromJson(job)).toList();
      print(list);
      return list;
    }
    return null;
  }

  Future<List<AllHomeWorkModel>?> getHomeWork({int id = 1, int id2 = 1}) async {
    const String url = 'http://cahomeworkapi.pythonanywhere.com/courses/';
    Uri uri = Uri.parse('$url$id/groups/$id2/homeworks/');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      List<AllHomeWorkModel> list =
          jsonResponse.map((job) => AllHomeWorkModel.fromJson(job)).toList();
      print(list);
      return list;
    }
    return null;
  }

  Future<List<Result>?> getResult(
      Map<String,dynamic> map) async {
    const String url = 'cahomeworkapi.pythonanywhere.com';
    Uri uri = Uri.http(url,'/reporter/by-group/',map);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      List<Result> list =
          jsonResponse.map((job) => Result.fromJson(job)).toList();
      print('LIST METHOD $list');
      return list;
    }
    return null;
  }
}
