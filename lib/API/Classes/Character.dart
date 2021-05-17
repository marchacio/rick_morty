
import 'package:rick_morty/API/Enums/Gender.dart';
import 'package:rick_morty/API/Enums/Status.dart';

import 'Location.dart';
import 'RickMortyDefaultClass.dart/RickMortyDefaultClass.dart';

///Character class for Rick and Morty API
///
///_There is a total of 671 characters sorted by id_
class Character extends RickMortyDefaultClass {

  ///Life status. See more about [Status]
  Status? status;

  ///The species of the character
  String? species;

  ///The type or subspecies of the character
  String? type;

  ///The gender of the character See more about [Gender].
  Gender? gender;

  ///Name and link to the character's origin location
  Location? origin;

  ///Name and link to the character's last known location endpoint
  Location? location;

  ///Link to the character's image. 
  ///All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
  String? image;

  ///List of links of episodes in which this character appeared
  List<String>? episode;


  Character({
    required int id,
    required String name,
    required String created,
    required String url,

    this.gender,
    this.episode,
    this.image,
    this.location,
    this.origin,
    this.species,
    this.status,
    this.type,
  }) : super(
    id: id,
    name: name,
    url: url,
    created: created,
  );
}
