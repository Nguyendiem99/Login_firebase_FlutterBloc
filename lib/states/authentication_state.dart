import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable{
  const AuthenticationState();
  @override
  // TODO: implement props
  List<Object?> get props => [];//xac dinh hai trang thai khac nhau thi can cu vao cai gi.
}
class AuthenticationInitial extends AuthenticationState{}
class AuthenticationSuccess extends AuthenticationState{
  late final User? userCredential;
  AuthenticationSuccess({required this.userCredential});
  @override
  // TODO: implement props
  List<Object?> get props => [userCredential];
}
class AuthenticationFailure extends AuthenticationState{}
