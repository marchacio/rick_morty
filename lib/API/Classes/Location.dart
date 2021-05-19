
///The basic info about a location
///
///For a more detailed class, are you looking to [AdvancedLocation]?
///
///_There is a total of 108 locations sorted by id_
class Location {

  ///The name of the location
  String name;

  ///Link to the location's own endpoint
  String url;

  Location({
    required this.name,
    required this.url,
  });


  ///Yes, hahahahhahah i used a string separator
  ///An efficient choice, but I'm ashamed of it hahaha
  @override
  String toString() {
    return name + 'MARCHACIO_RICKMORTY' + url;
  }
}


///[AdvancedLocation] provides more details about a [Location]
class AdvancedLocation extends Location {
  
  ///Location id
  int id;

  ///The type of the location
  String? type;

  ///The dimension in which the location is located
  String? dimension;

  ///List of links of character who have been last seen in the location
  List<String>? residents;

  ///Time at which the location was created in the database
  String? created;
  
  AdvancedLocation({
    required String name,
    required String url,
    required this.id,

    this.created,
    this.type,
    this.dimension,
    this.residents,
  }) : super(name: name, url: url);

}
