import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoginEventEmailChanged extends LoginEvent{
  final String email;
  const LoginEventEmailChanged({required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [email];
  @override
  String toString() => 'email Changed $email ';
}
class LoginEventPasswordChanged extends LoginEvent{
  final String password;
  const LoginEventPasswordChanged({required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [password];
  @override
  String toString() => 'password Changed: $password';
}
class LoginEventEmailAndPasswordPressed extends LoginEvent{
  final String email;
  final String password;
  const LoginEventEmailAndPasswordPressed({required this.email,required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
  @override
  String toString() => 'email: $email,password :$password ';
}
class LoginwithGooglePressed extends LoginEvent{}
