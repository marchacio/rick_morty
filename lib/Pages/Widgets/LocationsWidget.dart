import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/Location.dart';
import 'package:rick_morty/API/RickMorty_API.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Pages/DetailScreens/LocationsDetails.dart';
import 'package:rick_morty/Pages/Lists/LocationsList.dart';

class LocationsWidget extends StatelessWidget {
  const LocationsWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Location> positionList = RickMorty.getCasualLocations();

    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Locations', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Image.asset('Assets/Images/planet1.png'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationsList())),
        ),
      ] + List.generate(positionList.length, 
        (index) => ((index % 2) == 0) ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationDetails(positionList[index]))),
                child: Card(
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RMText(positionList[index].name, textScaleFactor: 1.2,),
                  ),
                ),
              )),
              Expanded(child: GestureDetector(
                onTap: (index + 1) == 5 
                  ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationsList())) 
                  : () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationDetails(positionList[index + 1]))),
                child: Card(
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: RMText((index + 1) == 5 ? 'See All   >' : positionList[index + 1].name, textScaleFactor: 1.2),
                  ),
                ),
              )),
            ],
          ),
        ) : Container()),
    );
  }
}