import 'dart:convert';
import 'package:course_app/domain/models/all_homework_model.dart';
import 'package:course_app/domain/models/course_model.dart';
import 'package:course_app/domain/models/group_model.dart';
import 'package:course_app/domain/models/result_group_model.dart';
import 'package:http/http.dart' as http;

class FetchCourse {
  Future<List<Course>?> getCourse() async {
    const String url = 'http://cahomeworkapi.pythonanywhere.com/courses/';
    const String url2 = '/courses/';
    Uri uri = Uri.parse(url);
    var response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print(jsonResponse[0]['name']);
      List<Course> list =
          jsonResponse.map((job) => Course.fromJson(job)).toList();
      print(list);

      return list;
    }
    return null;
  }

  Future<List<GroupModel>?> getGroup(String id) async {
    const String url = 'http://cahomeworkapi.pythonanywhere.com/courses/';
    print('ID :$id');
    Uri uri = Uri.parse('$url$id/groups/');
    var response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      List<GroupModel> list =
          jsonResponse.map((job) => GroupModel.fromJson(job)).toList();
      return list;
    }
    return null;
  }

  Future<List<AllHomeWorkModel>?> getHomeWork(String id, String id2) async {
    const String url = 'http://cahomeworkapi.pythonanywhere.com/courses/';
    Uri uri = Uri.parse('$url$id/groups/$id2/homeworks/');
    print('ID2: $id2');
    var response = await http.get(uri);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List jsonResponse = json.decode(response.body);
      print('ALL Work ${jsonResponse}');

      List<AllHomeWorkModel> list =
          jsonResponse.map((job) => AllHomeWorkModel.fromJson(job)).toList();

      return list;
    }
    return null;
  }

  Future<List<Result>?> getResult(Map<String, dynamic> map) async {
    const String url = 'cahomeworkapi.pythonanywhere.com';
    Uri uri = Uri.http(url, '/reporter/by-group/', map);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print('LIST METHOD $jsonResponse');
      print('LIST METHOD+ ${response.body[1]}');

      List<Result> list =
          jsonResponse.map((job) => Result.fromJson(job)).toList();

      if (list.length > 1) {
        for (int i = 0; i < list.length; i++) {
          int count1 = 0;
          int attemp=0;

          for (int j = 0; j < list[i].tasks!.length; j++) {
            attemp+=list[i].tasks![j].attempts!;
            if (list[i].tasks?[j].isCorrect == true) {
              count1++;
            }
          }
          list[i].count = count1;
          list[i].percent=attemp==0?0:count1/attemp;
          count1 = 0;
          attemp=0;
        }

        list.sort((a, b) => a.percent!.compareTo(b.count as num));
        print('SORT LIST==${list.map((e) => e.toJson()).toList()}');

        return list.reversed.toList();
      } else {
        int count1 = 0;
        for (int i = 0; i < list[0].tasks!.length; i++) {
          if (list[0].tasks?[i].isCorrect == true) {
            count1++;
          }
        }
        list[0].count = count1;
        count1 = 0;

        return list;
      }
    }
    return null;
  }
}
