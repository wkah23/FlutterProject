import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class DriveScreen extends StatefulWidget {
  const DriveScreen({super.key});

  @override
  State<DriveScreen> createState() => _DriveScreenState();
}

class _DriveScreenState extends State<DriveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('드라이브'),
      ),
      // body: NaverMap(
        
      //   initLocationTrackingMode: LocationTrackingMode.Follow,
      //   onMapCreated: (controller) {
      //     // 지도가 생성되었을 때 실행될 코드
      //     // controller를 사용하여 지도에 대한 조작을 수행할 수 있습니다.
      //   },
      // ),
    );
  }
}