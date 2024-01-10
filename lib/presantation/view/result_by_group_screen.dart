import 'package:course_app/domain/models/result_group_model.dart';
import 'package:course_app/presantation/providers/course_provider.dart';
import 'package:course_app/presantation/widgets/datacell.dart';
import 'package:course_app/utilis/contents.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultGroupScreen extends StatefulWidget {

  final String map;

  const ResultGroupScreen({super.key, required this.map});

  @override
  State<ResultGroupScreen> createState() => _ResultGroupScreenState();
}

class _ResultGroupScreenState extends State<ResultGroupScreen> {
  late Future<List<Result>> res;

  @override
  void initState() {
    super.initState();
    res = Provider.of<AllWorkProvider>(context, listen: false)
        .getResult(widget.map);
  }

  Future _refresh(BuildContext context) async {
    res = Provider.of<AllWorkProvider>(context, listen: false)
        .getResult(widget.map);
    setState(() {

    });
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
            'Result',
            style: TextStyle(
                color: Color(0xff464141),
                fontWeight: FontWeight.w700,
                fontSize: 30),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => _refresh(context),
          child: CustomScrollView(
            slivers: [
              FutureBuilder(
                  future: res,
                  builder:
                      (BuildContext context,
                      AsyncSnapshot<List<Result>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {

                      return SliverToBoxAdapter(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      List jsonList =
                      snapshot.data!.map((e) => e.toJson()).toList();
                      return SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              headingRowColor:
                              const MaterialStatePropertyAll(Colors.blue),
                              border: TableBorder.all(
                                  color: Colors.black, width: 2),
                              dataRowMaxHeight: 78,
                              dataRowMinHeight: 48,
                              columns: List.generate(
                                  snapshot.data!.first.tasks!.length * 3 + 5,
                                      (index) =>
                                      DataColumn(
                                          label: Text(
                                            listColumn[index],
                                            style: style,
                                          ))),
                              rows: List.generate(
                                  snapshot.data!.length,
                                      (indexx) =>
                                      DataRow(
                                          color:
                                          MaterialStateProperty.all(
                                              Colors.brown),
                                          cells: [
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                    '${indexx + 1}',
                                                    style: style.copyWith(
                                                        fontSize: 16,
                                                        color: Colors.white70),
                                                  )),
                                            ),
                                            ...List.generate(
                                                4,
                                                    (index) =>
                                                    DataCell(Center(
                                                      child: Text(
                                                        jsonList[indexx]
                                                        [listRow2[index]]
                                                            .toString(),
                                                        style: style.copyWith(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .white70),
                                                      ),
                                                    ))),
                                            ...List.generate(
                                              snapshot.data![indexx].tasks!
                                                  .length *
                                                  3,
                                                  (index) {
                                                return CellWidget(
                                                    jsonList[indexx]
                                                    ['tasks']
                                                    [listCount[index]]
                                                    [listRow[index]]
                                                        .toString());
                                              },
                                            ),
                                          ]))),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                        child: const Center(
                          child: Text('Something went wrong'),
                        ),
                      );
                    } else {
                      return SliverToBoxAdapter(child: const SizedBox(
                        child: Center(
                          child: Text('Something went wrong'),
                        ),
                      ));
                    }
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              res = Provider.of<AllWorkProvider>(context, listen: false)
                  .getResult(widget.map);
            });
            print('SETSTATE WORKING ...');
          },
        ),
      ),
    );
  }
}
