import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyMusicScreen extends StatefulWidget {
  const MyMusicScreen({super.key});

  @override
  State<MyMusicScreen> createState() => _MyMusicScreenState();
}

class _MyMusicScreenState extends State<MyMusicScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _images;

  // 이미지 로드 함수
  Future<void> _loadImages() async {
    final pickedImages = await _picker.pickMultiImage();
    setState(() {
      _images = pickedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FloatingActionButton(
            onPressed: _loadImages,
            child: Text('사진 불러오기'),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 열의 수
                crossAxisSpacing: 4.0, // 열 간의 간격
                mainAxisSpacing: 4.0, // 행 간의 간격
              ),
              itemCount: _images?.length ?? 0,
              itemBuilder: (context, index) {
                if (_images != null && index < _images!.length) {
                  return Image.file(File(_images![index].path), fit: BoxFit.cover);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}