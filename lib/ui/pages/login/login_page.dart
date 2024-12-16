import 'package:dongne_chat/ui/pages/login/login_view_model.dart';
import 'package:dongne_chat/ui/pages/signup/signup_page.dart';
import 'package:dongne_chat/ui/pages/tap/tap_page.dart';
import 'package:dongne_chat/ui/widgets/user_global_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff466995),
            title: Text(
              "Dongne_talk",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    height: 40,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: TextField(
                        controller: idController,
                        decoration: InputDecoration(
                          hintText: "아이디를 입력하세요",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    height: 40,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: TextField(
                        controller: pwController,
                        decoration: InputDecoration(
                          hintText: "비밀번호를 입력하세요",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: Consumer(builder: (context, ref, child) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xff8CA9CD)),
                          minimumSize:
                              WidgetStatePropertyAll(Size.fromHeight(50)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          // 벨리데이션 성공했을 때, 로그인 요청
                          if (formKey.currentState?.validate() ?? false) {
                            final viewModel = ref.read(loginViewModel);
                            final loginResult = await viewModel.login(
                              id: idController.text,
                              password: pwController.text,
                            );
                            if (loginResult) {
                              saveUserId(idController.text);
                              loadUserId();
                              // 로그인 성공 => HomePage로 이동.(모든페이지를 제거한뒤 가야함)
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return TapPage();
                                }),
                                (route) {
                                  return false;
                                },
                              );
                            } else {
                              // ignore: avoid_print
                              print(idController.text);
                              return;
                            }
                          }
                        },
                        child: Text(
                          "LogIn",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 70),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    child: Text(
                      "회원가입",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
