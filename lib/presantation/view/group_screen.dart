import 'package:course_app/domain/models/course_model.dart';
import 'package:course_app/presantation/view/all_homework_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';

class GroupScreen extends StatefulWidget {
  final int id;

  const GroupScreen({super.key, required this.id});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  void initState() {
    super.initState();
    print('GRUOP SCREEN INIT STATE WORKING');
    Provider.of<CourseProvider>(context, listen: false).getGroupInfo(widget.id);
  }

  Future _refresh() async {
    context.watch<CourseProvider>().getGroupInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print('GROUP SCREEN WIDGET WORKING');

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Consumer<CourseProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.groupModel.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: value.userModel.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.black38,
                              offset: Offset(0, 4))
                        ]),
                    child: ListTile(
                      title: Center(
                          child: Text(
                        value.groupModel[index].name,
                        style: const TextStyle(color: Colors.white),
                      )),
                      leading: Text(value.groupModel[index].course.toString()),
                      leadingAndTrailingTextStyle:
                          const TextStyle(fontSize: 18),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>  AllHomeWorkScreen(
                                  courseId: widget.id,
                                  groupId: value.groupModel[index].id,
                                )));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          Provider.of<CourseProvider>(context).getGroupInfo(widget.id);
        },
      ),
    );
  }
}
