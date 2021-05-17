
///This is the default class for sub-classes of "Rick and Morty API"
class RickMortyDefaultClass {

  ///The id of the episode/location/character
  int id;

  ///The name of the episode/location/character
  String name;

  ///Time at which the episode/location/character was created in the database
  String created;

  ///Link to the episode/location/character's own endpoint
  String url;

  RickMortyDefaultClass({
    required this.id,
    required this.name,
    required this.url,
    required this.created,
  });

}