import 'package:course_app/presantation/providers/course_provider.dart';
import 'package:course_app/utilis/contents.dart';
import 'package:course_app/utilis/screen_colors.dart';
import 'package:course_app/utilis/screen_images_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CourseProvider>(context, listen: false).getAllCourse();
  }

  Future _refresh(BuildContext context) async {
    Provider.of<CourseProvider>(context, listen: false).getAllCourse();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffe9e9e9),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Course',style: TextStyle(color: Colors.black,fontSize: 20,letterSpacing: 1),),
          elevation: 0,
          backgroundColor: Color(0xffe9e9e9),
        ),
        body: RefreshIndicator(
          onRefresh: () async => _refresh(context),
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              Consumer<CourseProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.isLoading) {
                    print('yea1');
                    return SliverToBoxAdapter(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (value.userModel.isNotEmpty) {
                    return SliverList.builder(
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
                            GoRouter.of(context)
                                .pushNamed('Group', pathParameters: {
                              'id': value.userModel[index].id.toString(),
                              'groupName': listGroup[index]
                            });
                          },
                        );
                      },
                    );
                  }else if (value.error.isNotEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text('Please try reloading the page'),
                      ),
                    );
                  }
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
