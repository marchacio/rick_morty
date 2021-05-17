import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Error/ErrorHandler.dart';
import 'package:rick_morty/HomePage/Widgets/CharactersWidget.dart';
import 'package:rick_morty/HomePage/Widgets/EpisodesWidget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() { 
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.none){
        Errors.connectionError(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([

            TextButton(onPressed: () => Errors.connectionError(context), child: Text('error')),

            ///The title bar
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 2,
                    child: Image.asset('Assets/Images/splashScreen.png')),

                  Container(width: 20),

                  Flexible(
                    flex: 1,
                    child: RMText('WIKI', textScaleFactor: 3, textAlign: TextAlign.right,)),
                ],
              ),
            ),

            SizedBox(height: 30),

            ///The main horizontal list
            CharactersWidget(),

            SizedBox(height: 30),

            ///The episodes horizontal list
            EpisodesWidget(),

            SizedBox(height: 30),

            

          ]))  
        ],
      ),
    );
  }
}