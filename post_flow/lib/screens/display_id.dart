import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:post_flow_test/screens/display_info.dart';
import 'package:provider/provider.dart';
import 'package:post_flow_test/models/csv_data.dart';
import 'package:thai_idcard_reader_flutter/thai_idcard_reader_flutter.dart';
import 'package:flutter/services.dart';

class DisplayID extends StatefulWidget {
  // CardData? cardData; // Initially, no card data
  @override
  State<DisplayID> createState() => _DisplayIDState();
}

class _DisplayIDState extends State<DisplayID> {
  StreamSubscription? subscription;
  UsbDevice? _device;
  String? _error;
  IDCardReader? _card;
  ThaiIDCard? _data;

  String cardID = '';
  String surName = '';
  String lastName = '';
  String? matchNumber = '';
  late Image imgID;

  @override
  void initState() {
    super.initState();
    // Lock the entire screen to portraitDown when entering the page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
    ]);
    ThaiIdcardReaderFlutter.deviceHandlerStream.listen(_onUSB);
  }



  void _onUSB(usbEvent) {
    try {
      // if reader connected and accepted permission to device.
      if (usbEvent.hasPermission) {
        // add subscription to listen to card insert to reader.
        subscription =
            ThaiIdcardReaderFlutter.cardHandlerStream.listen(_onData);
      } else {
        // if reader is disconnected. cancel listen to card from reader
        if (subscription == null) {
          subscription?.cancel();
          subscription = null;
        }
        _clear();
        setState(() {
          _device = usbEvent;
        });

      }

    } catch (e) {
      setState(() {
        _error = "_onUSB " + e.toString();
      });
    }
  }

  void _clear() {
    setState(() {
      _data = null;
    });
  }

  // @override
  // void dispose() {
  //   // Dispose of the subscription when the widget is disposed
  //   subscription?.cancel();
  //   super.dispose();
  // }

  @override
  void dispose() {
    super.dispose();
    // Allow all orientations when leaving the page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Dispose of the subscription when the widget is disposed
    subscription?.cancel();
    super.dispose();
  }



  void _onData(readerEvent) {
    try {
      setState(() {
        _card = readerEvent;
      });
      if (readerEvent.isReady) {
        // to read all data from ID card.
        readCard();

      } else {
        _clear();
      }
    } catch (e) {
      setState(() {
        _error = "_onData " + e.toString();
      });
    }
  }

// create function to read all data ID card if card has inserted to reader.
  readCard() async {
    try {
      var response = await ThaiIdcardReaderFlutter.read(only: [
        ThaiIDType.cid,
        ThaiIDType.photo,
        ThaiIDType.nameTH,
        ThaiIDType.nameEN,
        ThaiIDType.issueDate,
        ThaiIDType.expireDate,
      ]);
      setState(() {
        _data = response;
      });

      _handleCardData();


    } catch (e) {
      setState(() {
        _error = 'ERR readCard $e';
      });
    }
  }


  void _handleCardData() async {
    try {
      cardID = _data!.cid != null ? _data!.cid.toString() : 'Empty ID card';
      surName = _data!.firstnameTH != null ? _data!.firstnameTH.toString() : 'Empty firstname';
      lastName = _data!.lastnameTH != null ? _data!.lastnameTH.toString() : 'Empty lastname';
      imgID = _data!.photo != null ? Image.memory(Uint8List.fromList(_data!.photo)) : Image.asset('assets/empty_img');

      String normSurName = surName.trim().toLowerCase();
      String normLastName = lastName.trim().toLowerCase();

      String? matchNum = await Provider.of<CSVData>(context, listen: false).findMatchingNumber(cardSurname: normSurName, cardLastname: normLastName);

      if (matchNum == null){
        matchNum = 'ไม่พบ';
      }


      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DisplayInfo(cardID: cardID, surName: surName, lastName: lastName, matchNumber: matchNum, imgID: imgID),
      );
    } catch (e) {
      setState(() {
        _error = "Error: $e";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้รับ'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Please Insert ID card',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }
}


