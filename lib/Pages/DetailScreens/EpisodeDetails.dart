import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/Character.dart';
import 'package:rick_morty/API/Classes/Episode.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Pages/DetailScreens/CharacterDetails.dart';
import 'package:rick_morty/RXDart/Constants.dart';

class EpisodeDetails extends StatelessWidget {

  final Episode episode;

  const EpisodeDetails(this.episode, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([
            SizedBox(height: 25),

            Center(child: Padding(
              padding: const EdgeInsets.all(15),
              child: RMText(episode.name, textScaleFactor: 3, textAlign: TextAlign.center),
            )),

            if(episode.episode != null) ListTile(
              title: Text(episode.episode!),
              subtitle: Text('Episode code'),
            ),
            
            if(episode.airDate != null) ListTile(
              title: Text(episode.airDate!),
              subtitle: Text('Air Date'),
            ),

            Column(
              children: <Widget>[
                Divider(color: Colors.transparent),

                ListTile(
                  title: Text('Episode characters:', style: TextStyle(color: Colors.grey),),
                ),
              ] + List<Widget>.generate(
                lists.characters.where((element) => (episode.characters ?? []).contains(element.url)).length,
                (index) {
                  Character _char = lists.characters.where((element) => (episode.characters ?? []).contains(element.url)).toList()[index];
                  return Row(
                    children: [
                      SizedBox(width: 30),

                      Expanded(
                        child: ListTile(
                          title: Text(_char.name),
                          subtitle: Text(_char.species ?? ''),
                          trailing: Transform.scale(scale: 0.8,
                            child: ClipOval(child: Image.network(_char.image
                              ?? 'https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/55/6c/3d/556c3db2-a149-332e-7e6e-a490f7b00f0c/source/256x256bb.jpg',)),
                          ),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetails(_char))),
                        ),
                      )
                    ],
                  );
                }),
            )
          ])),
        ],
      ),
    );
  }
}