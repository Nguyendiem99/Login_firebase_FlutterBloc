import 'package:firebasegoogle/events/register_event.dart';
import 'package:firebasegoogle/repositories/user_repository.dart';
import 'package:firebasegoogle/states/register_state.dart';
import 'package:firebasegoogle/validator/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  final UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());
  //đặt đỗ trễ cho mỗi lần event được gọi
  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(Stream<RegisterEvent> registerEvents, TransitionFunction<RegisterEvent, RegisterState> transitionFunction) {
    // TODO: implement transformEvents
    final  debonce = registerEvents.where((registerEvent) {
      return (registerEvent is RegisterEventEmailChanged || (registerEvent is RegisterEventPasswordChanged));
    }).debounceTime(Duration(milliseconds: 300));
    final  nondebonce = registerEvents.where((registerEvent) {
      return (registerEvent is! RegisterEventEmailChanged || (registerEvent is! RegisterEventPasswordChanged));
    });
    return super.transformEvents(nondebonce.mergeWith([debonce]),transitionFunction);
  }
  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEventEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterEventPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterEmailAndPasswordPressed) {
      yield* _mapRegisterSubmittedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.cloneAndUpdate(isValidEmail: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(String password) async* {
    yield state.cloneAndUpdate(isValidPassword: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      {String? email, String? password}) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email!, password!);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
