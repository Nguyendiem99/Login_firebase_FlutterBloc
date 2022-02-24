import 'package:equatable/equatable.dart';

class AuthenticationEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AuthenticationStart extends AuthenticationEvent{}
class AuthenticationLogIn extends AuthenticationEvent{}
class AuthenticationLogOut extends AuthenticationEvent{}