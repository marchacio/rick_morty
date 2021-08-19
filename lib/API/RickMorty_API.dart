import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/ALL.dart';
import 'dart:math';

import 'package:rick_morty/RXDart/Constants.dart';
import 'package:xml2json/xml2json.dart';



///The main class of the API
class RickMorty {

  ///Return all characters
  static Future<List<Character>> getCharacters(BuildContext context) async {
    List<Character> _finalList = [];
    

    final converter = Xml2Json();
    String data = await DefaultAssetBundle.of(context).loadString("Assets/Database/Characters.xml");

    converter.parse(data);

    ///Get the effective character and add it to _finalList
    for (Map _character in Map<String, dynamic>.from(json.decode(converter.toParker()))['characters']['row']) {
      _finalList.add(Character(
        name: _character['name'],
        url: _character['url'],
        created: _character['created'],
        episode: (_character['episode'] ?? '').toString().replaceAll('[', '').replaceAll(']', '').split(', '),
        gender: genderFromString(_character['gender']),
        image: _character['image'],
        location: (_character['location'] ?? '[]').toString().split('MARCHACIO_RICKMORTY')[1].toString(),
        origin: (_character['origin'] ?? '[]').toString().split('MARCHACIO_RICKMORTY')[1].toString(),
        species: _character['species'],
        status: statusFromString(_character['status']),
        type: _character['type'],
      ));
    }

    return _finalList;
  }



  ///Return all episodes saved in database
  static Future<List<Episode>> getEpisodes(BuildContext context) async {
    List<Episode> _finalList = [];


    final converter = Xml2Json();
    String data = await DefaultAssetBundle.of(context).loadString("Assets/Database/Episodes.xml");

    converter.parse(data);

    //Get the effective episode and add it to _finalList
    for (Map _episode in Map<String, dynamic>.from(json.decode(converter.toParker()))['episodes']['row']) {
      _finalList.add(Episode(
        name: _episode['name'],
        url: _episode['url'],
        created: _episode['created'],
        airDate: _episode['air_date'],
        characters: (_episode['characters'] ?? []).toString().replaceAll('[', '').replaceAll(']', '').split(', '),
        episode: _episode['episode'],
      ));
    }

    return _finalList;
  }


  ///Return a casual list of 5 episodes
  static List<Episode> getCasualEpisodes({int numberOfEpisodes = 5}) {
    assert(numberOfEpisodes < 41);

    List<Episode> _finalList = [];

    List<int> _casualEpisodes = [];
    Random random = Random();
    for (var i = 0; i < numberOfEpisodes; i++) {
      int number = random.nextInt(41);
      if(_casualEpisodes.contains(number)){
        i--;
      } else {
        _casualEpisodes.add(number);
      }
    }
    
    for (int index in _casualEpisodes) {
      _finalList.add(lists.episodes[index]);
    }

    return _finalList;
  }


  ///Return all locations saved in database
  static Future<List<Location>> getLocations(BuildContext context) async {
    List<Location> _finalList = [];


    final converter = Xml2Json();
    String data = await DefaultAssetBundle.of(context).loadString("Assets/Database/Locations.xml");

    converter.parse(data);

    ///Get the effective location and add it to _finalList
    for (Map _location in Map<String, dynamic>.from(json.decode(converter.toParker()))['locations']['row']) {
      _finalList.add(Location(
        name: _location['name'],
        url: _location['url'],
        created: _location['created'],
        dimension: _location['dimension'],
        residents: (_location['residents'] ?? []).toString().replaceAll('[', '').replaceAll(']', '').split(', '),
        type: _location['type'],
      ));
    }

    return _finalList;
  }



  ///Return a casual list of 5 locations
  static List<Location> getCasualLocations({int numberOfLocations = 5}) {

    assert(numberOfLocations < 108);

    List<Location> _finalList = [];

    List<int> _casualLocations = [];
    Random random = Random();
    for (var i = 0; i < numberOfLocations; i++) {
      int number = random.nextInt(108);
      if(_casualLocations.contains(number)){
        i--;
      } else {
        _casualLocations.add(number);
      }
    }


    ///Get the effective locations and add it to _finalList
    for (int index in _casualLocations) {
      _finalList.add(lists.locations[index]);
    }

    return _finalList;
  }


  ///Return a [Gender] instance from a String
  static Gender genderFromString(String string) {
    Gender _gender = Gender.Unknown;

    Gender.values.forEach((element) {
      if(element.toString() == 'Gender.$string') {
        _gender = element;
      }
    });

    return _gender;
  }

  ///Return a [Status] instance from a String
  static Status statusFromString(String string) {
    Status _status = Status.Unknown;

    Status.values.forEach((element) {
      if(element.toString() == 'Status.$string') {
        _status = element;
      }
    });

    return _status;
  }
}