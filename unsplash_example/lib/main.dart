import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchTerm = '';
  String _backgroundImageUrl = '';

  Future<void> _fetchImages() async {
    final accessKey = 'uRKKeDtBOfqtdN2FWykohK8WtIo6Xv4spP7ogG0pzu0'; // Replace with your Unsplash Access Key
    final response = await http.get(
      Uri.parse('https://api.unsplash.com/search/photos?query=$_searchTerm&client_id=$accessKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final imageList = data['results'] as List<dynamic>;
      if (imageList.isNotEmpty) {
        final imageUrl = imageList[0]['urls']['regular'].toString();

        setState(() {
          _backgroundImageUrl = imageUrl;
        });
      }
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _backgroundImageUrl.isNotEmpty
              ? DecorationImage(
            image: NetworkImage(_backgroundImageUrl),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search for images',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _fetchImages,
                  ),
                ),
              ),
            ),
            // Your other widgets...
          ],
        ),
      ),
    );
  }
}
