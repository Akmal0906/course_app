import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';

class GroupScreen extends StatefulWidget {
  final String id;
  final String groupName;

  const GroupScreen({super.key, required this.id, required this.groupName});

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

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff9E9E9E),
        appBar: AppBar(
          backgroundColor: const Color(0xff9E9E9E),
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
          title: Text(
            widget.groupName,
            style: const TextStyle(
                color: Color(0xff464141),
                fontWeight: FontWeight.w700,
                fontSize: 30),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<CourseProvider>(
            builder: (BuildContext context, value, Widget? child) {
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (value.error.isNotEmpty) {
                return Center(
                  child: Text(value.error),
                );
              } else if (value.groupModel.isNotEmpty) {
                return ListView.builder(
                  itemCount: value.userModel.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                          style: const TextStyle(color: Color(0xff685967)),
                        )),
                        leading: Text('${index + 1}'),
                        leadingAndTrailingTextStyle: const TextStyle(
                            fontSize: 18, color: Color(0xff685967)),
                        onTap: () {
                          GoRouter.of(context).pushNamed('AllWork',
                              pathParameters: {
                                'courseId': widget.id,
                                'groupId': value.groupModel[index].id.toString()
                              });
                        },
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
