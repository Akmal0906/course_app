import 'dart:convert';

import 'package:course_app/domain/models/result_group_model.dart';
import 'package:flutter/material.dart';

class CurrentUserResult extends StatefulWidget {
  final Result result;

  const CurrentUserResult({super.key, required this.result});

  @override
  State<CurrentUserResult> createState() => _CurrentUserResultState();
}

class _CurrentUserResultState extends State<CurrentUserResult> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Column(
                children: [
                  const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/user1.png',
                      )),
                  Text(
                      '${widget.result.firstName!} ${widget.result.lastName!}'),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('${widget.result.github!} '),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: widget.result.tasks!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color:const  Color(0xffFF2869),
                    ),
                    child: ListTile(
                      title: Text(widget.result.tasks![index].name!),
                      subtitle: Text(
                        'Attempts ${widget.result.tasks![index].attempts!}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      trailing: widget.result.tasks![index].isCorrect == true
                          ? const Icon(Icons.check_circle)
                          : const Icon(Icons.close_sharp),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
