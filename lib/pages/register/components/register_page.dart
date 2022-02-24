import 'package:firebasegoogle/blocs/authentication_bloc.dart';
import 'package:firebasegoogle/blocs/register_bloc.dart';
import 'package:firebasegoogle/events/authentication_event.dart';
import 'package:firebasegoogle/events/register_event.dart';
import 'package:firebasegoogle/pages/components/register_button.dart';
import 'package:firebasegoogle/pages/components/rounded_input_field.dart';
import 'package:firebasegoogle/pages/components/rounded_password_field.dart';
import 'package:firebasegoogle/pages/register/components/background_register.dart';
import 'package:firebasegoogle/repositories/user_repository.dart';
import 'package:firebasegoogle/states/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
class RegisterPage extends StatefulWidget {
  final UserRepository  _userRepository;
  //constructor
  RegisterPage({Key? key,required UserRepository userRepository}):
        _userRepository = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwodController = TextEditingController();
  RegisterBloc? _registerBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(() {
      //when email is changed,this function is called !
      _registerBloc!.add(RegisterEventEmailChanged(email: _emailController.text));
    });
    _passwodController.addListener(() {
      //when password is changed,this function is called !
      _registerBloc!.add(RegisterEventPasswordChanged(password: _passwodController.text));
    });
  }
  bool get isPopulated => _emailController.text.isNotEmpty && _passwodController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState registerState) =>
      registerState.isValidEmailAndPassword & isPopulated && !registerState.isValidSubmit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 100),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Register Failure'),
                      Icon(Icons.error),
                    ],
                  ),
                  backgroundColor: Color(0xffffae88),
                ),
              );
          }else if (state.isValidSubmit) {
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 100),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Registering...'),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    ],
                  ),
                  backgroundColor: Color(0xffffae88),
                ),
              );
          }else if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationLogIn(),
            );
          }
        },
        child: BlocBuilder<RegisterBloc,RegisterState>(
          builder: (context,state){
            return Background(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "SIGNUP",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SvgPicture.asset(
                        "assets/icons/register_icon.svg",
                        height: size.height * 0.35,
                      ),
                      RoundedInputField(
                        controller: _emailController,
                        validator: (_) {
                          return !state.isValidEmail ? 'Invalid Email' : null;
                        },
                      ),
                      RoundedPasswordField(
                          controller: _passwodController,
                          validator: (_){
                            return !state.isValidPassword ? 'Invalid password' : null;
                          }
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(padding: EdgeInsets.only(top: 3),),
                      RegisterButton(
                          onPressed:  () {
                            if (isRegisterButtonEnabled(state)) {
                              _onFormSubmitted();
                            }
                          }
                      ),
                    ],
                  ),
                )
            );
          },
        ),
      ),
    );
  }
  void _onFormSubmitted() {
    _registerBloc!.add(RegisterEmailAndPasswordPressed(
        email: _emailController.text, password: _passwodController.text));
  }
}