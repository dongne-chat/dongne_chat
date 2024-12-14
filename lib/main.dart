import 'package:dongne_chat/theme.dart';
import 'package:dongne_chat/ui/pages/dongne_list/dongne_list_page.dart';
import 'package:dongne_chat/ui/pages/home/home_page.dart';
import 'package:dongne_chat/ui/pages/login/login_page.dart';
import 'package:dongne_chat/ui/pages/signup/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  // .env로드 및 firebase 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: DongneListPage(),
    );
  }
}
