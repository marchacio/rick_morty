import 'package:flutter/material.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/HomePage/Widgets/CharactersWidget.dart';
import 'package:rick_morty/HomePage/Widgets/EpisodesWidget.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([

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
            EpisodesWidget()

          ]))  
        ],
      ),
    );
  }
}