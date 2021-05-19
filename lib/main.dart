import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_morty/Error/ErrorHandler.dart';
import 'package:rick_morty/RXDart/Constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Pages/HomePage.dart';

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

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none) {
      await Errors.connectionError(context);
      return;
    } else {
      String _databasesPath = await getDatabasesPath();
      String path = _databasesPath + "/Database.db";
      
      if (!await databaseExists(path)) {
        // Should happen only the first time you launch your application
        print("Creating new copy from asset");

        // Make sure the parent directory exists
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}
          
        // Copy from asset
        ByteData data = await rootBundle.load('Assets/Database/Database.db');
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        
        // Write and flush the bytes written
        await File(path).writeAsBytes(bytes, flush: true);

      } else {
        print("Opening existing database");
      }

      //Read database and upgrade constants variables
      await openDatabase(path, readOnly: true).then((db) => database.updateDatabase(db));

      await Future.delayed(Duration(milliseconds: 900)).then((value) {
        screenData.updateHeight(MediaQuery.of(context).size.height);
        screenData.updateHeight(MediaQuery.of(context).size.width);
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }
}

