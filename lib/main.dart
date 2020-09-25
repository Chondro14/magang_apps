import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_apps/SimpleBlocDelegate.dart';
import 'package:magang_apps/bloc/authentication_bloc.dart';
import 'package:magang_apps/repository/AuthenticationRepository.dart';
import 'package:magang_apps/screen/BottomNavigationMainView.dart';
import 'package:magang_apps/screen/LoginScreenMainView.dart';
import 'package:magang_apps/screen/SplashScreenMainView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: unnecessary_statements
  EquatableConfig.stringify;
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    userRepository: AuthenticationRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository userRepository;

  MyApp({Key key, this.userRepository})
      :assert(userRepository != null),
        super(key: key);
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext cont0ext) {
    return RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(userRepository: userRepository),
        child: FutureBuilder(
            future: Firebase.initializeApp(), builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                navigatorKey: _navigatorKey, builder: (context, child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  Future.delayed(Duration(seconds: 10));
                  switch (state.authenticationStatus) {
                    case AuthenticationStatus.authenticated:
                      _navigator.pushAndRemoveUntil<void>(
                        BottomnavigationMainView.route(), (route) => false,);
                      break;
                    case AuthenticationStatus.unauthenticated:
                      _navigator.pushAndRemoveUntil<void>(LoginScreenMainView
                          .route(), (route) => false);
                      break;
                    default:
                      break;
                  }
                }, child: child,);
            }, onGenerateRoute: (_) {
              return SplashScreenMainView.route();
            });
          }
          return CircularProgressIndicator();
        }),
      ),
    );
  }
}
