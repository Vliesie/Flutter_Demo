import 'package:flutter/material.dart';
import 'package:test2/Login_Page.dart';
import 'Auth.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
RootPage({this.auth});
final BaseAuth auth;

  @override

  State<StatefulWidget> createState() => new _RootPageState();

}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage>{

  AuthStatus _authStatus = AuthStatus.notSignedIn;


  initState() { //Called everytime a Statefull widget is created

    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(auth: widget.auth, onSignedIn: _signedIn);
      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );

    }

  }
}