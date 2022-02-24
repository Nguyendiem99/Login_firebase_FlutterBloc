import 'package:firebase_core/firebase_core.dart';
import 'package:firebasegoogle/blocs/authentication_bloc.dart';
import 'package:firebasegoogle/blocs/simple_bloc_observer.dart';
import 'package:firebasegoogle/events/authentication_event.dart';
import 'package:firebasegoogle/pages/login/component/login_page.dart';
import 'package:firebasegoogle/pages/tracker.dart';
import 'package:firebasegoogle/repositories/user_repository.dart';
import 'package:firebasegoogle/states/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebasegoogle/pages/splash_page.dart';
import 'blocs/login_bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBloc();
  Firebase.initializeApp().whenComplete(() {
    runApp(MyApp());
  });
}
class MyApp extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    //signout for testing firstly !

    return MaterialApp(
        title: 'Login with Firebase',
        home: BlocProvider(
          create: (context) => AuthenticationBloc(userRepository: _userRepository)
            ..add(AuthenticationStart()),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authenticationState) {
              if(authenticationState is AuthenticationSuccess) {
                return Tracker();
              } else if(authenticationState is AuthenticationFailure) {
                return BlocProvider<LoginBloc>(
                    create: (context) => LoginBloc(userRepository: _userRepository),
                    child: LoginPage(userRepository: _userRepository,)//LoginPage,
                );
              }
              return SplashPage();
            },
          ),
        )
    );
  }
}