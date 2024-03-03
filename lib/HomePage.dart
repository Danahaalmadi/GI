
 import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';




class HomePage extends StatefulWidget {
    HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  // Dummy search results for demonstration
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
  void _launchMaps() async {
  // Specify the latitude and longitude of the location you want to display
  final latitude = '37.7749';
  final longitude = '-122.4194';

  // Create the URL with the latitude and longitude
  final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  // Check if the URL can be launched
  if (await canLaunch(url)) {
    // Launch the URL
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
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
                  hintText: 'Location Name',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0.1),
                    child: GestureDetector(
                      onTap: () {
                        // Handle filter icon tap
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
                          width: 44,
                          height: 44,
                          child: GestureDetector(
                            onTap: () {
                            _launchMaps();
                            },
                            child: Image.asset('Assets/location.png'),
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