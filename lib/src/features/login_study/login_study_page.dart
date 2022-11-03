import 'package:cattle_app/core/constants/color_const.dart';
import 'package:cattle_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum LoginState {
  init,
  loading,
  success,
  error,
}

class LoginSimkeuPage extends StatefulWidget {
  const LoginSimkeuPage({super.key});

  @override
  State<LoginSimkeuPage> createState() => _LoginSimkeuPageState();
}

class _LoginSimkeuPageState extends State<LoginSimkeuPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<LoginState> loginState = ValueNotifier(LoginState.init);

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<LoginState>(
          valueListenable: loginState,
          builder: (context, state, _) {
            if (state == LoginState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == LoginState.init) {
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Palette.gray4,
                          ),
                          children: [
                            TextSpan(
                              text: ' Simkeu',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Palette.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Silahkan masukkan akun anda dibawah',
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.gray4,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Palette.gray2,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 14,
                                color: Palette.gray4,
                              ),
                            ),
                            _UsernameField(
                              controller: usernameController,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Kata Sandi',
                              style: TextStyle(
                                fontSize: 14,
                                color: Palette.gray4,
                              ),
                            ),
                            _PasswordField(
                              controller: passwordController,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Palette.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              onPressed: () async {
                                final username = usernameController.text;
                                final password = passwordController.text;
                                if (username.isNotEmpty &&
                                    password.isNotEmpty) {
                                  loginState.value = LoginState.loading;
                                  await doLogin(username, password);
                                } else {
                                  const snackBar = SnackBar(
                                    content:
                                        Text('Masukkan Username dan Password'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  'Masuk',
                                  style: TextStyle(
                                      fontSize: 14, color: Palette.gray1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Palette.gray4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  'Kembali',
                                  style: TextStyle(
                                      fontSize: 14, color: Palette.gray1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center();
            }
          }),
    );
  }

  Future<void> doLogin(username, password) async {
    try {
      final uri = Uri.parse('http://simkeu.unhas.ac.id:8095/loginapi');
      final request = http.MultipartRequest('POST', uri)
        ..fields['username'] = username
        ..fields['password'] = password;
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        loginState.value = LoginState.success;
        Navigator.pushReplacementNamed(context, AppRoute.cattleWeight);
      } else {
        loginState.value = LoginState.error;
        throw Exception('Faild to send request');
      }
    } catch (e) {
      loginState.value = LoginState.error;
    }
  }
}

class _UsernameField extends StatelessWidget {
  final TextEditingController controller;
  const _UsernameField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {},
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: 14,
        color: Palette.gray4,
      ),
      cursorColor: Palette.primary,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.gray3, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.primary, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        // errorText: !state.isEmailValid
        //     ? 'Please ensure the email entered is valid'
        //     : null,
        // labelText: 'Email',
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const _PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  ValueNotifier<bool> isHide = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isHide,
        builder: (context, data, _) {
          return TextFormField(
            controller: widget.controller,
            style: TextStyle(
              fontSize: 14,
              color: Palette.gray4,
            ),
            cursorColor: Palette.primary,
            obscureText: data,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.gray3, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.primary, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  isHide.value = !data;
                },
                icon: const Icon(
                  Icons.visibility,
                  color: Palette.gray4,
                ),
              ),
            ),
          );
        });
  }
}
