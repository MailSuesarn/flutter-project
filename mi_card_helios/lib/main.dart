import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Center(
            child: Text(
              'HELIOS',
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black45,
        body: const SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("images/mail.jpg"),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Suesarn Wilainuch',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'CHAIRMAN & CEO',
                style: TextStyle(
                  fontFamily: 'SourceCodePro',
                  fontSize: 8.0,
                  color: Colors.white70,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25.0,
                width: 150.0,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.black,
                    size: 22.0,
                  ),
                  title: Text(
                    '+66 7 561 7580',
                    style: TextStyle(
                      fontFamily: 'SourceCodePro',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.0,
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                    size: 22.0,
                  ),
                  title: Text(
                    'suesarn@helios.tech',
                    style: TextStyle(
                      fontFamily: 'SourceCodePro',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
