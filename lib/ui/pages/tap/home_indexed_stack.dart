import 'package:dongne_chat/ui/pages/dongne_list/dongne_list_page.dart';
import 'package:dongne_chat/ui/pages/homepage/home_page.dart';
import 'package:dongne_chat/ui/pages/mypage/mypage.dart';
import 'package:dongne_chat/ui/pages/tap/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeIndexedStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModel);
        return IndexedStack(
          index: currentIndex,
          children: [
            HomePage(),
            DongneListPage(),
            MyPage(),
          ],
        );
      },
    );
  }
}