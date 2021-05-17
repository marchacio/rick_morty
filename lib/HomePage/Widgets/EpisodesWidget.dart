import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/ALL.dart';
import 'package:rick_morty/API/RickMorty_API.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';

class EpisodesWidget extends StatefulWidget {
  @override
  _EpisodesWidgetState createState() => _EpisodesWidgetState();
}

class _EpisodesWidgetState extends State<EpisodesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        ListTile(
          title: Text('Episodes', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        FutureBuilder(
          future: RickMorty.getCasualEpisodes(),
          builder: (context, AsyncSnapshot<List<Episode>> snap) {
            if(snap.data != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  spacing: 5,
                  children: List<Widget>.generate(
                    snap.data!.length, 
                    (n) => Chip(
                      label: Text(snap.data![n].name),
                      onDeleted: () => null,
                      deleteIcon: RMText(snap.data![n].episode!.replaceRange(3, null, '').replaceFirst('0', ' '), textScaleFactor: 0.9, maxLines: 1,),
                    )
                  ),
                ),
              );
            }

            return Container();
          }
        ),
      ],
    );
  }
}