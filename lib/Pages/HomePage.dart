import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Error/ErrorHandler.dart';
import 'package:rick_morty/Pages/Widgets/CharactersWidget.dart';
import 'package:rick_morty/Pages/Widgets/EpisodesWidget.dart';
import 'package:rick_morty/Pages/Widgets/LocationsWidget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() { 
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.none){
        Errors.connectionError(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([

            ///The title bar
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 2,
                    child: Image.asset('Assets/Images/splashScreen.png')),

                  Container(width: 20),

                  Flexible(
                    flex: 1,
                    child: RMText('WIKI', textScaleFactor: 3, textAlign: TextAlign.right,)),
                ],
              ),
            ),

            SizedBox(height: 30),



            SizedBox(height: 30),
            
            ///The main horizontal list
            CharactersWidget(),

            SizedBox(height: 40),

            ///The episodes horizontal list
            EpisodesWidget(),

            SizedBox(height: 40),

            ///The locations widget
            LocationsWidget(),

            SizedBox(height: 30),

          ]))
        ],
      ),
    );
  }
}


//I used this code below to get the database with all the values provided by the RM API
/**

            TextButton(onPressed: () async {

              Future<List<Character>> _getCharacters({int page = 1}) async {
                List<Character> _finalList = [];

                //Get the response from server
                http.Response response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'));
                List<dynamic> _characters = Map.from(json.decode(response.body))['results'] ?? [];

                ///Get the effective character and add it to _finalList
                for (Map _character in _characters) {
                  _finalList.add(Character(
                    id: _character['id'],
                    name: _character['name'],
                    url: _character['url'],
                    created: _character['created'],
                    episode: List.from(_character['episode'] ?? []),
                    gender: RickMorty.genderFromString(_character['gender']),
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
                    status: RickMorty.statusFromString(_character['status']),
                    type: _character['type'],
                  ));
                }

                return _finalList;
              }

              Future<List<AdvancedLocation>> _getLocations({int page = 1}) async {
                List<AdvancedLocation> _finalList = [];

                //Get the response from server
                http.Response response = await http.get(Uri.parse('https://rickandmortyapi.com/api/location/?page=$page'));
                List<dynamic> _locations = Map.from(json.decode(response.body))['results'];

                ///Get the effective location and add it to _finalList
                for (Map _location in _locations) {
                  _finalList.add(AdvancedLocation(
                    id: _location['id'],
                    name: _location['name'],
                    url: _location['url'],
                    created: _location['created'],
                    dimension: _location['dimension'],
                    residents: List.from(_location['residents'] ?? []),
                    type: _location['type'],
                  ));
                }

                return _finalList;
              }

              Future<List<Episode>> _getEpisodes({int page = 1}) async {
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
                    characters: List.from(_episode['characters'] ?? []),
                    episode: _episode['episode'],
                  ));
                }

                return _finalList;
              }

              // Get a location using getDatabasesPath
              var databasesPath = await getDatabasesPath();
              String pathLocation = databasesPath + '/Characters.db';

              try {
                await File(pathLocation).delete();
              } catch (e) {
              }


              // open the database
              Database database = await openDatabase(pathLocation, version: 1,
                onCreate: (Database db, int version) async {
                  await db.execute('CREATE TABLE Characters(id INTEGER PRIMARY KEY, name TEXT, status TEXT, species TEXT, type TEXT, gender TEXT, origin TEXT, location TEXT, image TEXT, episode TEXT, url TEXT, created TEXT)');
                  await db.execute('CREATE TABLE Locations(id INTEGER PRIMARY KEY, name TEXT, type TEXT, dimension TEXT, residents TEXT, url TEXT, created TEXT)');
                  await db.execute('CREATE TABLE Episodes(id INTEGER PRIMARY KEY, name TEXT, air_date TEXT, episode TEXT, characters TEXT, url TEXT, created TEXT)');
                }
              );
              
              List<AdvancedLocation> locations = [];
              for (var i = 1; i <= 6; i++) {
                print('locations: ' + i.toString());
                locations += await _getLocations(page: i);
              }

              List<Character> characters = [];
              for (var i = 1; i <= 34; i++) {
                print('characters: ' + i.toString());
                characters += await _getCharacters(page: i);
              }

              List<Episode> episodes = [];
              for (var i = 1; i <= 3; i++) {
                print('episodes: ' + i.toString());
                episodes += await _getEpisodes(page: i);
              }

              await database.transaction((txn) async {

                //Locations
                for (AdvancedLocation item in locations) {
                  await txn.rawInsert(
                    'INSERT INTO Locations(name, type, dimension, residents, url, created) VALUES(?, ?, ?, ?, ?, ?)',
                    [item.name.toString(), item.type.toString(), item.dimension.toString(), item.residents.toString(), item.url.toString(), item.created.toString()]
                  );
                }
                
                //Characters
                for (Character item in characters) {
                  await txn.rawInsert(
                    'INSERT INTO Characters(name, status, species, type, gender, origin, location, image, episode, url, created) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                    [item.name.toString(), item.status.toString(), item.species.toString(), item.type.toString(), item.gender.toString(), item.origin.toString(),
                      item.location.toString(), item.image.toString(), item.episode.toString(), item.url.toString(), item.created.toString()]
                  );
                }

                //Episodes
                for (Episode item in episodes) {
                  await txn.rawInsert(
                    'INSERT INTO Episodes(name, air_date, episode, characters, url, created) VALUES(?, ?, ?, ?, ?, ?)',
                    [item.name.toString(), item.airDate.toString(), item.episode.toString(), item.characters.toString(), item.url.toString(), item.created.toString()]
                  );
                }
              });

              await database.close();
              print('done');
            }, child: Text('Get the database')),
 */     
