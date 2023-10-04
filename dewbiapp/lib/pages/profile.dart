import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  String userEmail = "";
  
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  String? downloadURL;
  File? mPhoto;
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  late SharedPreferences prefs;
  late CollectionReference members;
  TextEditingController nameCon = TextEditingController();
  TextEditingController carMadeCon = TextEditingController();
  TextEditingController carModelCon = TextEditingController();
  TextEditingController garageCon = TextEditingController();
  String nameField = '';
  String carMadeField = '';
  String carModelField = '';
  String garageField = '';
  bool isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!isProfileLoaded) {
      _fetchUserData(); // 프로필 정보를 처음 생성할 때만 불러오도록 수정
    }
  }
  Future<void> _fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = await _firestore.collection('members').doc(user.email).get();
      setState(() {
        nameField = userData.get('name');
        isProfileLoaded = true;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    userEmail = user!.email!;
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
            carTextField(),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () {
                _uploadProfileImage();
              }, 
              child: const Text('저장하기')
            ),
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

  Widget carTextField() {
    return Column(
      children: [
        TextField(
          controller: nameCon,
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
          onChanged: (value) {
            setState(() {
              nameField = value;
            });
          },
        ),
        const SizedBox(height: 25,),
        TextField(
          controller: carMadeCon,
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
              Icons.car_repair_outlined,
              color: Colors.grey,
            ),
            labelText: '차 제조사',
            hintText: '차량 제조사를 입력하세요 ex : 벤츠',
          ),
          onChanged: (value) {
            setState(() {
              carMadeField = value; // 값 업데이트
            });
          },
        ),
        const SizedBox(height: 25,),
        TextField(
          controller: carModelCon,
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
              Icons.car_repair_outlined,
              color: Colors.grey,
            ),
            labelText: '차량 모델',
            hintText: '차량 모델명을 입력하세요',
          ),
          onChanged: (value) {
            setState(() {
              carModelField = value; // 값 업데이트
            });
          },
        ),
        const SizedBox(height: 25,),
        TextField(
          controller: garageCon,
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
              Icons.garage,
              color: Colors.grey,
            ),
            labelText: '차고지',
            hintText: '차고지의 주소를 간략히 입력하세요',
          ),
          onTap: () async {
            final KopoModel model = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RemediKopo(),
              ),
            );
            setState(() {
              garageCon.text = model.address!;
              garageField = model.address!; // 값 업데이트
            });
          },
        ),
      ],
    );
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
    Navigator.pop(context);
  }
  Future<void> _uploadProfileImage() async {
    if (user != null && image != null) {
      File mPhoto = File(image!.path); // XFile을 File로 변환

      final storageReference = storage.ref().child('profile_images/$userEmail.jpg');
      await storageReference.putFile(mPhoto);
      final downloadURL = await storageReference.getDownloadURL();
      await _firestore.collection('members').doc(userEmail).set({
        'name': nameField,
        'profileImageURL': downloadURL,
        'carMade' : carMadeField,
        'carModel' : carModelField,
        'garage' : garageField,
      });
      _fetchUserData();
    }
  }
}