import 'package:dewbiapp/Screens/login_screen.dart';
import 'package:dewbiapp/Screens/page_b1.dart';
import 'package:dewbiapp/Screens/page_c1.dart';
import 'package:dewbiapp/widget/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }
  User? user = FirebaseAuth.instance.currentUser;
  String userEmail = "";
  @override
  Widget build(BuildContext context) {
    // userEmail = user!.email!;
    // return Scaffold(
    //   appBar: _appBar(),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Text(
    //             "Welcome Back",
    //             style: TextStyle(fontSize: 20, 
    //                              fontWeight: FontWeight.bold),
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           Text(
    //             "[ $userEmail ]",
    //             style: const TextStyle(fontSize: 20, 
    //                                    fontWeight: FontWeight.bold),
    //           ),
    //         const Text('Page A-1', style: TextStyle(fontSize: 30)),
    //         const SizedBox(height: 30,),
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.push(
    //               context, 
    //               // MaterialPageRoute(builder: (context) => const PageA2()),
    //               PageRouteBuilder(
    //                 pageBuilder: (context, anim1, anim2) => const PageA2(),
    //                 transitionDuration: const Duration(seconds: 0),
    //               ),
    //             );
    //           },
    //           child: const Text('2페이지 추가',
    //               style: TextStyle(fontSize: 24)),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return MaterialApp(
      title: '꾸기',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        hintColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              LikeScreen(),
              MoreScreen(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
  
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const PageB1(),
      const PageC1(),
    ];
  }
  // 탭메뉴의 버튼생성 및 설정
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.blue,
        activeColorSecondary: Colors.yellow,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ('Search'),
        activeColorPrimary: Colors.blue,
        activeColorSecondary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: ('Add'),
        activeColorPrimary: Colors.blue,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
  _appBar() {
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page A-1'),
        actions: [
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}