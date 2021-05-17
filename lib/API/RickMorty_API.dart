import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_morty/API/Classes/ALL.dart';
import 'dart:math';



///The main class of the API
class RickMorty {

  ///This is the base url to get online info
  static String baseURL = "https://rickandmortyapi.com/api";


  ///Return a list of X characters
  ///
  ///Change [page] value to get other characters
  static Future<List<Character>> getCharacters({int page = 1}) async {
    List<Character> _finalList = [];

    //Get the response from server
    http.Response response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'));
    List<dynamic> _characters = Map.from(json.decode(response.body))['results'];

    ///Get the effective character and add it to _finalList
    for (Map _character in _characters) {
      _finalList.add(Character(
        id: _character['id'],
        name: _character['name'],
        url: _character['url'],
        created: _character['created'],

        episode: List.from(_character['episode']),
        gender: genderFromString(_character['gender']),
        image: _character['image'],
        location: Location(
          name: _character['location']['name'],
          url: _character['location']['url'],
        ),
        origin: Location(
          name: _character['origin']['name'],
          url: _character['origin']['url'],
        ),
        species: _character['species'],
        status: statusFromString(_character['status']),
        type: _character['type'],
      ));
    }

    return _finalList;
  }




  ///Return a list of X episodes
  ///
  ///Change [page] value to get other episodes
  static Future<List<Episode>> getEpisodes({int page = 1}) async {
    List<Episode> _finalList = [];

    //Get the response from server
    http.Response response = await http.get(Uri.parse('https://rickandmortyapi.com/api/episode/?page=$page'));
    List<dynamic> _episodes = Map.from(json.decode(response.body))['results'];

    ///Get the effective episode and add it to _finalList
    for (Map _episode in _episodes) {
      _finalList.add(Episode(
        id: _episode['id'],
        name: _episode['name'],
        url: _episode['url'],
        created: _episode['created'],
        airDate: _episode['air_date'],
        characters: List.from(_episode['characters']),
        episode: _episode['episode'],
      ));
    }

    return _finalList;
  }


  ///Return a casual list of 8 episodes
  static Future<List<Episode>> getCasualEpisodes({int numberOfEpisodes = 5}) async {
    List<Episode> _finalList = [];

    List<int> _casualEpisodes = [];
    Random random = Random();
    for (var i = 0; i < numberOfEpisodes; i++) {
      int number = random.nextInt(41) + 1;
      if(_casualEpisodes.contains(number)){
        i--;
      } else {
        _casualEpisodes.add(number);
      }
    }

    //Get the response from server
    http.Response response = await http.get(Uri.parse('https://rickandmortyapi.com/api/episode/${_casualEpisodes.join(', ')}'));
    List<dynamic> _episodes = List.from(json.decode(response.body));

    ///Get the effective episode and add it to _finalList
    for (Map _episode in _episodes) {
      _finalList.add(Episode(
        id: _episode['id'],
        name: _episode['name'],
        url: _episode['url'],
        created: _episode['created'],
        airDate: _episode['air_date'],
        characters: List.from(_episode['characters']),
        episode: _episode['episode'],
      ));
    }

    return _finalList;
  }






  ///Return a list of X locations
  ///
  ///Change [page] value to get other locations
  static Future<List<AdvancedLocation>> getLocations({int page = 1}) async {
    List<AdvancedLocation> _finalList = [];

    //Get the response from server
    http.Response response = await http.get(Uri.parse('https://rickandmortyapi.com/api/episode/?page=$page'));
    List<dynamic> _locations = Map.from(json.decode(response.body))['results'];

    ///Get the effective location and add it to _finalList
    for (Map _location in _locations) {
      _finalList.add(AdvancedLocation(
        id: _location['id'],
        name: _location['name'],
        url: _location['url'],
        created: _location['created'],
        dimension: _location['dimension'],
        residents: List.from(_location['residents']),
        type: _location['type'],
      ));
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