import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Pages/DetailScreens/CharacterDetails.dart';
import 'package:rick_morty/Pages/Lists/CharactersList.dart';
import 'package:rick_morty/RXDart/Constants.dart';

class CharactersWidget extends StatefulWidget {
  @override
  _CharactersWidgetState createState() => _CharactersWidgetState();
}

class _CharactersWidgetState extends State<CharactersWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        ListTile(
          title: Text('Characters', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CharactersList())),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),

        Container(
          height: screenData.screenHeight / 2,
          child: (lists.characters.isNotEmpty) 
            ? ListView.builder(
              //To save ram:
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,

              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, int n) => (n == 20) 
              ? GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CharactersList())),
                child: AspectRatio(
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
                ),
              )
              : GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetails(lists.characters[n]))),
                child: AspectRatio(
                  aspectRatio: 1/1.4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Hero(
                      tag: lists.characters[n].url,
                      child: Material(
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                height: 200,
                                fit: BoxFit.fitHeight,
                                imageUrl: lists.characters[n].image 
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
                              child: RMText(lists.characters[n].name, textScaleFactor: 1.4, maxLines: 3,),
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