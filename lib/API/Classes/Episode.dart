
import 'package:rick_morty/API/Classes/RickMortyDefaultClass.dart/RickMortyDefaultClass.dart';

///This is the class of episodes
///
///_There is a total of 41 episodes sorted by id (which is of course the order of the episodes)_
class Episode extends RickMortyDefaultClass {

  ///The air date of the episode
  String? airDate;

  ///The code of the episode
  String? episode;

  ///List of links of characters who have been seen in the episode
  List<String>? characters;

  Episode({
    required String name,
    required String url,
    required String created,

    this.airDate,
    this.episode,
    this.characters,
  }) : super(
    name: name,
    url: url,
    created: created,
  );

  

}