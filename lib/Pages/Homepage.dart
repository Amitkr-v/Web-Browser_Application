import 'dart:convert';
import 'package:browser/Pages/ChatPage.dart';
import 'package:flutter/material.dart';
import 'package:browser/Pages/Searchbox.dart';
import 'package:browser/Pages/Browser.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quote = "Fetching quote...";
  final List<String> _imagePaths = [
    'assets/images/bg.jpg',
    'assets/images/bg1.jpg',
    'assets/images/bg2.jpg',
    'assets/images/bg3.jpg',
    'assets/images/bg4.jpg',
    'assets/images/bg5.jpg',
    'assets/images/bg6.jpg',
    'assets/images/bg7.jpg',
    'assets/images/bg8.jpg',
    'assets/images/bg9.jpg',
    'assets/images/bg10.jpg',
    'assets/images/bg11.jpg',
    'assets/images/bg12.jpg',
  ];

  late List<String> _selectedImages = [];

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  String selectedSearchEngineBase = 'https://www.google.com/search?q=';

  Future<void> fetchRandomQuote() async {
    const url = 'https://dummyjson.com/quotes/random';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decode the JSON
        setState(() {
          quote = data['quote']; // Extract the "quote" field
        });
      } else {
        setState(() {
          quote = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        quote = "Failed to fetch quote.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRandomImages();
    fetchRandomQuote();
  }

  void _loadRandomImages() {
    final random = Random();
    final selectedIndices = <int>{};

    while (selectedIndices.length < 7) {
      selectedIndices.add(random.nextInt(_imagePaths.length));
    }

    _selectedImages =
        selectedIndices.map((index) => _imagePaths[index]).toList();
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching; // Toggle search mode
      if (isSearching) {
        searchFocusNode.requestFocus(); // Focus on the search field
      } else {
        searchController.clear(); // Clear the search field when exiting
        searchFocusNode.unfocus(); // Dismiss the keyboard
      }
    });
  }

  void _showSearchEngineDialog(String query) {
  final searchEngines = [
    {
      'name': 'Google',
      'base': 'https://www.google.com/search?q=',
      'icon': 'assets/images/google.png', // Path to Google icon
    },
    {
      'name': 'Bing',
      'base': 'https://www.bing.com/search?q=',
      'icon': 'assets/images/bing.png', // Path to Bing icon
    },
    {
      'name': 'DuckDuckGo',
      'base': 'https://duckduckgo.com/?q=',
      'icon': 'assets/images/duckduckgo.png', // Path to DuckDuckGo icon
    },
  ];

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 89, 89, 89), // Dark grey background
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0), // Top-left corner curve
            topRight: Radius.circular(16.0), // Top-right corner curve
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: searchEngines.map((engine) {
            return ListTile(
              leading: Image.asset(
                engine['icon']!, // Load the respective search engine icon
                width: 24.0,
                height: 24.0,
              ),
              title: Text(
                engine['name']!,
                style: const TextStyle(
                  color: Colors.white, // Make text color white
                ),
              ),
              onTap: () {
                setState(() {
                  selectedSearchEngineBase = engine['base']!;
                });
                Navigator.pop(context); // Close the dialog
                _navigateToBrowser(query);
              },
            );
          }).toList(),
        ),
      );
    },
  );
}

  void _navigateToBrowser(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimpleWebBrowser(
          url: selectedSearchEngineBase + Uri.encodeQueryComponent(query),
          searchEngineBase: selectedSearchEngineBase,
        ),
      ),
    );
  }

  void handleSearch(String query) {
    if (query.isNotEmpty) {
      _showSearchEngineDialog(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            if (_selectedImages.isNotEmpty)
              Positioned.fill(
                child: Image.asset(
                  _selectedImages[0], // Access the first image in the list
                  fit: BoxFit.cover,
                ),
              ),
            if (!isSearching)
              if (isSearching)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: handleSearch,
                  ),
                ),
            SearchBox(
              searchController: searchController,
              searchFocusNode: searchFocusNode,
              onSubmitted: handleSearch,
            ),
            Positioned(
              left: 28,
              top: 120,
              right: 28,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(
                        255, 216, 238, 255), // Border color
                    width: 1.2, // Border width
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(8)), // Optional: rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Call('assets/images/youtube.png', 'YouTube',
                                'https://www.youtube.com', context),
                            Call('assets/images/linkedin.png', 'LinkedIn',
                                'https://www.linkedin.com', context),
                            Call('assets/images/netflix.png', 'Netflix',
                                'https://www.netflix.com', context),
                            Call('assets/images/wikipedia.png', 'Wikipedia',
                                'https://www.wikipedia.org', context),
                            Call('assets/images/instagram.png', 'Instagram',
                                'https://www.instagram.com', context),
                            Call('assets/images/twitter.png', 'Twitter',
                                'https://www.twitter.com', context),
                            Call('assets/images/dribbble.png', 'Dribbble',
                                'https://www.dribbble.com', context),
                            Call('assets/images/amazon.png', 'Amazon.in',
                                'https://www.amazon.in', context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 50,
                left: 28,
                right: 20,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        onTap:
                            fetchRandomQuote, // Trigger fetching new quote when tapped
                        child: Text(
                          quote,
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 180, 180, 180),
                            
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Optional: Show some loading indicator while fetching
                      if (quote == "Fetching a new quote...")
                        CircularProgressIndicator(),
                    ],
                  ),
                ))
          ],
        ),
        bottomNavigationBar: Container(
          // Adjust height as needed
          color: Colors.black,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: 30), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: 30), label: ''),
            ],
            currentIndex: 0,
            selectedItemColor: Colors.blue,
            unselectedItemColor:
                Colors.white, // Optional: make unselected icons white
            backgroundColor: Colors.black,
            onTap: (index) {
              if (index == 0) {
                setState(() {
                  isSearching = false;
                });
              } else if (index == 1) {
                toggleSearch(); // Toggle search on tapping the search icon
              } else if (index == 2) {
                // Navigate to ChatPage on tapping smart_toy
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SimpleWebBrowser(
                      url: "https://chat.openai.com/",
                      searchEngineBase: 'https://www.google.com/search?q=',
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Padding Call(String image, String name, String url, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SimpleWebBrowser(
                url: url,
                searchEngineBase: 'https://www.google.com/search?q=',
              ),
            ),
          );
        },
        child: Column(
          children: [
            Image.asset(
              image,
              width: 40,
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                name,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
