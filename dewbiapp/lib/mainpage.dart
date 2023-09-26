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

class _MainPageState extends State<MainPage> {
  final _auth = FirebaseAuth.instance;
  
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
        ),
        drawerEnableOpenDragGesture: false,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.message),
                title: Text('Message'),
              ),
              const ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Drawer Close'),
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
