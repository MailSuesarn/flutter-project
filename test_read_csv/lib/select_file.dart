import 'dart:async';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:file_picker/file_picker.dart';
import 'dart:convert' show utf8, base64;


class ImportCSV extends StatefulWidget {

  @override
  State<ImportCSV> createState() => _ImportCSVState();
}

class _ImportCSVState extends State<ImportCSV>  {
  late List<List<dynamic>> csvData = [];
  bool _userSelectedFile = false;

  Future<void> pickCSVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      List<String> lines = file.bytes!.map((byte) => byte.toString()).toList();

      final List<List<dynamic>> csvTable = const CsvToListConverter(
        eol: '\n',
        fieldDelimiter: ',',
        textDelimiter: '"',
        shouldParseNumbers: false,
      ).convert(lines.join('\n'));

      setState(() {
        csvData = csvTable;
        _userSelectedFile = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
