import 'package:flutter/material.dart';
import 'dart:io';

import './user_pick_image.dart';

class BuildForm extends StatefulWidget {
  final void Function(String emailId, String userName, String password,
      File pickedImage, bool isLogin, BuildContext ctx) submitFn;
  final isLoading;
  BuildForm(this.submitFn, this.isLoading);

  @override
  _BuildFormState createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  final _form = GlobalKey<FormState>();
  bool _isLogin = false;
  Map<String, String> _authData = {
    'emailId': '',
    'userName': '',
    'password': '',
  };
  File pickedImage;
  void _submitData() {
    FocusScope.of(context)
        .unfocus(); // After clicking on Login button the focus form any text field get removed
    // and any keyboard that is opened will be closed
    final isValidate = _form.currentState.validate();
    if (!isValidate) return;
    if (!_isLogin && pickedImage == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick a image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    _form.currentState.save();
    // setState(() {
    //   print(_authData['emailId']);
    //   print(_authData['userName']);
    //   print(_authData['password']);
    // });
    widget.submitFn(_authData['emailId'], _authData['userName'],
        _authData['password'], pickedImage, _isLogin, context);
  }

  void pickedImageFn(File image) {
    pickedImage = image;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (!_isLogin) UserPickImage(pickedImageFn),
            TextFormField(
              key: ValueKey('emailId'),
              decoration: InputDecoration(labelText: 'Email Id'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty || value.contains('@') == false)
                  return "Invalid E-mail Id";
              },
              onSaved: (value) {
                _authData['emailId'] = value;
              },
            ),
            if (!_isLogin)
              TextFormField(
                key: ValueKey('userName'),
                decoration: InputDecoration(labelText: 'User name'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value.contains('@') || value.contains('#'))
                    return "Invalid User Name";
                  else if (value.isEmpty || value.length < 6)
                    return "user name is to short";
                },
                onSaved: (value) {
                  _authData['userName'] = value;
                },
                // obscureText: true,
              ),
            TextFormField(
              key: ValueKey('password'),
              decoration: InputDecoration(labelText: 'Password'),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty || value.length < 8)
                  return "Password is too short";
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            if (widget.isLoading) CircularProgressIndicator(),
            if (!widget.isLoading)
              RaisedButton(
                onPressed: _submitData,
                child: Text(_isLogin ? 'Login' : 'Sign Up'),
              ),
            if (!widget.isLoading)
              FlatButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? 'Create new account' : 'I already have an account',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
