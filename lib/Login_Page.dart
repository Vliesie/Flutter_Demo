import 'package:flutter/material.dart';
import 'Auth.dart';


class LoginPage extends StatefulWidget{ //Stateless = Constant
  LoginPage({this.auth, this.onSignedIn});//Passing in an Instance of the Abstract class

  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();

  }

}

enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();


  String _email;
  String _password;
  FormType _formType = FormType.login;
  String _title = 'Login';
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  bool validateAndSave(){
    final form = formKey.currentState;


    if (form.validate())
    {
      form.save();
      return true;

    }
    else{
      return false;
    }
  }
  void validateAndSubmit() async{
    if(validateAndSave()){
      try {
        if(_formType == FormType.login){
            String userId = await widget.auth.signInWithEmailandPassword(_email, _password);
            print('Signed in: $userId');//Debugging Purpose
        }
        else{
         String userId = await widget.auth.CreateUserWithEmailAndPassword(_email, _password);
          print('Registed user: $userId'); //Debugging Purpose
        }
        widget.onSignedIn();
      }
      catch(error){
        print('error: $error');
      }
    }

  }

  void moveToRegister(){
    _title = 'Register';
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    _title = 'Login';
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold

      (backgroundColor: Colors.cyan,
        appBar: new AppBar(
      title: new Text('$_title'),
      backgroundColor: Colors.transparent,
    ),
        body: new ListView(
          children: <Widget>[
          Container(
          height: 150.0,
          width: 110.0,
          decoration: BoxDecoration(

            image: DecorationImage(
                image: NetworkImage('https://cdn.dribbble.com/users/720114/screenshots/2060411/sports-analytics-gif-dribbble.gif'),
                fit: BoxFit.fitHeight),
            borderRadius: BorderRadius.only
              (
                bottomLeft: Radius.circular(500.0),
                bottomRight: Radius.circular(500.0)
            ),
          ),
        ),
new Padding(
        padding: EdgeInsets.all(16.0),
            child: new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs() + BuildButtons(),
                )
            )
        )
        ]
    )

    );

  }

  List<Widget> buildInputs(){
    return [ new TextFormField(
      decoration: new InputDecoration(labelText: 'Email'),
      validator: validateEmail,
      onSaved: (value) => _email = value,
    ),
    new TextFormField(
      decoration: new InputDecoration(labelText: 'Password'),
      obscureText: _obscureText,
      validator: (value) => value.isEmpty ? 'Password can\'t be Empty': null,
      onSaved: (value) => _password = value,
    )];

  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  List<Widget> BuildButtons(){

    if(_formType == FormType.login){

      return [
        new RaisedButton(child: new Text('Login', style: new TextStyle(fontSize: 20.0 )
        ),
          onPressed: validateAndSubmit,shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))
    ),
        new FlatButton(
          child: new Text('Need an acount?' , style: new TextStyle(fontSize: 13.0)),

          onPressed: moveToRegister,shape: new RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(30.0)),
        )

      ];
    }
    else{
      return [
        new RaisedButton(child: new Text('Create Account', style: new TextStyle(fontSize: 20.0)
        ),
          onPressed: validateAndSubmit, shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
        ),
        new FlatButton(
          child: new Text('Already have an Account?' , style: new TextStyle(fontSize: 13.0)),
          onPressed: moveToLogin, shape: new RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(30.0)),
        )

      ];
    }
  }
}
