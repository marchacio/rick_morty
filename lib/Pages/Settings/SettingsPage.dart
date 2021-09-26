import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rick_morty/CustomWidgets/RMText.dart';
import 'package:url_launcher/url_launcher.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Info'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(delegate: SliverChildListDelegate([
            SizedBox(height: 30),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: RMText('Marchacio', textAlign: TextAlign.center, textScaleFactor: 4.5),
              ),
            ),

            SizedBox(height: 20),

            ListTile(
              title: Text('Play Store page'),
              onTap: () => launch('https://play.google.com/store/apps/dev?id=6226476728918357054&hl=it&gl=US'),
              trailing: Icon(FontAwesomeIcons.googlePlay),
            ),

            ListTile(
              title: Text('Instagram page'),
              onTap: () => launch('https://www.instagram.com/marchacio/?hl=it'),
              trailing: Icon(FontAwesomeIcons.instagram),
            ),

            Divider(),

            ListTile(
              title: Text('Contribute on GitHub'),
              subtitle: Text('This app is completely opensource ;)'),
              onTap: () => launch('https://github.com/marchacio/rick_morty'),
              trailing: Icon(FontAwesomeIcons.github),
            ),


            SizedBox(height: 50),
            
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text('''This app is in full development by the developer "Marchacio".

It was made for educational and play purposes only, but if you want to contribute in your own way, you can find the code on GitHub and improve it!

Thank you, Marchacio <3''',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )


          ]))
        ],
      ),
    );
  }
}