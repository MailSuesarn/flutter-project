import 'package:flutter/material.dart';
import 'display_file.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../models/csv_data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text('Post Flow')),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Import file here',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    await Provider.of<CSVData>(context, listen: false)
                        .selectCSV();

                    setState(() {
                      showSpinner = false;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DisplayCSV()),
                    );
                  },
                  child: Text('Pick CSV File'),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.0), // Adjust padding as needed
                child: Center(
                  child: Text(
                    'Powered by Helios',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.grey, // Customize the color as needed
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
