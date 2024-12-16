import 'package:dongne_chat/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dongne_talk"
        ),
      ),
      body: Center(
        child: Container(
          height: 350,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff466995),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: 40,
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "아이디를 입력하세요",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                height: 40,
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력하세요',
                  ),
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.white,
                  height: 40,
                  width: 200,
                  child: Center(
                    child: Text(
                      "LogIn",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70),
              Text("회원가입"),
            ],
          ),
        ),
      ),
    );
  }
}
