import 'package:firebasegoogle/blocs/authentication_bloc.dart';
import 'package:firebasegoogle/blocs/login_bloc.dart';
import 'package:firebasegoogle/events/authentication_event.dart';
import 'package:firebasegoogle/events/login_event.dart';
import 'package:firebasegoogle/pages/components/or_divider.dart';
import 'package:firebasegoogle/pages/components/register_user_button.dart';
import 'package:firebasegoogle/pages/components/rounded_button.dart';
import 'package:firebasegoogle/pages/components/rounded_input_field.dart';
import 'package:firebasegoogle/pages/components/rounded_password_field.dart';
import 'package:firebasegoogle/pages/components/social_icon.dart';
import 'package:firebasegoogle/pages/login/component/background.dart';
import 'package:firebasegoogle/repositories/user_repository.dart';
import 'package:firebasegoogle/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class LoginPage extends StatefulWidget {
  final UserRepository  _userRepository;
  //constructor
  LoginPage({Key? key,required UserRepository userRepository}):
        _userRepository = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwodController = TextEditingController();
  LoginBloc? _loginBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(() {
      //when email is changed,this function is called !
      _loginBloc!.add(LoginEventEmailChanged(email: _emailController.text));
    });
    _passwodController.addListener(() {
      //when password is changed,this function is called !
      _loginBloc!.add(LoginEventPasswordChanged(password: _passwodController.text));
    });
  }
  bool get isPopulated => _emailController.text.isNotEmpty && _passwodController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState loginState) =>
      loginState.isValidEmailAndPassword & isPopulated && !loginState.isValidSubmit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isFailure) {
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Login Failure'),
                        Icon(Icons.error),
                      ],
                    ),
                    backgroundColor: kPrimaryColor,
                  ),
                );
            }else if (state.isValidSubmit) {
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Logging In...'),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      ],
                    ),
                    backgroundColor: kPrimaryColor,
                  ),
                );
            }else if (state.isSuccess) {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLogIn(),
              );
            }
          },
          child: BlocBuilder<LoginBloc,LoginState>(
            builder: (context,state){
              return Background(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "LOGIN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SvgPicture.asset(
                        "assets/icons/young-man.svg",
                        height: size.height * 0.3,
                      ),
                      // SizedBox(height: size.height * 0.03),
                      RoundedInputField(
                        controller: _emailController,
                        validator: (_) {
                          return state.isValidEmail ? null : 'Invalid email format';
                        },
                      ),
                      RoundedPasswordField(
                          controller: _passwodController,
                          validator: (_){
                            return state.isValidEmail ? null : 'Invalid password format';
                          }
                      ),
                      RoundedButton(
                        text :"Login",
                        press:isLoginButtonEnabled(state)?
                        _onLoginEmailAndPassword : null ,
                      ),
                      RegisterUserButton(userRepository: _userRepository),
                      OrDivider(),
                      SocalIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press:(){
                            BlocProvider.of<LoginBloc>(context).add(LoginwithGooglePressed());
                            //now test in real device !
                          },
                      )
                      //Add "register" button here, to "navigate" to "Register Page"
                    ],
                  ),
                ),
              );
            },
          ),
      ),
    );
  }
  void _onLoginEmailAndPassword() {
    _loginBloc!.add(LoginEventEmailAndPasswordPressed(
        email: _emailController.text,
        password: _passwodController.text
    ));
  }
}