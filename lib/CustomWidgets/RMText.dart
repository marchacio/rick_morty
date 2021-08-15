import 'package:flutter/material.dart';

///Custom Rick and Morty font text
///
///Nascosto dal git per evitare copie
class RMText extends StatelessWidget {
  
  final String text;
  final double textScaleFactor;
  final TextAlign textAlign;
  final int? maxLines;

  RMText(this.text, {
    this.textScaleFactor = 1,
    this.textAlign = TextAlign.center,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Solid text as fill.
        Text(
          text,
          textScaleFactor: textScaleFactor,
          textAlign: textAlign,
          maxLines: maxLines,
          style: TextStyle(
            color: Color.fromARGB(255, 34, 162, 189),
            fontFamily: 'Titles',
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: Color.fromRGBO(122, 249, 68, 1),
                offset: Offset(0, 0),
              ),
              Shadow(
                blurRadius: 7.0,
                color: Color.fromRGBO(122, 249, 68, 1),
                offset: Offset(0, 0),
              ),
              Shadow(
                blurRadius: 7.0,
                color: Color.fromRGBO(122, 249, 68, 1),
                offset: Offset(0, 0),
              ),
              
            ],
          ),
        ),

        Text(
          text,
          textScaleFactor: textScaleFactor,
          textAlign: textAlign,
          maxLines: maxLines,
          style: TextStyle(
            fontFamily: 'Titles',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.6
              ..color = Colors.black,
          ),
        ),
      ],
    );
  }
}