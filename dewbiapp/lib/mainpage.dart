import 'package:dewbiapp/pages/Drive.dart';
import 'package:dewbiapp/pages/Home.dart';
import 'package:dewbiapp/pages/MyMusic.dart';
import 'package:dewbiapp/pages/profile.dart';
import 'package:dewbiapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
  User? user = FirebaseAuth.instance.currentUser;
  String userEmail = "";

class _MainPageState extends State<MainPage> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  
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
      label: '내차 자랑',
      icon: Icon(Icons.favorite_rounded),
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


  @override
  Widget build(BuildContext context) {
    userEmail = user!.email!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
              child: Image.asset(
                'assets/images/car3.png',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          centerTitle: true,
          elevation: 5,
          backgroundColor: Colors.white,
        ),
        drawerEnableOpenDragGesture: false,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text(
                  '$userEmail 님',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.message),
                title: Text('활동기록'),
              ),
              const ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('프로필'),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('환경설정'),
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text('로그아웃'),
                onTap: (() {
                  logout(context);
                }),
              ),
            ],
          ),
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
      ),
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
    await _auth.signOut();
    await googleSignIn.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
