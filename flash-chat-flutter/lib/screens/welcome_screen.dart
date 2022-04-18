import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/widgets/roundend_button.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  // Animation animation;
  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //     vsync: this, duration: Duration(seconds: 1));

    // animation = CurvedAnimation(parent: _controller,curve: Curves.easeIn);
    // _controller.forward(from: 1.0);

    // animation.addStatusListener((status){
    //   if(status == AnimationStatus.completed){
    //       _controller.reverse(from: 1.0);
    //   }else if(status == AnimationStatus.dismissed){
    //     _controller.forward();
    //   }
    // });
    // _controller.addListener(() {
    //   setState(() {});
    //   print(animation.value);
    // });
  }

  @override
  void didUpdateWidget(WelcomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  onTap: () {},
                  isRepeatingAnimation: false,
                  text: ["Flash Chat"],
                  textStyle:
                      TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundendButton(color: Colors.lightBlueAccent, text: 'Log in', onPressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },),
            RoundendButton(color: Colors.blueAccent, text: 'Register', onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },),
          ],
        ),
      ),
    );
  }
}

