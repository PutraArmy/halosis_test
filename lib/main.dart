import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// import 'package:halosistest/blocs/users_bloc/user_bloc.dart';
import 'package:halosistest/screens/home_page.dart';
import 'package:halosistest/screens/login_page.dart';
import 'package:halosistest/splash_screen.dart';
import 'package:halosistest/theme/colors/light_colors.dart';

import 'blocs/user_bloc/bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.mainColor, // navigation bar color
    statusBarColor: LightColors.mainColor, // status bar color
  ));

  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (BuildContext context) => UserBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: LightColors.mainColor,
              displayColor: LightColors.mainColor,
              fontFamily: 'Poppins'),
        ),
        initialRoute: '/splashScreen',
        getPages: [
          GetPage(name: '/', page: () => LoginPage()),
          GetPage(name: '/splashScreen', page: () => SplashScreen()),
          GetPage(name: '/homePage', page: () => HomePage()),
        ],
      ),
    );
  }
}
