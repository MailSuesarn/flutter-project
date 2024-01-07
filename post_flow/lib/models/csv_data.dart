import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'dart:collection';

class CSVData extends ChangeNotifier {
  List<List<dynamic>> _readData = [];

  Map<String, String> _nameToNumberMap = {};

  Future<List<List<dynamic>>> _handlePickCSV() async {
    FilePickerResult? result;

    try {
      result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result == null || result.files.isEmpty) {
        return [];
      }

      PlatformFile file = result.files.first;
      List<int> bytes = file.bytes!;

      try {
        String content = utf8.decode(bytes);
        // Process the CSV content
        print(content);

        final List<List<dynamic>> csvTable = const CsvToListConverter(
          eol: '\n',
          fieldDelimiter: ',',
          textDelimiter: '"',
          shouldParseNumbers: false,
        ).convert(content);

        return csvTable;
      } catch (e) {
        print('Error decoding the CSV file content: $e');
        return [];
      }
    } catch (e) {
      print('Error picking or reading the CSV file: $e');
      return [];
    }
  }

  Future<void> selectCSV() async {
    List<List<dynamic>> csvTable = await _handlePickCSV();

    _readData = csvTable;
    _nameToNumberMap = buildNameToNumberMap();
    notifyListeners();
  }

  UnmodifiableListView<dynamic>? get csvData {
    return UnmodifiableListView(_readData);
  }

  Widget buildDataTable() {
    if (_readData.isEmpty) {
      return const Center(child: Text('No data available.'));
    } else if (_readData.length == 1) {
      return const Center(child: Text('Only header available.'));
    } else {
      return DataTable(
        columns: buildTableColumns(),
        rows: buildTableRows(),
      );
    }
  }

  List<DataColumn> buildTableColumns() {
    final firstRow = _readData.first;
    return firstRow.map((cellData) {
      return DataColumn(
        label: Text(
          cellData.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }).toList();
  }

  List<DataRow> buildTableRows() {
    final dataRows = _readData.sublist(1).map((rowData) {
      return DataRow(
          cells: rowData.map((cellData) {
        return DataCell(
          Text(cellData.toString()),
        );
      }).toList());
    }).toList();
    return dataRows;
  }

  // Function to build and return the name-to-number mapping
  Map<String, String> buildNameToNumberMap() {
    Map<String, String> nameToNumberMap = {};
    for (int i = 1; i < _readData.length; i++) {
      if (_readData[i].length >= 5) {
        String surname = _readData[i][3].toString().trim().toLowerCase();
        String lastname = _readData[i][4].toString().trim().toLowerCase();
        String number = _readData[i][1].toString();

        // Combine surname and lastname to create a unique key
        String key = '$surname $lastname';

        // Store the number in the map with the combined key
        nameToNumberMap[key] = number;
      }
    }
    return nameToNumberMap;
  }

  // Function to find a matching name and return the corresponding number
  String? findMatchingNumber(
      {required String cardSurname, required String cardLastname}) {
    // Normalize the card reader surname and lastname
    String normalizedCardSurname = cardSurname.trim().toLowerCase();
    String normalizedCardLastname = cardLastname.trim().toLowerCase();

    // Combine the card surname and lastname to create a unique key
    String key = '$normalizedCardSurname $normalizedCardLastname';

    if (_nameToNumberMap.containsKey(key)) {
      return _nameToNumberMap[key];
    } else {
      return null;
    }
  }
}
