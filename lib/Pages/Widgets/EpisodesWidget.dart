import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/ALL.dart';
import 'package:rick_morty/API/RickMorty_API.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Pages/DetailScreens/EpisodeDetails.dart';
import 'package:rick_morty/Pages/Lists/EpisodesList.dart';

class EpisodesWidget extends StatelessWidget {
  const EpisodesWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Episode> randomEpisodes = RickMorty.getCasualEpisodes();

    return Column(
      children: [

        ListTile(
          title: Text('Episodes', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Image.asset('Assets/Images/avatar1.png'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodesList())),
        ),

        (randomEpisodes.isNotEmpty) ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            spacing: 5,
            children: List<Widget>.generate(
              randomEpisodes.length, 
              (n) => GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeDetails(randomEpisodes[n]))),
                child: Chip(
                  label: Text(randomEpisodes[n].name),
                  onDeleted: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeDetails(randomEpisodes[n]))),
                  backgroundColor: Colors.grey.shade200,
                  deleteIcon: RMText(randomEpisodes[n].episode!.replaceRange(3, null, '').replaceFirst('0', ' '), textScaleFactor: 0.9, maxLines: 1,),
                ),
              )
            ) + [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodesList())),
                child: Chip(
                  backgroundColor: Colors.grey.shade200,
                  label: Text('See all'),
                  onDeleted: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodesList())),
                  deleteIcon: Icon(Icons.keyboard_arrow_right, color: Colors.green),
                ),
              )
            ],
          ),
        ) : Container(),
      ],
    );
  }
}