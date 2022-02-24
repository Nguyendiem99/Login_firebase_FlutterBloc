import 'package:equatable/equatable.dart';
abstract class RegisterEvent extends Equatable{
  const RegisterEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class RegisterEventEmailChanged extends RegisterEvent{
  final String email;
  const RegisterEventEmailChanged({required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [email];
  @override
  String toString() => 'RegisterEmail : $email';
}
class RegisterEventPasswordChanged extends RegisterEvent{
  final String password;
  const RegisterEventPasswordChanged({required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [password];
  @override
  String toString() => 'RegisterEmail : $password';
}
class RegisterEmailAndPasswordPressed extends RegisterEvent{
  final String email;
  final String password;
  const RegisterEmailAndPasswordPressed({required this.email,required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
  @override
  String toString() => 'Register email:$email ,Register Password: $password';
}