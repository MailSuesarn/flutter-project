import 'package:flutter/material.dart';
import 'display_id.dart';
import '../models/csv_data.dart';
import 'package:provider/provider.dart';

class DisplayCSV extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.login,
                  // color: const Color(0xFF0000FF),
                  size: 34.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DisplayID()),
                );

              }),
        ],
        title: Text('รายชื่อผู้รับ'),
      ),
      body: ListView(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Provider.of<CSVData>(context, listen: false).buildDataTable(),
            ),
          ),
        ],
      ),
    );
  }
}
