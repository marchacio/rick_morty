import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/ALL.dart';
import 'package:rick_morty/API/RickMorty_API.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';

class EpisodesWidget extends StatefulWidget {
  @override
  _EpisodesWidgetState createState() => _EpisodesWidgetState();
}

class _EpisodesWidgetState extends State<EpisodesWidget> {

  List<Episode> randomEpisodes = [];

  @override
  void initState() { 
    super.initState();
    RickMorty.getCasualEpisodes()..then((value) 
      => setState(() => randomEpisodes = value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ListTile(
          title: Text('Episodes', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Image.asset('Assets/Images/avatar1.png'),
        ),

        (randomEpisodes.isNotEmpty) ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            spacing: 5,
            children: List<Widget>.generate(
              randomEpisodes.length, 
              (n) => Chip(
                label: Text(randomEpisodes[n].name),
                onDeleted: () => null,
                deleteIcon: RMText(randomEpisodes[n].episode!.replaceRange(3, null, '').replaceFirst('0', ' '), textScaleFactor: 0.9, maxLines: 1,),
              )
            ),
          ),
        ) : Container(),
      ],
    );
  }
}