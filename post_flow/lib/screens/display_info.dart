import 'package:flutter/material.dart';

class DisplayInfo extends StatelessWidget {

  late final String cardID;
  late final String surName;
  late final String lastName;
  late final String? matchNumber;
  late final Image imgID;

  DisplayInfo({required this.cardID, required this.surName, required this.lastName, required this.matchNumber, required this.imgID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.0),
                width: 250, // Set the desired width
                height: 200, // Set the desired height
                child: imgID,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'ชื่อ-นามสกุล: $surName $lastName',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'หมายเลขบัตร: $cardID',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'หมายเลข:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$matchNumber',
                  style: TextStyle(
                    fontSize: matchNumber != 'ไม่พบ' ? 60.0 : 15,
                    fontWeight: FontWeight.bold,
                    color: matchNumber != 'ไม่พบ' ? Colors.green[800] : Colors.red,
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