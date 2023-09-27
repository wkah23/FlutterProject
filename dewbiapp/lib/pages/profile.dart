import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String dropName = '국산';
  String dropName1 = '현대';
  final foreignCar = ['벤츠','아우디','BMW','포르쉐','테슬라','미니'];
  String dropName2 = '벤츠';
  File? mPhoto;
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            const Text(
              '마이 프로필',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15,),
            imageProfile(),
            const SizedBox(height: 50,),
            nameTextField(),
            const SizedBox(height: 25,),
            const Text(
              '차종 선택',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            carTextField(),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80,
            // ignore: unnecessary_null_comparison
            backgroundImage: (image == null)
              ? const AssetImage('assets/images/profile.png')
              : FileImage(File(image!.path)) as ImageProvider
          ),
          
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(context: context, 
                  builder: ((builder) => bottomSheet()));
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.grey,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget nameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        labelText: '이름',
        hintText: '이름을 입력하세요',
      ),
    );
  }

  Widget carTextField() {
    return Row(
      children: [
        DropdownButton<String>(
          style: const TextStyle(color: Colors.black87),
          value: dropName,
          items: const [
            '수입',
            '국산',
          ].map((value1) {
            return DropdownMenuItem(
              value: value1,
              child: Text(value1),
            );
          }).toList(),
          hint: const Text('제조국'),
          onChanged: (String? value1) {
            setState(() {
              dropmenuSelected(value1!);
              dropName = value1;
            });
          },
        ),
        const SizedBox(width: 25,),
        DropdownButton<String>(
          style: const TextStyle(color: Colors.black87),
          value: dropName1,
          items: [
            '현대','기아','제네시스','쉐보레','르노삼성','쌍용'
          ].map((value2) {
              return DropdownMenuItem(
                value: value2,
                child: Text(value2),
              );
          }).toList(),
          hint: const Text('차제조사'),
          onChanged: (String? value2) {
            setState(() {
                dropName1 = value2!;
            });
          },
        ),
      ],
    );
  }
  void dropmenuSelected(String value) {
    if (value != '국산') {
      return DropdownMenuItem(
        value: dropName2,
        child: child
      )
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            '프로필 사진을 선택하세요',
            style: TextStyle(fontSize: 20,),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: const Icon(Icons.camera, size: 30,),
                label: const Text('카메라', style: TextStyle(fontSize: 20),),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.camera, size: 30,),
                label: const Text('갤러리', style: TextStyle(fontSize: 20),),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future takePhoto(ImageSource source) async {
    image = await _picker.pickImage(source: source);
    setState(() {
      mPhoto = File(image!.path);
    });
  }
}