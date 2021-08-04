import 'package:flutter/material.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/Pages/DetailScreens/EpisodeDetails.dart';
import 'package:rick_morty/RXDart/Constants.dart';


class EpisodesList extends StatelessWidget {
  const EpisodesList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          SliverList(delegate: SliverChildListDelegate([
            Stack(
              alignment: Alignment.topLeft,
              children: [

                Column(
                  children: [
                    Image.asset('Assets/Images/avatar1.png', scale: 4,),

                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Center(child: RMText('All episodes', textScaleFactor: 3, textAlign: TextAlign.center)),
                    ),
                  ],
                ),

                BackButton(),
              ],
            )
          ])),

          SliverList(delegate: SliverChildBuilderDelegate(
            (context, int n) => ListTile(
              title: Text(lists.episodes[n].name),
              trailing: Icon(Icons.keyboard_arrow_right),
              subtitle: Text(lists.episodes[n].episode ?? ''),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeDetails(lists.episodes[n]))),
            ),
            childCount: lists.episodes.length,
          ))
        ],
      )
    );
  }
}
