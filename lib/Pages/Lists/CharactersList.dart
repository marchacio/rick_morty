import 'package:flutter/material.dart';
import 'package:rick_morty/Pages/DetailScreens/CharacterDetails.dart';
import 'package:rick_morty/RXDart/Constants.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            AspectRatio(
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
                  alignment: Alignment.topLeft,
                  child: BackButton(),
                ),
              ) 
            )
          ])),

          SliverList(delegate: SliverChildBuilderDelegate(
            (context, int n) => ListTile(
              title: Text(lists.characters[n].name),
              subtitle: Text(lists.characters[n].species ?? ''),
              trailing: Hero(
                tag: lists.characters[n].id,
                child: ClipOval(
                  child: Image.network(lists.characters[n].image
                    ?? 'https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/55/6c/3d/556c3db2-a149-332e-7e6e-a490f7b00f0c/source/256x256bb.jpg'),
                ),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetails(lists.characters[n]))),
            ),
            childCount: lists.characters.length,
          ))
        ],
      )
    );
  }
}