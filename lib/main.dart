import 'dart:convert';

import 'package:annawithah/widgets/memsfilePicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:csv/csv.dart';
import 'dart:io';
void main()  {
  //   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FileReaderWidget(),
    );
  }
}
class FileReaderWidget extends StatelessWidget {
  Future<void> readCsv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

    if (result != null) {
      final bytes = result.files.first.bytes;
      if (bytes != null) {
        String csvString = utf8.decode(bytes);
        List<List<dynamic>> rows = CsvToListConverter().convert(csvString);

        for (var row in rows) {
          print(row);
        }
      }
    } else {
      print("User canceled the picker");
    }
  }

  Future<void> readExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);

    if (result != null) {
      final bytes = result.files.first.bytes;
      if (bytes != null) {
        var excel = Excel.decodeBytes(bytes);

        for (var table in excel.tables.keys) {
          print(table); // Sheet Name
          print(excel.tables[table]?.maxColumns);
          print(excel.tables[table]?.maxRows);

          for (var row in excel.tables[table]!.rows) {
            print('$row');
          }
        }
      }
    } else {
      print("User canceled the picker");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: readCsv,
            child: Text('Read CSV File'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: readExcel,
            child: Text('Read Excel File'),
          ),
        ],
      ),
    );
  }
}