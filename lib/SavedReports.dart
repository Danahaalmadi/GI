import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'HomePage.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
 String _searchText = '';
  List<String> _searchResults = [];

  void _search() {
    // Perform search based on _searchText
    // For example, here we're just adding some dummy results
    setState(() {
      _searchResults = [
        'Result 1 for $_searchText',
        'Result 2 for $_searchText',
        'Result 3 for $_searchText',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D1617).withOpacity(0.11),
      appBar: appBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff1D1617).withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0,
                )
              ],
            ),
            child: SizedBox(
              width: 400,
              height: 50,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                _searchText = value;
              });
                },
                onSubmitted: (value) {
                  _search();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Report Name',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0.1),
                    child: GestureDetector(
                      onTap: () {
                        print("filtering..");
                      },
                      child: Transform.scale(
                        scale: 0.5,
                        child: Image.asset('Assets/filter.png'),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length, // Set itemCount to the length of searchResults
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_searchResults[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: GestureDetector(
                            onTap: () {
                              print("to report");
                            },
                            child: Image.asset('Assets/menu.png'),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          // back to home page
        },
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
      ),
      title: Text('Saved Locations', style: TextStyle(color: Colors.white)),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C3FE4), Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}