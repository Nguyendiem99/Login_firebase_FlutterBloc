import 'package:meta/meta.dart';
@immutable
class RegisterState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isValidSubmit;
  final bool isSuccess;
  final bool isFailure;
  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;
  RegisterState({
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isValidSubmit,
    required this.isSuccess,
    required this.isFailure
  });
  factory RegisterState.initial() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidSubmit: false,
        isSuccess: false,
        isFailure: false
    );
  }
  factory RegisterState.loading() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidSubmit: true,
        isSuccess: false,
        isFailure: false
    );
  }
  factory RegisterState.success() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidSubmit: false,
        isSuccess: true,
        isFailure: false
    );
  }
  factory RegisterState.failure() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidSubmit: false,
        isSuccess: false,
        isFailure: true
    );
  }
  RegisterState cloneWith({
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isValidSubmit,
    bool? isSuccess,
    bool? isFailure
  }){
    return RegisterState(
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isValidPassword: isValidPassword ?? this.isValidPassword,
        isValidSubmit: isValidSubmit ?? this.isValidSubmit,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
  RegisterState cloneAndUpdate({
    bool? isValidEmail,
    bool? isValidPassword,
  }){
    return cloneWith(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isValidSubmit: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  @override
  String toString() {
    return '''RegisterState {
      isValidEmail: $isValidEmail,
      isValidPassword: $isValidPassword,      
      isSubmitting: $isValidSubmit,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
