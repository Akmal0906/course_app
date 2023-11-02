import 'dart:convert';

import 'package:course_app/presantation/providers/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AllHomeWorkScreen extends StatefulWidget {
  final String groupId;
  final String courseId;

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
        .getAllWork(groupId: widget.groupId, courseId: widget.courseId);
  }

  Future _refresh(BuildContext context) async {
    Provider.of<AllWorkProvider>(context, listen: false)
        .getAllWork(courseId: widget.courseId, groupId: widget.groupId);
    setState(() {});
    print('Refresh working');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffe9e9e9),
        appBar: AppBar(
          backgroundColor: const Color(0xffe9e9e9),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 32.0,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Home Work',
            style: TextStyle(
                color: Color(0xff464141),
                fontWeight: FontWeight.w700,
                fontSize: 30),
          ),
        ),
        body: Consumer<AllWorkProvider>(
          builder: (BuildContext context, value, Widget? child) {
            print('COUNT ${value.allhomeworkModel.length}');
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.error.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  _refresh(context);
                  print("sdfs");
                },
                child: Center(
                  child: Text(value.error),
                ),
              );
            } else if (value.allhomeworkModel.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async => _refresh(context),
                child: ListView.builder(
                  itemCount: value.allhomeworkModel.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        final Map map = {
                          'assignment_name':
                              value.allhomeworkModel[index].assignment!.name,
                          'group_name':
                              value.allhomeworkModel[index].group!.name
                        };

                        GoRouter.of(context).pushNamed('Result',
                            pathParameters: {'map': jsonEncode(map)});
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.black38,
                                  offset: Offset(0, 4))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Text(
                                value.allhomeworkModel[index].group!.name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Text(
                                value.allhomeworkModel[index].assignment!.name!,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff201F25)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (value.allhomeworkModel.isEmpty) {
              return const Center(
                child: Text('Do not exist data'),
              );
            }
            return const Center(
              child: Text('SomeThing Went Wrong'),
            );
          },
        ),
      ),
    );
  }
}
