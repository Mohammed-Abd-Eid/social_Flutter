// ignore_for_file: curly_braces_in_flow_control_structures, null_check_always_fails, avoid_print, prefer_const_constructors

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/layout/social_app/cubit/cubit.dart';
import 'package:socialm/layout/social_app/social_layout.dart';
import 'package:socialm/modules/social_app/social_login/login_social.dart';
import 'package:socialm/shared/bloc_observer.dart';
import 'package:socialm/shared/components/constants.dart';
import 'package:socialm/shared/cubit/cubit.dart';
import 'package:socialm/shared/cubit/state.dart';
import 'package:socialm/shared/local/cache_helper.dart';
import 'package:socialm/shared/remot/dio_helper.dart';
import 'package:socialm/shared/styles/them.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseAppCheck.instance.activate();
  await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  FirebaseAppCheck.instance.onTokenChange.listen((token) {
    print(token);
  });

  DioHelper.init();

  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData(key: "isDark");
  //bool? onBoarding = CacheHelper.getData(key: "onBoarding");

  uId = CacheHelper.getData(key: 'uId');

  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = ShopLogin();
  // } else {
  //   widget = OnBorderScreen();
  // }
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLogin();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        isDark,
        widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // constructor
  // build
  bool? isDark;
  Widget startWidget;

  MyApp(this.isDark, this.startWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPost()),
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            // darkTheme: darkTheme,
            themeMode: AppCubit.get(context)!.isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: startWidget,
            ),
          );
        },
      ),
    );
  }
}
