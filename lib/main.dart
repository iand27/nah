import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:maimuna/models/note_data.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() async {
  // inisialisasi hive
  await Hive.initFlutter();

  // buka box hive
  await Hive.openBox('note_database');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SFPro',
        ),
        home: HomePage(),
      ),
    );
  }
}
