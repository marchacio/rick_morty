import 'package:rick_morty/API/Classes/ALL.dart';
import 'dart:math';

import 'package:rick_morty/RXDart/Constants.dart';



///The main class of the API
class RickMorty {

  ///Return a list of 20 characters
  ///
  ///Change [page] value to get other characters
  static Future<List<Character>> getCharacters() async {
    List<Character> _finalList = [];

    //Load characters from database
    List<Map<String, Object?>> _characters = await database.database.rawQuery('SELECT * FROM Characters');

    ///Get the effective character and add it to _finalList
    for (Map _character in _characters) {
      _finalList.add(Character(
        id: _character['id'],
        name: _character['name'],
        url: _character['url'],
        created: _character['created'],
        episode: (_character['episode'] ?? '').toString().replaceAll('[', '').replaceAll(']', '').split(', '),
        gender: genderFromString(_character['gender']),
        image: _character['image'],
        location: Location(
          name: (_character['location'] ?? '[]').toString().split('MARCHACIO_RICKMORTY')[0].toString(),
          url: (_character['location'] ?? '[]').toString().split('MARCHACIO_RICKMORTY')[1].toString(),
        ),
        origin: Location(
          name: (_character['origin'] ?? '[]').toString().split('MARCHACIO_RICKMORTY')[0].toString(),
          url: (_character['origin'] ?? '[]').toString().split('MARCHACIO_RICKMORTY')[1].toString(),
        ),
        species: _character['species'],
        status: statusFromString(_character['status']),
        type: _character['type'],
      ));
    }

    return _finalList;
  }



  ///Return all episodes saved in database
  static Future<List<Episode>> getEpisodes() async {
    List<Episode> _finalList = [];

    //Load episodes from database
    List<Map<String, Object?>> _episodes = await database.database.rawQuery('SELECT * FROM Episodes');

    //Get the effective episode and add it to _finalList
    for (Map _episode in _episodes) {
      _finalList.add(Episode(
        id: _episode['id'],
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


  ///Return a casual list of 8 episodes
  static Future<List<Episode>> getCasualEpisodes({int numberOfEpisodes = 5}) async {
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

    List<Episode> _episodes = await getEpisodes();
    
    for (int index in _casualEpisodes) {
      _finalList.add(_episodes[index]);
    }

    return _finalList;
  }


  ///Return all locations saved in database
  static Future<List<AdvancedLocation>> getLocations() async {
    List<AdvancedLocation> _finalList = [];

    //Load locations from database
    List<Map<String, Object?>> _locations = await database.database.rawQuery('SELECT * FROM Locations');

    ///Get the effective location and add it to _finalList
    for (Map _location in _locations) {
      _finalList.add(AdvancedLocation(
        id: _location['id'],
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
  static Future<List<AdvancedLocation>> getCasualLocations({int numberOfLocations = 5}) async {

    assert(numberOfLocations < 108);

    List<AdvancedLocation> _finalList = [];

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

    List<AdvancedLocation> _locations = await getLocations();

    ///Get the effective locations and add it to _finalList
    for (int index in _casualLocations) {
      _finalList.add(_locations[index]);
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