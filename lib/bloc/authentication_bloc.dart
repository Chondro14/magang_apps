import 'dart:async';
import 'package:magang_apps/bloc/authentication_event.dart';

import 'bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_apps/repository/repository.dart';
import '';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  final UserRepository userRepository;

  AuthenticationBloc({this.userRepository,}) : super(null);
  AuthenticationState get initialState => InitialAuthenticationState();


  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event)async*{
    if(event is AppStarted){
      final bool hasToken= await userRepository.getUser()!=null;
      if(hasToken){
        yield Authenticated();
      }
      else{
        yield UnAuthenticated();
      }
    }
    if(event is LoggedIn){
      yield Loading();
      yield Authenticated();
    }
    if(event is LoggedOut){
      yield Loading();
      yield UnAuthenticated();
    }

  }

}