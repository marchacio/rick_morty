import 'package:flutter/material.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Pages/DetailScreens/LocationsDetails.dart';
import 'package:rick_morty/Pages/Widgets/SearchWidget.dart';
import 'package:rick_morty/RXDart/Constants.dart';


class LocationsList extends StatelessWidget {
  const LocationsList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          SliverList(delegate: SliverChildListDelegate([
            SizedBox(height: MediaQuery.of(context).padding.top),
            
            Stack(
              alignment: Alignment.topLeft,
              children: [

                Column(
                  children: [
                    Image.asset('Assets/Images/planet1.png', scale: 4,),

                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Center(child: RMText('All locations', textScaleFactor: 3, textAlign: TextAlign.center)),
                    ),
                  ],
                ),

                BackButton(),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  SearchWidget(),
                ],
              ),
            )
          ])),

          SliverList(delegate: SliverChildBuilderDelegate(
            (context, int n) => ListTile(
              title: Text(lists.locations[n].name),
              trailing: Icon(Icons.keyboard_arrow_right),
              subtitle: Text(lists.locations[n].type ?? ''),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationDetails(lists.locations[n]))),
            ),
            childCount: lists.locations.length,
          ))
        ],
      )
    );
  }
}
