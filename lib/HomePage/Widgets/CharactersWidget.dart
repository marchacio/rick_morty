import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/ALL.dart';
import 'package:rick_morty/API/RickMorty_API.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';

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
        ),

        Container(
          height: 200, //TODO
          child: FutureBuilder(
            future: RickMorty.getCharacters(),
            builder: (context, AsyncSnapshot<List<Character>> snap) {
              if(snap.data != null) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, int n) => AspectRatio(
                    aspectRatio: 1/1.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              height: 200,
                              fit: BoxFit.fitHeight,
                              imageUrl: snap.data![n].image 
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
                            child: RMText(snap.data![n].name, textScaleFactor: 1.4, maxLines: 3,),
                          ),
                        ],
                      ),
                    ) 
                  ),
                  itemCount: snap.data!.length,
                );
              }

              return Container();
            }
          ),
        )
      ],
    );
  }
}