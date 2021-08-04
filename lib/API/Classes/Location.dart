import 'package:rick_morty/API/Classes/RickMortyDefaultClass.dart/RickMortyDefaultClass.dart';


///[Location] provides more details about a
class Location extends RickMortyDefaultClass {

  ///The type of the location
  String? type;

  ///The dimension in which the location is located
  String? dimension;

  ///List of links of character who have been last seen in the location
  List<String>? residents;
  
  Location({
    required int id,
    required String name,
    required String created,
    required String url,

    this.type,
    this.dimension,
    this.residents,
  }) : super(
    id: id,
    name: name,
    url: url,
    created: created,
  );
}
