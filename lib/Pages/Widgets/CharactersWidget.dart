import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/ALL.dart';
import 'package:rick_morty/API/RickMorty_API.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Pages/DetailScreens/CharacterDetails.dart';
import 'package:rick_morty/RXDart/Constants.dart';

class CharactersWidget extends StatefulWidget {
  @override
  _CharactersWidgetState createState() => _CharactersWidgetState();
}

class _CharactersWidgetState extends State<CharactersWidget> {

  List<Character> characters = [];

  @override
  void initState() { 
    super.initState();
    RickMorty.getCharacters()..then((value) 
      => setState(() => characters = value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        ListTile(
          title: Text('Characters', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        Container(
          height: screenData.screenHeight / 2,
          child: (characters.isNotEmpty) 
            ? ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, int n) => (n == 20) 
              ? AspectRatio(
                aspectRatio: 1.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                      image: DecorationImage(image: AssetImage('Assets/Images/avatar2.png'))
                    ),
                    padding: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomCenter,
                    child: RMText('See all', textScaleFactor: 3),
                  ),
                ) 
              )
              : GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetails(characters[n]))),
                child: AspectRatio(
                  aspectRatio: 1/1.4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Hero(
                      tag: characters[n].id,
                      child: Material(
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                height: 200,
                                fit: BoxFit.fitHeight,
                                imageUrl: characters[n].image 
                                  ?? 'https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/55/6c/3d/556c3db2-a149-332e-7e6e-a490f7b00f0c/source/256x256bb.jpg',
                                progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                  ],
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              padding: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.bottomCenter,
                              child: RMText(characters[n].name, textScaleFactor: 1.4, maxLines: 3,),
                            ),
                          ],
                        ),
                      ),
                    )
                  ) 
                ),
              ),
              itemCount: 21,
            )
          : Container(),
        )
      ],
    );
  }
}