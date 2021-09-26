import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/API/RickMorty_API.dart';
import 'package:rick_morty/Error/ErrorHandler.dart';
import 'package:rick_morty/RXDart/Constants.dart';
import 'Pages/HomePage.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
      //brightness: Brightness.dark
    ),
    builder: (context, child) {
      return ScrollConfiguration(
        behavior: _RemoveListShadow(),
        child: child!,
      );
    },
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

          Expanded(child: Container()),

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

          Expanded(child: Container()),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('By Marchacio', style: TextStyle(color: Colors.grey)),
          )
        ],
      ),
    );
  }

  Future<void> _caricamento(BuildContext context) async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none) {
      await Errors.connectionError(context);
      return;
    } else {

      await Future.delayed(Duration(milliseconds: 900)).then((value) async {
        screenData.updateHeight(MediaQuery.of(context).size.height);
        screenData.updateHeight(MediaQuery.of(context).size.width);

        //Load all files in the RXDart list class 
        await RickMorty.getCharacters(context).then((value) => lists.updateCharacters(value));
        await RickMorty.getEpisodes(context).then((value) => lists.updateEpisodes(value));
        await RickMorty.getLocations(context).then((value) => lists.updateLocations(value));
        
        //Send user to homepage
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }
}


///This class removes app lists shadows 
class _RemoveListShadow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}