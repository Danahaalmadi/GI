import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Notch Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    HomePage(), // Replace Page1 with HomePage
    const Page2(),
    const Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color:Color.fromARGB(255, 199, 86, 237),
              showLabel: false,
              notchColor: Color.fromARGB(255, 237, 91, 86),
              

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.black,
                  ),
                  itemLabel: 'Page 1',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.bar_chart,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.bar_chart,
                    color: Colors.black,
                  ),
                  itemLabel: 'Page 2',
                ),
               
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  itemLabel: 'Page 3',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}
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
 String filePath = 'path_to_your_file';
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

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 11')));
  }
}


  
