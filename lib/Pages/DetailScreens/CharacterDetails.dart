import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/Character.dart';
import 'package:rick_morty/API/Classes/Episode.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Pages/DetailScreens/EpisodeDetails.dart';
import 'package:rick_morty/Pages/DetailScreens/LocationsDetails.dart';
import 'package:rick_morty/RXDart/Constants.dart';


class CharacterDetails extends StatelessWidget {

  final Character character;
  CharacterDetails(this.character);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([

            Container(
              width: double.infinity,

              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: character.url,
                  child: Material(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: character.image 
                            ?? 'https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/55/6c/3d/556c3db2-a149-332e-7e6e-a490f7b00f0c/source/256x256bb.jpg',
                          progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AspectRatio(
                            aspectRatio: 10,
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              child: BackButton(),
                              height: kFloatingActionButtonMargin,
                              width: kFloatingActionButtonMargin,
                              //decoration: BoxDecoration(
                              //  shape: BoxShape.circle
                              //),
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Center(child: RMText(character.name, textScaleFactor: 3, maxLines: 3, textAlign: TextAlign.center,)),
            ),

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

            if(character.origin != null) ListTile(
              title: Text(lists.locations.where((element) => element.url == character.origin).first.name),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationDetails(
                lists.locations.where((element) => element.url == character.origin).first))),
              subtitle: Text('Origin'),
            ),

            if(character.location != null) ListTile(
              title: Text(lists.locations.where((element) => element.url == character.location).first.name),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LocationDetails(
                lists.locations.where((element) => element.url == character.location).first))),
              subtitle: Text('Location'),
            ),

            Column(
              children: <Widget>[
                Divider(color: Colors.transparent),
                Text('Episodes in which the character appears', style: TextStyle(color: Colors.grey),),
              ] + List<Widget>.generate(lists.episodes.where((element) => (element.characters ?? []).contains(character.url)).length, 
                (index) {
                  Episode _episode = lists.episodes.where((element) => (element.characters ?? []).contains(character.url)).toList()[index];

                  return ListTile(
                    title: Text(_episode.name),
                    subtitle: Text(_episode.episode ?? ''),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeDetails(_episode))),
                  );
                }),
            )

          ]))
        ],
      ),
    );
  }
}
