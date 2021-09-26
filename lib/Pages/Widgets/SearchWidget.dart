
import 'package:flutter/material.dart';
import 'package:rick_morty/Pages/SearchPage/SearchPage.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage())),
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Search...', style: TextStyle(color: Colors.grey.shade700)),

              Icon(Icons.search, color: Colors.grey.shade700),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }
}