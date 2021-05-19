import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/Location.dart';
import 'package:rick_morty/API/RickMorty_API.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';

class LocationsWidget extends StatefulWidget {
  @override
  _LocationsWidgetState createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {

  List<AdvancedLocation> positionList = [];

  @override
  void initState() { 
    super.initState();
    RickMorty.getCasualLocations()..then((List<AdvancedLocation> list) 
      => setState(() => positionList = list));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Locations', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Image.asset('Assets/Images/planet1.png'),
        ),
      ] + List.generate(positionList.length, 
        (index) => ((index % 2) == 0) ? Row(
          children: [
            Expanded(child: Card(
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RMText(positionList[index].name, textScaleFactor: 1.2,),
              ),
            )),
            Expanded(child: Card(
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: RMText((index + 1) == 5 ? 'See All' : positionList[index + 1].name, textScaleFactor: 1.2,),
              ),
            )),
          ],
        ) : Container()),
    );
  }
}