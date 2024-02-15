// ignore_for_file: depend_on_referenced_packages, unused_local_variable, empty_constructor_bodies, must_be_immutable, unnecessary_null_comparison, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observe.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/styles/theme.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';

Future main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  DioHelper.init();
  uId = CacheHelper.getData(key: 'uid');
  Widget widget;
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({
    super.key,
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        //..getPosts()
        ..getUserData(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: LightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
