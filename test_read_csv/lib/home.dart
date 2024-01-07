import 'dart:async';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:convert' show utf8;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<List<dynamic>> csvData = [];

  @override
  void initState() {
    super.initState();
    loadCsvData();
  }

  Future<void> loadCsvData() async {
    final ByteData data = await rootBundle.load('assets/lottery_queue.csv');
    final List<int> bytes = data.buffer.asUint8List();
    final String content = utf8.decode(bytes);

    final List<List<dynamic>> csvTable = const CsvToListConverter(
      eol: '\n',
      fieldDelimiter: ',',
      textDelimiter: '"',
      shouldParseNumbers: false,
    ).convert(content);

    setState(() {
      csvData = csvTable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('CSV Viewer')),
      ),
      body: ListView(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildDataTable(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    if (csvData.isEmpty) {
      return const Center(child: Text('No data available.'));
    } else if (csvData.length == 1) {
      return const Center(child: Text('Only header available.'));
    } else {
      return DataTable(
        columns: _buildTableColumns(),
        rows: _buildTableRows(),
      );
    }
  }

  List<DataColumn> _buildTableColumns() {
    final firstRow = csvData.first;
    return firstRow.map((cellData) {
      return DataColumn(
        label: Text(
          cellData.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }).toList();
  }

  List<DataRow> _buildTableRows() {
    final dataRows = csvData.sublist(1).map((rowData) {
      return DataRow(
          cells: rowData.map((cellData) {
        return DataCell(
          Text(cellData.toString()),
        );
      }).toList());
    }).toList();
    return dataRows;
  }
}
