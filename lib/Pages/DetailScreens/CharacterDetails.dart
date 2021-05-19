import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/Character.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';

class CharacterDetails extends StatelessWidget {

  final Character character;
  CharacterDetails(this.character);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([

            Container(
              width: double.infinity,

              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: character.id,
                  child: Material(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: character.image 
                              ?? 'https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/55/6c/3d/556c3db2-a149-332e-7e6e-a490f7b00f0c/source/256x256bb.jpg',
                            progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AspectRatio(
                            aspectRatio: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircleAvatar(child: BackButton()),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            RMText(character.name, textScaleFactor: 3, maxLines: 3,),

            ListTile(
              title: Text(character.gender.toString().replaceAll('Gender.', '')),
              subtitle: Text('Gender'),
            ),

            ListTile(
              title: Text(character.status.toString().replaceAll('Status.', '')),
              subtitle: Text('Status'),
            ),

            SizedBox(height: 15),

            ListTile(
              title: Text(character.species ?? 'Unknown'),
              subtitle: Text('Species'),
            ),

            (character.type != null && character.type.toString() != '') ? ListTile(
              title: Text(character.type!),
              subtitle: Text('Type'),
            ) : Container(),

            SizedBox(height: 15),

            ListTile(
              title: Text((character.origin != null) ? character.origin!.name : 'Unknown'),
              subtitle: Text('Origin'),
            ),

            ListTile(
              title: Text((character.location != null) ? character.location!.name : 'Unknown'),
              subtitle: Text('Location'),
            ),

          ]))
        ],
      ),
    );
  }
}