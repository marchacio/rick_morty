import 'package:flutter/material.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/main.dart';


///Class to invoce static methods for errors
class Errors {

  static Future<void> connectionError(BuildContext context) async => await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [

          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 100),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(height: 200),

                    RMText('Network Error', textScaleFactor: 2.5),

                    Divider(color: Colors.transparent),

                    Text('Oops, a connection error has occurred!\nYou must be connected to the internet to continue using this app',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),

                    Divider(color: Colors.transparent),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () => Navigator.pop(context), 
                        child: Text('Mh, retry')),
                    )
                  ],
                ),
              ),
            ],
          ),

          Image.asset('Assets/Images/avatar1.png', scale: 3),
        ],
      ) 
    )
  ).then((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen())));

}