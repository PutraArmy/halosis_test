import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:halosistest/blocs/user_bloc/bloc.dart';
import 'package:halosistest/models/login_model.dart';
import 'package:halosistest/theme/colors/light_colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // User user = User();
  UserBloc _userBloc = UserBloc();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  bool _hideText = true;
  bool loginSts = false;
  bool _isLoading = false;

  String txtLogin = "Login";
  String body = "";

  @override
  void initState() {
    super.initState();
  }

  // login(String email, password) {
  //   print(email);
  //   print(password);
  //   // User.Login_user(email, password);
  // }

  // Future<void> setPreferences(Login login) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if (login.code == 200) {
  //     sharedPreferences.setInt("id_user", login.data!.user.idUser);
  //     sharedPreferences.setString("token_auth", login.data!.token);
  //     // Get.offAndToNamed("/homePage");
  //   }
  // }

  showHide() {
    setState(() {
      _hideText = !_hideText;
    });
  }

  void _buildArrayFromat(String email, password) {
    int index = 0;

    LoginModel(email: email, password: password);

    body = loginModelToJson(LoginModel(email: email, password: password));
    log(body);

    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(LoginEvent(body: body));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heightAll = MediaQuery.of(context).size.height;
    double height = heightAll / 4 + 50;

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is LoginError) {}
              if (state is LoginWaiting) {
                print("Loading data");
              }
              if (state is LoginSuccess) {
                if (state.login == null) {
                  // _lastDataFlashsaleBanner = true;
                  print("Tidak ada data");
                  setState(() {
                    _isLoading = false;
                  });
                } else {
                  print("Success Login");
                  if (!state.login.status) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Login Unsuccessful',
                      btnOkColor: LightColors.red,
                      desc: state.login.message,
                      // btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Login Successful',
                      // autoHide: Duration(seconds: 2),
                      btnOkColor: LightColors.mainColor,
                      // desc: state.login.message,
                      // btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        Get.offAndToNamed("/homePage");
                      },
                    )..show();
                  }

                  setState(() {
                    _isLoading = false;
                  });
                }
              }
            },
          ),
        ],
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Stack(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset(
                  //       'assets/images/logo.png',
                  //       width: 200,
                  //     ),
                  //   ],
                  // ),
                  // Image.asset(
                  //   'assets/images/logo.png',
                  //   width: 150,
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logo.png',
                            width: 200,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 16,
                                color: LightColors.mainColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: passwordController,
                                    autofocus: false,
                                    obscureText: _hideText,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_hideText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: width - 60,
                            height: 50,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _buildArrayFromat(emailController.text,
                                        passwordController.text);
                                    _isLoading = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: LightColors.mainColor,
                                    border: Border.all(
                                      width: 2,
                                      color: LightColors.mainColor,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(
                                            2, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  height: 40,
                                  child: Center(
                                    child: !_isLoading
                                        ? Text("Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700))
                                        : SpinKitCircle(
                                            color: LightColors.white,
                                            size: 25.0,
                                          ),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(25.0)),
                          ),

                          SizedBox(
                            height: 70,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.toNamed('/forgetPasswordPage');
                          //   },
                          //   child: Text(
                          //     "Forgot Password?",
                          //     style: TextStyle(
                          //       color: LightColors.mainColor,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text("© Halosis - Test")),
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
