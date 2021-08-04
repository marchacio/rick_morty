import 'package:rick_morty/API/Classes/ALL.dart';
import 'package:rxdart/rxdart.dart';

class Lists {

  ///All characters are in this list
  BehaviorSubject<List<Character>> _characters = BehaviorSubject<List<Character>>();
  List<Character> get characters => _characters.value;
  void updateCharacters(List<Character> newDatabase) => _characters.add(newDatabase);


  ///All locations are in this list
  BehaviorSubject<List<Location>> _locations = BehaviorSubject<List<Location>>();
  List<Location> get locations => _locations.value;
  void updateLocations(List<Location> newDatabase) => _locations.add(newDatabase);


  ///All episodes are in this list
  BehaviorSubject<List<Episode>> _episodes = BehaviorSubject<List<Episode>>();
  List<Episode> get episodes => _episodes.value;
  void updateEpisodes(List<Episode> newDatabase) => _episodes.add(newDatabase);

}