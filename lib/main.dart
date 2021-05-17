import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/Error/ErrorHandler.dart';

import 'HomePage/HomePage.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
      //brightness: Brightness.dark
    ),
    home: SplashScreen(),
  ));
}


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    _caricamento(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            tween: Tween(begin: 0.4, end: 1),
            curve: Curves.bounceOut,
            duration: Duration(milliseconds: 800),
            child: Image.asset('Assets/Images/splashScreen.png'),
            builder: (context, num progress, child) => Transform.scale(
              scale: progress.toDouble(),
              child: child,
            )
          ),

          Text('Everything you wanted to know', textAlign: TextAlign.center,),
        ],
      ),
    );
  }

  Future<void> _caricamento(BuildContext context) async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none) {
      await Errors.connectionError(context).then((_) async => await _caricamento(context));
    }

    await Future.delayed(Duration(milliseconds: 900)).then((value) 
      => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())));
  }
}

