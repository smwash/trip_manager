import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trip_manager/constants.dart';
import 'package:trip_manager/helpers/loading.dart';
import 'package:trip_manager/helpers/validators.dart';
import 'package:trip_manager/services/authService.dart';

import 'authbutton.dart';
import 'textfields.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail;
  String _userName;
  String _userPassword;
  var _errorMessage = '';
  bool _obscureText = true;
  bool _isLogin = true;
  bool _isLoading = false;

  _handleSubmitForm() async {
    final _auth = AuthService();
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();

    try {
      setState(() => _isLoading = true);
      if (isValid) {
        _formKey.currentState.save();
        if (_isLogin) {
          await _auth.loginUser(
            email: _userEmail,
            password: _userPassword,
          );
        } else {
          await _auth.signUpUser(
            email: _userEmail,
            password: _userPassword,
            username: _userName,
          );
        }
      }
      if (!isValid) {
        setState(() => _isLoading = false);
        return null;
      }
      setState(() {
        _isLoading = false;
        _errorMessage = _auth.errorMessage;
      });
      final snackbar = SnackBar(
        content: Text(
          _errorMessage,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red[100],
      );
      Scaffold.of(context).showSnackBar(snackbar);
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: kBlackColor,
          width: 2,
        ),
      ),
      child: _isLoading
          ? Loader()
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      _isLogin ? 'LogIn' : 'SignUp',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    if (!_isLogin)
                      CustomTextField(
                        icon: MdiIcons.account,
                        hintText: 'Username',
                        validator: (value) =>
                            Validator().usernameValidator(value),
                        onsaved: (value) => _userName = value,
                      ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    CustomTextField(
                      icon: MdiIcons.emailEdit,
                      hintText: 'Email',
                      validator: (value) => Validator().emailValidator(value),
                      onsaved: (value) => _userEmail = value,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    CustomTextField(
                      obscureText: _obscureText,
                      hintText: 'Password',
                      icon: MdiIcons.formTextboxPassword,
                      iconButton: IconButton(
                        icon: _obscureText
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () => setState(
                          () => _obscureText = !_obscureText,
                        ),
                      ),
                      validator: (value) =>
                          Validator().passwordValidator(value),
                      onsaved: (value) => _userPassword = value,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _isLogin
                              ? 'Create Account?'
                              : 'Already have an account?',
                        ),
                        SizedBox(
                          width: size.width * 0.015,
                        ),
                        GestureDetector(
                          child: Text(
                            _isLogin ? 'SignUp' : 'LogIn',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onTap: () => setState(
                            () => _isLogin = !_isLogin,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    CustomButton(
                      label: _isLogin ? 'LogIn' : 'SignUp',
                      onPressed: _handleSubmitForm,
                    ),
                    SizedBox(
                      height: size.width * 0.02,
                    ),
                    Text('Or signIn with'),
                    SizedBox(
                      height: size.width * 0.015,
                    ),
                    CircularButton(
                      size: size,
                      onTap: () {
                        AuthService().googleSignIn();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key key,
    @required this.size,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(
          size.height * 0.007,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: kBlackColor,
            width: 2,
          ),
        ),
        child: Icon(
          MdiIcons.google,
          color: kAccentColor,
          size: size.height * 0.04,
        ),
      ),
      onTap: onTap,
    );
  }
}
