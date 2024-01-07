import 'package:flutter/material.dart';
import 'package:post_flow_test/models/csv_data.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CSVData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Post Flow',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
      ),
    );
  }
}

