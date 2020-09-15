import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_apps/bloc/bloc.dart';
import 'package:magang_apps/repository/repository.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  const LoginScreen({Key key, this.userRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: userRepository),
        child: Scaffold(
          body: LoginScreenMainView(
            userRepository: userRepository,
          ),
        ));
  }
}

class LoginScreenMainView extends StatefulWidget {
  const LoginScreenMainView({Key key, this.userRepository}) : super(key: key);
  final UserRepository userRepository;

  @override
  _LoginScreenMainViewState createState() =>
      _LoginScreenMainViewState(userRepository);
}

class _LoginScreenMainViewState extends State<LoginScreenMainView> {
  final UserRepository userRepository;
  LoginBloc loginBloc;
  final TextEditingController phoneNumberController = TextEditingController();
  String phoneNumber;

  _LoginScreenMainViewState(this.userRepository);
  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: userRepository),
        child: Scaffold(
            body: Container(
          child: Form(
              child: Column(
            children: <Widget>[
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              )
            ],
          )),
        )));
  }
}
