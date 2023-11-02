import 'package:flutter/material.dart';

class RefreshDemo extends StatelessWidget {
  const RefreshDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Your refresh logic goes here
        await Future.delayed(Duration(seconds: 2));
      },
      child: CustomScrollView(
        slivers: [
          // Wrap your widgets with the SliverToBoxAdapter
          SliverToBoxAdapter(
            child: Container(
                child: Column(children: [
              Text('Hello'),
              Text('World'),
            ])),
          ),
        ],
      ),
    );
  }
}
