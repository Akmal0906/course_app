import 'package:course_app/domain/fetch_data.dart';
import 'package:course_app/presantation/providers/course_provider.dart';
import 'package:course_app/presantation/view/result_by_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllHomeWorkScreen extends StatefulWidget {
  final int groupId;
  final int courseId;

  const AllHomeWorkScreen(
      {super.key, required this.courseId, required this.groupId});

  @override
  State<AllHomeWorkScreen> createState() => _AllHomeWorkScreenState();
}

class _AllHomeWorkScreenState extends State<AllHomeWorkScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllWorkProvider>(context, listen: false)
        .getAllWork(widget.courseId, widget.groupId);

  }

  Future _refresh() async {
    //context.watch<CourseProvider>().getGroupInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<AllWorkProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<AllWorkProvider>(
            builder: (BuildContext context, value, Widget? child) {
              print('COUNT ${count.allhomeworkModel.length}');
              if (value.allhomeworkModel.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: value.allhomeworkModel.length,
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
                          value.allhomeworkModel[index].assignment!.name!,
                          style: const TextStyle(color: Colors.white),
                        )),
                        leading:
                            Text(value.allhomeworkModel[index].group!.name!),
                        leadingAndTrailingTextStyle:
                            const TextStyle(fontSize: 18),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ResultGroupScreen(
                                    provider: count,
                                    map: {
                                      "assignment_name": value
                                          .allhomeworkModel[index]
                                          .assignment!
                                          .name!, "group_name":value.allhomeworkModel[index].group!.name!
                                    },
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
            print('DATA COMING');
            FetchCourse().getResult({
              "assignment_name": "print",
              "group_name": "python23a"
            }).then((value) => print('VALUE: ${value!.toList()}'));
          },
        ),
      ),
    );
  }
}
