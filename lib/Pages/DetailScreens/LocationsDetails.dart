import 'package:flutter/material.dart';
import 'package:rick_morty/API/Classes/Character.dart';
import 'package:rick_morty/API/Classes/Location.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:rick_morty/RXDart/Constants.dart';

import 'CharacterDetails.dart';

class LocationDetails extends StatelessWidget {

  final Location location;

  const LocationDetails(this.location, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([
            SizedBox(height: MediaQuery.of(context).padding.top),

            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(color: Colors.grey.shade700),
            ),
            
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: RMText(location.name, textScaleFactor: 3),
              ),
            ),

            if(location.dimension != null) ListTile(
              title: Text(location.dimension!),
              subtitle: Text('Dimension'),
            ),

            if(location.type != null) ListTile(
              title: Text(location.type!),
              subtitle: Text('Type'),
            ),

            Column(
              children: <Widget>[
                Divider(color: Colors.transparent),

                ListTile(title: Text('Location residences:', style: TextStyle(color: Colors.grey)))
              ] + List<Widget>.generate(
                lists.characters.where((element) => (location.residents ?? []).contains(element.url)).length, 
                (index) {
                  Character _char = lists.characters.where((element) => (location.residents ?? []).contains(element.url)).toList()[index];

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
          ]))
        ],
      ),
    );
  }
}