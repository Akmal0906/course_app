import 'package:course_app/domain/models/result_group_model.dart';
import 'package:course_app/presantation/providers/course_provider.dart';
import 'package:course_app/presantation/view/all_homework_screen.dart';
import 'package:course_app/presantation/view/group_screen.dart';
import 'package:course_app/presantation/view/course_list_screen.dart';
import 'package:course_app/presantation/view/result_by_group_screen.dart';
import 'package:course_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<CourseProvider>(create: (_) => CourseProvider()),
    ChangeNotifierProvider<AllWorkProvider>(create: (_) => AllWorkProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }

  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (context, state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: "Home",
            name: 'Home',
            builder: (context, state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            path: "Group/:id/:groupName",
            name: 'Group',
            builder: (context, state) {
              return GroupScreen(
                id: state.pathParameters["id"] ?? '',
                groupName: state.pathParameters['groupName'] ?? '',
              );
            },
          ),
          GoRoute(
            path: "AllWork/:courseId/:groupId",
            name: 'AllWork',
            builder: (context, state) {
              return AllHomeWorkScreen(
                courseId: state.pathParameters['courseId'] ?? '',
                groupId: state.pathParameters['groupId'] ?? '',
              );
            },
          ),
          GoRoute(
            path: "Result/:map",
            name: 'Result',
            builder: (context, state) {
              return ResultGroupScreen(
                map: state.pathParameters['map'] ?? '',
              );
            },
          ),

        ],
      ),
    ],
  );
}
