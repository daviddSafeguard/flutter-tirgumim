import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tirgumim/UI/fullTable.dart';
import 'package:tirgumim/UI/serverDataTable/paginatedDataTable.dart';
import 'package:tirgumim/UI/translatePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('he'), // Hebrew
      ],
      locale: Locale('he'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'אפליקצית שפות'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          bottom: TabBar(
            tabs: [
              Tab(text: 'פר תמונה'),
              Tab(text: 'טבלה כוללת'),
              Tab(text: 'טבלת שרת'),
            ],
          ),
          title: Text(title),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            TranslatePage(),
            FullTable(),
            ServerDataTable(),
          ],
        ),
      ),
    );
  }
}
