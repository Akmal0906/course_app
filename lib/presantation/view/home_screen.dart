import 'package:course_app/domain/fetch_data.dart';
import 'package:course_app/presantation/providers/course_provider.dart';
import 'package:course_app/presantation/view/group_screen.dart';
import 'package:flutter/material.dart';
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
    Provider.of<CourseProvider>(context, listen: false).getCurrentUser();

  }


  @override
  Widget build(BuildContext context) {
    print('HOME SCREEN WIDGET WORKING');


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Course app'),
      ),
      body: Consumer<CourseProvider>(
      builder: (BuildContext context, value, Widget? child) {
        print('CONSUMER WORKING');

        if (value.userModel.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print('CONSUMER 2 WORKING');

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
                  title: Center(child: Text(value.userModel[index].name!,
                    style:const TextStyle(color: Colors.white),)),
                  leading: Text(value.userModel[index].id!.toString()),
                  leadingAndTrailingTextStyle:const TextStyle(fontSize: 18),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            GroupScreen(id: value.userModel[index].id!)),
                        );
                  },
                ),
              );
            },
          );
        }
      },
    ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.refresh),
        onPressed: (){
          print('UPDATE SCREEN');
          context.read<CourseProvider>().getCurrentUser();
        },
      ),
    );
  }
}
