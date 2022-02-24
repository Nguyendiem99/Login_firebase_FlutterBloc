import 'package:firebasegoogle/blocs/register_bloc.dart';
import 'package:firebasegoogle/pages/components/rounded_button.dart';
import 'package:firebasegoogle/pages/register/components/register_page.dart';
import 'package:firebasegoogle/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserButton extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterUserButton({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45,
      child: RoundedButton(
        text: "Register a new Account",
        press: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return BlocProvider<RegisterBloc>(
                  create: (context) => RegisterBloc(userRepository: _userRepository),
                  child: RegisterPage(userRepository: _userRepository)
              );
            }),
          );
        },
      )
    );
  }
}