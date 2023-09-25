import 'package:dewbiapp/pages/Drive.dart';
import 'package:dewbiapp/pages/Home.dart';
import 'package:dewbiapp/pages/MyMusic.dart';
import 'package:dewbiapp/pages/profile.dart';
import 'package:dewbiapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      label: '홈',
      icon: Icon(Icons.home_filled),
    ),
    const BottomNavigationBarItem(
      label: '드라이브',
      icon: Icon(Icons.car_repair),
    ),
    const BottomNavigationBarItem(
      label: '마이뮤직',
      icon: Icon(Icons.music_note_rounded),
    ),
    const BottomNavigationBarItem(
      label: '프로필',
      icon: Icon(Icons.person_pin),
    ),
  ];

  List pages = [
    const HomeScreen(),
    const DriveScreen(),
    const MyMusicScreen(),
    const ProfileScreen(),
  ];

  User? user = FirebaseAuth.instance.currentUser;
  String userEmail = "";

  @override
  Widget build(BuildContext context) {
    userEmail = user!.email!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("메인페이지"),
        actions: [
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: bottomItems,
      ),
      body: pages[_selectedIndex],
    );
  }

  // _appBar() {
  //   final appBarHeight = AppBar().preferredSize.height;
  //   return PreferredSize(
  //     preferredSize: Size.fromHeight(appBarHeight),
  //     child: AppBar(
  //       title: const Text("Profile"),
  //       actions: [
  //         IconButton(
  //             onPressed: () {
  //               logout(context);
  //             },
  //             icon: const Icon(Icons.logout)),
  //       ],
  //     ),
  //   );
  // }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
