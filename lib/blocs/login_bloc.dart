import 'package:firebasegoogle/events/login_event.dart';
import 'package:firebasegoogle/repositories/user_repository.dart';
import 'package:firebasegoogle/states/login_state.dart';
import 'package:firebasegoogle/validator/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
class LoginBloc extends Bloc<LoginEvent ,LoginState>{
  UserRepository? _userRepository;
  LoginBloc({@required UserRepository? userRepository}):
      assert(userRepository != null),
      _userRepository = userRepository,
  super(LoginState.initial());
  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(Stream<LoginEvent> loginEvents, TransitionFunction<LoginEvent, LoginState> transitionFunction) {
    // TODO: implement transformEvents
   final  debonce = loginEvents.where((loginEvent) {
     return (loginEvent is LoginEventEmailChanged || (loginEvent is LoginEventPasswordChanged));
   }).debounceTime(Duration(milliseconds: 300));
   final  nondebonce = loginEvents.where((loginEvent) {
     return (loginEvent is! LoginEventEmailChanged || (loginEvent is! LoginEventPasswordChanged));
   });
   return super.transformEvents(nondebonce.mergeWith([debonce]),transitionFunction);
  }
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEventEmailChanged) {
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginEventPasswordChanged) {
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if (event is LoginEventEmailAndPasswordPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }else if(event is LoginwithGooglePressed){
      try {
        await _userRepository!.signInWithGoogle();
        yield LoginState.Success();
      }catch(exception) {
        yield LoginState.Failure();
      }
    }
  }
  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    yield state.cloneAndUpdate(isValidEmail: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.cloneAndUpdate(isValidPassword: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {String? email, String? password}) async* {
    yield LoginState.Loading();
    try {
      await _userRepository!.signIn(email!, password!);
      yield LoginState.Success();
    } catch (_) {
      yield LoginState.Failure();
    }
  }
}
