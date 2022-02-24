import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasegoogle/events/authentication_event.dart';
import 'package:firebasegoogle/repositories/user_repository.dart';
import 'package:firebasegoogle/states/authentication_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState> {
  final UserRepository? _userRepository;
  //constructor
  AuthenticationBloc({@required UserRepository? userRepository}):
        assert(userRepository != null),
        _userRepository = userRepository,
        super(AuthenticationInitial());//state ban dau la Initial state
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent authenticationEvent) async* {
    // TODO: implement mapEventToState
     if(authenticationEvent is AuthenticationStart){
       final isSignedIn = await _userRepository!.isSignedIn();
       //kiểm tra xem đăng nhập chưa.
       if(isSignedIn){
         final userCredential = await _userRepository!.getUser();
         yield AuthenticationSuccess(userCredential: userCredential);
       }else{
         yield AuthenticationFailure();
       }
     }else if(authenticationEvent is AuthenticationLogIn){
         yield AuthenticationSuccess(userCredential:await _userRepository!.getUser());
     }else if(authenticationEvent is AuthenticationLogOut){
       _userRepository!.signOut();
        yield AuthenticationFailure();
     }
  }
}