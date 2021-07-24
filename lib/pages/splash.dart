import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_splash/flutter_splash.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroSplash();
  }
}


class IntroSplash extends StatefulWidget{
  @override
  _IntroSplashState createState() => _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    //Duração
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    //Mapeamento do início e fim
    animation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);

    //Iniciar animação
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Stack(
      children: <Widget>[
        Splash(
          seconds: 5,
          backgroundColor: Colors.black,
          /*gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.green[300]]),*/
          navigateAfterSeconds: Login(),
          loaderColor: Colors.deepOrange,
        ),
        Center(
          child: GrowTransition(
            animation: animation,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo-bd.png"),
                  //fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  final size = Tween<double>(begin: 30, end: 300);
  final opacity = Tween<double>(begin: 0.1, end: 0.9);

  GrowTransition({Key key, this.animation, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
            opacity: opacity.evaluate(animation).clamp(0.0, 1.0),
            child: Container(
              width: size.evaluate(animation),
              height: size.evaluate(animation),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}