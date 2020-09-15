import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_apps/SimpleBlocDelegate.dart';
import 'package:magang_apps/repository/repository.dart';
import 'package:magang_apps/screen/SplashScreenMainView.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: unnecessary_statements
  EquatableConfig.stringify;
  Bloc.observer=SimpleBlocObserver();

  runApp(MyApp(userRepository: UserRepository(),));
}

class MyApp extends StatelessWidget {
  UserRepository userRepository;
  MyApp({this.userRepository});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: SplashScreenMainView(),
    );
  }
}
