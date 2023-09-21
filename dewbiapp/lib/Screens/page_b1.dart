import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageB1 extends StatefulWidget {
  const PageB1({super.key});

  @override
  State<PageB1> createState() => _PageB1State();
}

class _PageB1State extends State<PageB1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page B-1'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Page B-1', style: TextStyle(fontSize: 30)),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}