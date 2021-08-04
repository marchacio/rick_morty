import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/ALL.dart';
import 'package:rick_morty/API/Classes/RickMortyDefaultClass.dart/RickMortyDefaultClass.dart';
import 'package:rick_morty/Pages/DetailScreens/CharacterDetails.dart';
import 'package:rick_morty/Pages/DetailScreens/EpisodeDetails.dart';
import 'package:rick_morty/Pages/DetailScreens/LocationsDetails.dart';
import 'package:rick_morty/RXDart/Constants.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<RickMortyDefaultClass> _searchedFiles = [];
  List<RickMortyDefaultClass> _allFiles = [];

  TextEditingController _controller = TextEditingController();

  @override
  void initState() { 
    super.initState();
    _allFiles += lists.characters;
    _allFiles += lists.episodes;
    _allFiles += lists.locations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([
            SizedBox(height: kToolbarHeight / 2),

            Card(
              elevation: 8,
              margin: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BackButton(),

                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      onChanged: (String _searched) {
                        _searchedFiles = [];

                        _allFiles.forEach((element) {
                          if(element.name.contains(_searched)){
                            _searchedFiles += [element];
                          }
                        });
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search, color: Colors.grey,),
                  )
                ],
              ),
            ),
          ])),

          SliverList(delegate: _searchedFiles.isEmpty 
            ? SliverChildListDelegate([
              Center(child: Image.asset('Assets/Images/search2.png')),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(_controller.text.trim() != '' ? 'No results found' : 'Type to search', textScaleFactor: 1.3, style: TextStyle(color: Colors.grey),)),
              )
            ])
            : SliverChildBuilderDelegate(
            (context, n) => ListTile(
              title: Text(_searchedFiles[n].name),
              trailing: Icon(Icons.keyboard_arrow_right),
              subtitle: Text(_searchedFiles[n] is Character 
                ? 'Character' : _searchedFiles[n] is Episode ? 'Episode' : 'Location'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _searchedFiles[n] is Character 
                ? CharacterDetails(lists.characters.firstWhere((element) => element.url == _searchedFiles[n].url)) : _searchedFiles[n] is Episode 
                  ? EpisodeDetails(lists.episodes.firstWhere((element) => element.url == _searchedFiles[n].url)) 
                    : LocationDetails(lists.locations.firstWhere((element) => element.url == _searchedFiles[n].url)))),
            ),
            childCount: _searchedFiles.length,
          ))    
        ],
      ),
    );
  }
}