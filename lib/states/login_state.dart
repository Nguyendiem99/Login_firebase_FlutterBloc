import 'package:meta/meta.dart';
class LoginState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isValidSubmit;
  final bool isSuccess;
  final bool isFailure;
  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;
  LoginState({
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isValidSubmit,
    required this.isSuccess,
    required this.isFailure
});
  factory LoginState.initial() {
   return LoginState(
       isValidEmail: true,
       isValidPassword: true,
       isValidSubmit: false,
       isSuccess: false,
       isFailure: false
   );
  }
  factory LoginState.Loading() {
    return LoginState(
        isValidEmail: true,
        isValidPassword: true,
        isValidSubmit: true,
        isSuccess: false,
        isFailure: false
    );
  }
  factory LoginState.Success() {
    return LoginState(
        isValidEmail: true,
        isValidPassword: true,
        isValidSubmit: false,
        isSuccess: true,
        isFailure: false
    );
  }
  factory LoginState.Failure() {
    return LoginState(
        isValidEmail: true,
        isValidPassword: true,
        isValidSubmit: false,
        isSuccess: false,
        isFailure: true
    );
  }
  LoginState cloneWith({
     bool? isValidEmail,
     bool? isValidPassword,
     bool? isValidSubmit,
     bool? isSuccess,
     bool? isFailure
  }){
    return LoginState(
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isValidPassword: isValidPassword ?? this.isValidPassword,
        isValidSubmit: isValidSubmit ?? this.isValidSubmit,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
  LoginState cloneAndUpdate({
    bool? isValidEmail,
    bool? isValidPassword,
  }){
    return cloneWith(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isValidSubmit: false,
      isSuccess: false,
      isFailure: false
    );
  }
}
