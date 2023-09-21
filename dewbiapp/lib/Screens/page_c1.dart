import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageC1 extends StatefulWidget {
  const PageC1({super.key});

  @override
  State<PageC1> createState() => _PageC1State();
}

class _PageC1State extends State<PageC1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page C-1'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Page C-1', style: TextStyle(fontSize: 30)),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}