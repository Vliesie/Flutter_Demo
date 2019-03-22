import 'package:flutter/material.dart';
import 'Auth.dart';
import 'Crud.dart';




class HomePage extends StatelessWidget {




  final Widget placeholder = new Container(color: Colors.grey);




  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      backgroundColor: Colors.cyan,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        title: new Text('Home'),
        actions: <Widget>[ //asign to the right
          new FlatButton(
            child: new Text('Logout',
                style: new TextStyle(fontSize: 17.0, color: Colors.cyan)),
            onPressed: _signOut,
          ),
          new FlatButton(onPressed: () =>
              Navigator.push(
                  context, MaterialPageRoute(builder:
                  (BuildContext context) => CrudPage())),
              child: new Text('Crud',
                style: new TextStyle(fontSize: 17.0, color: Colors.cyan),
              )
          )
        ],

      ),

      body: Container(
    padding: EdgeInsets.all(20.0),
    alignment: Alignment.center,
   child: Column(children: <Widget>[(//If i ovalClip And set the alignment Position it dissapears completely
      Hero(
        tag: 'imageid',
        child: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AnimationPage())),
          child: Image.network(
           'https://media.giphy.com/media/BHNfhgU63qrks/giphy.gif', width: 400.0, height: 400.0,

          ),
        ),
      )
    ),
        Hero(
        tag: "hero2",
        child: Material(
          color: Colors.transparent,
          child: Text(
            "Tap the Picture",
            style: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )),
    ]
      )
      )
    );
  }

}


class AnimationPage extends StatefulWidget {

  AnimationState createState() => AnimationState();
}

class AnimationState extends State<AnimationPage> {

  var _isFirstCrossFadeEnabled = false;
  var _link = 'https://media.giphy.com/media/24C2paIV0IBEY/giphy.gif';

  animateCrossFade() {
    setState(() {
      if(_isFirstCrossFadeEnabled == true){
         _link = 'https://media.giphy.com/media/BHNfhgU63qrks/giphy.gif';
      }else
        {
          _link = 'https://media.giphy.com/media/DvyxIpxw9cCuQ/giphy.gif';
        }
      _isFirstCrossFadeEnabled = !_isFirstCrossFadeEnabled;

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.cyan ,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        title: new Text('Animations'),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        centerTitle: true,


      ),

      body: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: "Hero1",child: ClipOval(
              child: Image.network(_link, height: 200, width: 200,

              ),
            ),

            ),

            AnimatedCrossFade(
              duration: Duration(milliseconds: 3000),
              firstChild: Container(
                child: Image.network("https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png"),
                height: 300.0,
                width: double.infinity,
              ),
              secondChild: Container(
                child: Image.network("https://cdn-images-1.medium.com/max/2438/1*TFZQzyVAHLVXI_wNreokGA.png"),
                height: 300.0,
                width: double.infinity,
              ),
              crossFadeState: _isFirstCrossFadeEnabled
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            OutlineButton(

                child: Text("Tap me"),

                color: Colors.black,
                onPressed: () {
                  animateCrossFade();
                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),


          ],
        ),
      ),
    );
  }
}

