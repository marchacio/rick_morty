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
      children: [

        ListTile(
          title: Text('Locations', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        
      ],
    );
  }
}