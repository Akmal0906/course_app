import 'package:course_app/presantation/providers/course_provider.dart';
import 'package:course_app/utilis/contents.dart';
import 'package:course_app/utilis/screen_colors.dart';
import 'package:course_app/utilis/screen_images_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../domain/models/course_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Course> list = [];

  @override
  void initState() {
    super.initState();
    print('HOME SCREEN INIT STATE WORKING');
    Provider.of<CourseProvider>(context, listen: false).getAllCourse();
  }

  @override
  Widget build(BuildContext context) {
    print('HOME SCREEN WIDGET WORKING');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffe9e9e9),
        body: Consumer<CourseProvider>(
          builder: (BuildContext context, value, Widget? child) {
            print('&&${value.userModel}');
            if (value.isLoading) {
              print('yea1');
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else
              if(value.userModel.isNotEmpty){ Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 28),
                  child: Text(
                    'Course App',
                    style: TextStyle(color: Color(0xff2d525d), fontSize: 28),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.userModel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          height: 148,
                          width: double.infinity,
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: listColor[index],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.black38,
                                    offset: Offset(0, 4))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                value.userModel[index].name!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              const SizedBox(
                                width: 28,
                              ),
                              Image(
                                image: AssetImage(listImages[index]),
                                fit: BoxFit.cover,
                                height: 108,
                                width: 148,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          GoRouter.of(context).pushNamed('Group',
                              pathParameters: {
                                'id': value.userModel[index].id.toString(),
                                'groupName': listGroup[index]
                              });
                        },
                      );
                    },
                  ),
                ),
              ],
            );}
              else
                if(value.userModel.isEmpty){return const Center(child: Text('Do not exist data'),);}
            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            print('UPDATE SCREEN');
            context.read<CourseProvider>().getAllCourse();
          },
        ),
      ),
    );
  }
}
