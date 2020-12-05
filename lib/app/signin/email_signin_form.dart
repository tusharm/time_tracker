import 'package:flutter/material.dart';
import 'package:time_tracker/app/signin/form_signin_button.dart';
import 'package:time_tracker/app/services/auth.dart';

enum EmailSignInFormType { signin, register }

class EmailSignInForm extends StatefulWidget {
  const EmailSignInForm({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  EmailSignInFormType _formType = EmailSignInFormType.signin;

  String get email => _emailController.text;

  String get password => _passwordController.text;

  List<Widget> _widgets() {
    var primaryText = _formType == EmailSignInFormType.signin
        ? 'Sign in'
        : 'Create an account';
    var secondaryText = _formType == EmailSignInFormType.signin
        ? 'Need an account? Register'
        : 'Already have an account? Sign in';

    return <Widget>[
      TextField(
        controller: _emailController,
        decoration:
            InputDecoration(labelText: 'Email', hintText: 'test@test.com'),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        enabled: !_isLoading,
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        enabled: !_isLoading,
      ),
      SizedBox(height: 8.0),
      FormSignInButton(
        text: primaryText,
        onPressed: _isLoading ? null : _submit,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(secondaryText),
        onPressed: _isLoading ? null : _toggleFormType,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _widgets(),
        ));
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // TODO: simulating a n/w call, must be removed in future
      await Future.delayed(Duration(seconds: 2));

      if (_formType == EmailSignInFormType.signin)
        await widget.auth.signInWithEmailAndPassword(email, password);
      else
        await widget.auth.registerWithEmailAndPassword(email, password);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    Navigator.of(context).pop();
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signin
          ? EmailSignInFormType.register
          : EmailSignInFormType.signin;
    });

    _emailController.clear();
    _passwordController.clear();
  }
}
