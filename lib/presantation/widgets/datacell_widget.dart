import 'package:course_app/utilis/contents.dart';
import 'package:flutter/material.dart';

 dataCellWidget(String text){
  return  DataCell(Text(text,style: style.copyWith(
      fontSize: 16,
      color: Colors.white70),));
}
