import 'package:course_app/presantation/providers/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultGroupScreen extends StatefulWidget {
  final AllWorkProvider provider;
  final Map<String, dynamic> map;

  const ResultGroupScreen(
      {super.key, required this.provider, required this.map});

  @override
  State<ResultGroupScreen> createState() => _ResultGroupScreenState();
}

class _ResultGroupScreenState extends State<ResultGroupScreen> {
  @override
  Widget build(BuildContext context) {
    print('RESULT ${widget.provider.allhomeworkModel}');
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Provider.of<AllWorkProvider>(context, listen: false)
              .getResult(widget.map),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('FUTUREBUILDER WAITING');
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Consumer<AllWorkProvider>(
                builder: (BuildContext context, AllWorkProvider value,
                    Widget? child) {
                  print('RESULT LENGTH VALUE=${value.resultModel.length}');
                  return ListView.builder(
                    itemCount: value.resultModel.length,
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
                            value.resultModel[index].firstName!,
                            style: const TextStyle(color: Colors.white),
                          )),
                          leading: Text(
                              value.resultModel[index].tasks![index].name!),
                          leadingAndTrailingTextStyle:
                              const TextStyle(fontSize: 18),
                          onTap: () {},
                        ),
                      );
                    },
                  );
                },
              );
            }
            return const Center(
              child: Text('DATA DO NOT COME TO THE LAPTOP'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            print('DATA COMING');
            Provider.of<AllWorkProvider>(context, listen: false)
                .getResult(widget.map);
          },
        ),
      ),
    );
  }
}
